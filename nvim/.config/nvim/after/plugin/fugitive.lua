vim.keymap.set("n", "<leader>gs", ":G<CR>")
vim.keymap.set("n","<leader>gj", ":diffget //3<CR>")
vim.keymap.set("n","<leader>gf", ":diffget //2<CR>")
vim.keymap.set("n","<leader>gs", ":G<CR>")
vim.keymap.set("n"," <leader>ga", ":Git fetch --all -p<CR>")
vim.keymap.set("n"," <leader>gl", ":Git pull<CR>")
vim.keymap.set("n"," <leader>gpp", ":Git push<CR>")
vim.keymap.set("n"," <leader>gpo", ":Git push -u origin HEAD<CR>")

vim.g.mkdp_browser = 'chrome'