local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  vim.notify("nvim-lspconfig not found!")
	return
end

local lspconfig = require("lspconfig")

lsp_installer.setup({
	ensure_installed = { "jsonls", "sumneko_lua", "clangd" },
})

for _, server in ipairs(lsp_installer.get_installed_servers()) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

  if server.name == "sumneko_lua" then
    opts.root_dir = lspconfig.util.root_pattern(".luarc.json", ".git")
  end

	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server.name)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server.name].setup(opts)
end

local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'single'
  return opts
end

