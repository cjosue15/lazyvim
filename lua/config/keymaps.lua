-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("n", "<C-j>", "<C-d>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-u>", { noremap = true })
