local status_ok, aerial = pcall(require, "aerial")
if not status_ok then
    return
end

aerial.setup({
    backends = { "treesitter", "lsp", "markdown" },
    layout = {
        min_width = 50,
    },
    -- close_behavior = "auto",
    close_on_select = true,
    show_guides = true,
})

require("telescope").load_extension('aerial')
