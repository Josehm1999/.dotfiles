vim.cmd([[packadd packer.nvim]])
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

return require("packer").startup(function(use)
	local local_use = function(first, second, opts)
		opts = opts or {}

		local plug_path, home
		if second == nil then
			plug_path = first
			home = "josehm"
		else
			plug_path = second
			home = first
		end

		if vim.fn.isdirectory(vim.fn.expand("~/plugins/" .. plug_path)) == 1 then
			opts[1] = "~/plugins/" .. plug_path
		else
			opts[1] = string.format("%s/%s", home, plug_path)
		end

		use(opts)
	end

	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	})
	use("p00f/nvim-ts-rainbow")
	use("moll/vim-bbye")

	-- Tabs
	use("akinsho/bufferline.nvim")
	use("nvim-lualine/lualine.nvim")

	-- Nvim-tree
	use("kyazdani42/nvim-tree.lua")

	-- Toggleterm
	use("akinsho/toggleterm.nvim")

	-- Commenting 
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Client for DB connections
	use({
		"kristijanhusak/vim-dadbod-ui",
		 requires = {
			"tpope/vim-dadbod",
			"tpope/vim-dotenv",
			"kristijanhusak/vim-dadbod-completion",
		 },
	 })

	-- Git
	use("tpope/vim-fugitive")
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"windwp/nvim-autopairs",
		},
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{"nvim-lua/popup.nvim"},
			{"nvim-lua/plenary.nvim"},
			{"nvim-telescope/telescope-fzy-native.nvim"},
			{"kyazdani42/nvim-web-devicons"},
			{"nvim-telescope/telescope-file-browser.nvim"},
			{"nvim-telescope/telescope-dap.nvim"},
			{"nvim-telescope/telescope-ui-select.nvim"},
			{"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
		}
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"jose-elias-alvarez/null-ls.nvim",
	})

  -- Theme gruvbox
  use('gruvbox-community/gruvbox')

end)
