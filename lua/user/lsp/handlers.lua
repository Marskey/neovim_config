local M = {}

-- TODO: backfill this to template
M.setup = function()
  -- local signs = {
  -- 	{ name = "DiagnosticSignError", text = " " },
  -- 	{ name = "DiagnosticSignWarn", text = " " },
  -- 	{ name = "DiagnosticSignHint", text = " " },
  -- 	{ name = "DiagnosticSignInfo", text = " " },
  -- }
  --
  -- for _, sign in ipairs(signs) do
  -- 	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  -- end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    -- signs = {
    -- 	active = signs,
    -- },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded"
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded"
  })

  local location_handler = vim.lsp.handlers["textDocument/definition"]
  vim.lsp.handlers["textDocument/definition"] = function(err, result, ctx, config)
    if result == nil or vim.tbl_isempty(result) then
      local posParam = vim.lsp.util.make_position_params()
      if posParam.textDocument.uri == ctx.params.textDocument.uri
          and posParam.position.character == ctx.params.position.character
          and posParam.position.line == ctx.params.position.line then
        vim.lsp.util.open_floating_preview({ "No location found!" }, 'markdown', { border = "rounded", focus = false })
      end
      return nil
    end

    location_handler(err, result, ctx, config)
  end
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    vim.notify('illuminate not found!')
    return
  end
  illuminate.on_attach(client)
  -- end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
    opts
  )
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format{async=true}' ]])
end

M.on_attach = function(client, bufnr)
  -- vim.notify(client.name .. " starting...")
  -- TODO: refactor this into a method that checks if string in list
  -- if client.name == "tsserver" then
  -- 	client.resolved_capabilities.document_formatting = false
  -- end
  lsp_keymaps(bufnr)
  -- lsp_highlight_document(client)

  require("aerial").on_attach(client, bufnr)
  require("lsp_signature").on_attach()
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities()

return M
