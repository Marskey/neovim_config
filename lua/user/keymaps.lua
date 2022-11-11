local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<SPACE>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Navigate buffers
keymap("n", "<C-l>", ":bnext<CR>", opts)
keymap("n", "<C-h>", ":bprevious<CR>", opts)

keymap("", "<leader>y", "\"+y", opts)
keymap("", "<leader>p", "\"+p", opts)
keymap("", "<leader>Y", "\"+Y", opts)
keymap("", "<leader>P", "\"+P", opts)
keymap("n", "*", ":let @/= '\\<' . expand('<cword>') . '\\>' <bar> set hls <cr>", opts)

-- keymap("i", "<C-f>", "<RIGHT>", opts)
-- keymap("i", "<C-b>", "<LEFT>", opts)

if not vim.env.ITERM then
    keymap('i', '<D-v>', "<C-R>+", opts)

    if vim.g.neovide == true then
        keymap('', '<C-D-f>', ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", opts)
    end
end
