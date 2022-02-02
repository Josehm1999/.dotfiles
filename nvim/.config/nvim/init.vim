set path+=**

" Ignore files
call plug#begin('~/.vim/plugged')

"Devicons
Plug 'kyazdani42/nvim-web-devicons'

"Autopairs
Plug 'jiangmiao/auto-pairs'

" Nerdtree
Plug 'preservim/nerdtree'

" Tmux - vim
Plug 'christoomey/vim-tmux-navigator'

"Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }

"Buffer Navigation
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

"Lsp
Plug 'neovim/nvim-lspconfig'
"Lsp-completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

"Git
Plug 'tpope/vim-fugitive'


"Prettier
Plug 'sbdchd/neoformat'

"Theme gruvbox
Plug 'gruvbox-community/gruvbox'
call plug#end()

"Theme config
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" Buffer navigation
" TODO
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='onedark'

"Lsp Config -- its here because i don't know how to do it in lua
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let mapleader = " "

" NERDTreeToggle
map <C-n> :NERDTreeToggle<CR>

" To move through quickfilelist
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>


" To move through buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bf :bfirst<CR>
nnoremap <leader>bl :blast<CR>
nnoremap <leader>q :bdelete<CR>
nnoremap <leader>w :write<CR>

lua require("josehm")
" Sources lua files a init.vim
nnoremap <F4> :lua package.loaded.josehm = nil<cr>:source ~/.config/nvim/init.vim <cr>

fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup JoseHM
    autocmd!
    " autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>
    autocmd BufWritePre *.js Neoformat
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup END
