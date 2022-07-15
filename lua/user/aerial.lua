local status_ok, aerial = pcall(require, "aerial")
if not status_ok then
  return
end

aerial.setup({
  backends = {"treesitter", "lsp", "markdown"},
  close_behavior = "auto",
  show_guides = true,
})
