-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "jk", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- keymap.set("t", "jk", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
