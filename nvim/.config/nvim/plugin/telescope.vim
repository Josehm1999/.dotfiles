lua require("josehm")

nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
" nnoremap <C-_> <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.theme').get) <CR>
nnoremap <C-_> :lua require('josehm.telescope').curr_buff() <CR>
nnoremap <leader>pf :lua require('telescope.builtin').find_files({hidden =true})<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>")}<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>dl :lua require('telescope.builtin').diagnostics()<CR>
nnoremap <leader>vrc :lua require('josehm.telescope').search_dotfiles()<CR>
nnoremap <leader>gc :lua require('josehm.telescope').git_branches()<CR>
