vim.g.mapleader = " "

vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true });

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")


vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
