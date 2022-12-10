local keymap = require("josehm.keymap")

local nnoremap = keymap.nnoremap;

vim.g.mapleader = " "
nnoremap("<leader>e", "<cmd>Ex<CR>"); 
