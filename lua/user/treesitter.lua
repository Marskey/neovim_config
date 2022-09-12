local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

local function ts_disable(_, bufnr)
    return vim.api.nvim_buf_line_count(bufnr) > 5000
end

configs.setup({
    ensure_installed = { "c", "lua" },
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = function(lang, bufnr)
            return lang == "css" or ts_disable(lang, bufnr)
        end
    },
    autopairs = {
        enable = true,
    },
    indent = {
        enable = false,
        disable = { "python", "css" }
    },
    additional_vim_regex_highlighting = false,
})
