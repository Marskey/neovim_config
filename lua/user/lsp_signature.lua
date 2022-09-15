local status_ok, lsp_signature = pcall(require, "lsp_signature")
if not status_ok then
    return
end

lsp_signature.setup({
    close_timeout = 1000,
    hint_enable = false
})
