local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    git = {
        clone_timeout = 300, -- Timeout, in seconds, for git clones
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use({ "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" }) -- Have packer manage itself
    use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" }) -- Useful lua functions used by lots of plugins
    use({ "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" }) -- Autopairs, integrates with both cmp and treesitter
    use({ "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" })
    use({ "JoosepAlviste/nvim-ts-context-commentstring" })
    use({ "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" })
    -- use {
    --     'nvim-tree/nvim-tree.lua',
    -- requires = {
    --     'nvim-tree/nvim-web-devicons', -- optional
    --     },
    -- }
    use({ "akinsho/bufferline.nvim", commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4" })
    use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
    use({ "nvim-lualine/lualine.nvim", commit = "a52f078026b27694d2290e34efa61a6e4a690621" })
    use({ "akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" })
    use({ "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" })
    use({ "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" })
    use({ "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" })
    use({ "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" })
    use({ "b0o/schemastore.nvim" })
    use({
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end,
    })

    -- Colorschemes
    use({ "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" })
    use({ "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" })
    use({ "catppuccin/nvim", as = "catppuccin" })                                         -- cmp plugins

    use({ "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" })      -- The completion plugin
    use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })    -- buffer completions
    use({ "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" })      -- path completions
    use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
    use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
    use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

    -- snippets
    use({ "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" })          --snippet engine
    use({ "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }) -- a bunch of snippets to use

    -- LSP
    -- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
    use({ "neovim/nvim-lspconfig" }) -- enable LSP
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    use({ "WhoIsSethDaniel/mason-tool-installer.nvim" })
    use({ "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" }) -- for formatters and linters
    use({ "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" })
    use({ "nvim-treesitter/nvim-treesitter-context" })
    use({ "simrat39/inlay-hints.nvim" })

    use({ "simrat39/rust-tools.nvim" })
    use({
        "saecki/crates.nvim",
        tag = "v0.3.0",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup({
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                },
                popup = {
                    border = "rounded",
                },
            })
        end,
    })

    use({ "Hoffs/omnisharp-extended-lsp.nvim" })

    use({ "windwp/nvim-ts-autotag" })
    use({ "jose-elias-alvarez/typescript.nvim" })
    use({ "onsails/lspkind-nvim" })
    use({
        "kevinhwang91/nvim-ufo",
        opt = true,
        event = { "BufReadPre" },
        wants = { "promise-async" },
        requires = "kevinhwang91/promise-async",
        disable = false,
    }) -- LSP Based folding

    -- Telescope
    use({ "nvim-telescope/telescope.nvim" })
    use({ "nvim-telescope/telescope-media-files.nvim" })
    use({ "nvim-telescope/telescope-ui-select.nvim" })
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        requires = {
            "junegunn/fzf.vim",
            requires = {
                {
                    "tpope/vim-dispatch",
                    cmd = { "Make", "Dispatch" },
                },
                {
                    "junegunn/fzf",
                    build = ":call fzf#install()",
                },
            },
        },
    })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
    })

    -- Git
    use({ "lewis6991/gitsigns.nvim" })

    -- DAP
    use({
        "mfussenegger/nvim-dap",
        requires = {
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
            "nvim-neotest/nvim-nio",
            "mxsdev/nvim-dap-vscode-js",
            "anuvyklack/hydra.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "rcarriga/cmp-dap",
        },
    })

    -- Harpoon
    use("theprimeagen/harpoon")
    --Undotree
    use("mbbill/undotree")
    --Fugitive
    use("tpope/vim-fugitive")

    --Tabnine
    use({
        "tzachar/cmp-tabnine",
        config = function()
            local tabnine = require("cmp_tabnine.config")
            tabnine:setup({
                max_lines = 1000,
                max_num_results = 20,
                sort = true,
            })
        end,
        run = "./install.sh",
        requires = "hrsh7th/nvim-cmp",
    })

    --HTTP client
    -- use({
    --     "rest-nvim/rest.nvim",
    --     requires = { "nvim-lua/plenary.nvim" },
    -- })

    -- Dadbod-ui
    use({
        "kristijanhusak/vim-dadbod-ui",
        requires = {
            "tpope/vim-dadbod",
            "tpope/vim-dotenv",
        },
    })

    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        after = "nvim-web-devicons", -- keep this if you're using NvChad
    })

    --For Markdown files
    use({
        "adalessa/markdown-preview.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("markdown-preview").setup()
        end,
        ft = "markdown",
    })

    use({
        "David-Kunz/gen.nvim",
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
