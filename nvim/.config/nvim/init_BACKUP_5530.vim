set path+=**

call plug#begin('~/.vim/plugged')

"Devicons
Plug 'kyazdani42/nvim-web-devicons'

"Toggleterm
Plug 'akinsho/toggleterm.nvim'

"Autopairs
Plug 'windwp/nvim-autopairs'
" Plug 'jiangmiao/auto-pairs'

" Nvim-tree
Plug 'kyazdani42/nvim-tree.lua'

"Commenting
Plug 'numToStr/Comment.nvim'
"Plug 'JoosepAlviste/nvim-ts-context-commentstring'

"Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/nvim-treesitter-angular' "Treesitter integration with Angular
Plug 'p00f/nvim-ts-rainbow'
"Plug 'nvim-treesitter/playground'
Plug 'akinsho/bufferline.nvim'
Plug 'moll/vim-bbye'
Plug 'nvim-lualine/lualine.nvim'

"Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

"Telescope media files
" Plug 'nvim-telescope/telescope-media-files.nvim'

"Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'antoinemadec/FixCursorHold.nvim' "This is needed to fix lsp doc highlight
Plug 'jose-elias-alvarez/null-ls.nvim'

" For highlighting current line
Plug 'RRethy/vim-illuminate'

" Cmp plugins
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lua'

" CMP-tabnine
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
"Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

"Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

<<<<<<< HEAD
"Dabbod-ui - Client for DB connections
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dotenv'
Plug 'kristijanhusak/vim-dadbod-ui'

"vim-inspector -Debugging
Plug 'puremourning/vimspector'
=======
"Solidity syntax
Plug 'tomlion/vim-solidity'
>>>>>>> 89e1308d3a9d96d465d4392614f0f1131d035210
"Prettier
"Plug 'sbdchd/neoformat'

"Theme gruvbox
Plug 'gruvbox-community/gruvbox'
call plug#end()

"Theme config
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
let g:gruvbox_italicize_strings = 1
"Lsp Config -- its here because i don't know how to do it in lua
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let g:vimspector_enable_mappings = "HUMAN"

" lua require("josehm")
" Sources lua files a init.vim
nnoremap <leader>r :lua package.loaded.josehm = nil<cr>:source ~/.config/nvim/init.vim <cr>

fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

  augroup JoseHM
    autocmd!
    autocmd BufNewFile,BufRead *.cshtml set syntax=html
    autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup END
