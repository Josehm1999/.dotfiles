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
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use({ "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" }) -- Have packer manage itself
    use({ "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }) -- Useful lua functions used by lots of plugins
    use({ "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" }) -- Autopairs, integrates with both cmp and treesitter
    use({ "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" })
    use({ "JoosepAlviste/nvim-ts-context-commentstring" })
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })
    use({ "akinsho/bufferline.nvim", tag = "*" })
    use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
    use({ "nvim-lualine/lualine.nvim" })
    use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })
    use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })
    use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })
    use({ "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" })
    use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })

    -- Colorschemes
    use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
    use({ "lunarvim/darkplus.nvim", commit = "2584cdeefc078351a79073322eb7f14d7fbb1835" })
    use({ "catppuccin/nvim" })

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" }) -- The completion plugin
    use({ "hrsh7th/cmp-buffer" }) -- buffer completions
    use({ "hrsh7th/cmp-path" }) -- path completions
    use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
    use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
    use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })
    use({ "onsails/lspkind-nvim" })

    -- snippets
    use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" }) --snippet engine
    use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }) -- a bunch of snippets to use

    -- LSP
    use({ "neovim/nvim-lspconfig" }) -- enable LSP
    use({ "williamboman/mason.nvim" })
    use({ "WhoIsSethDaniel/mason-tool-installer.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    --use({ "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" }) -- simple to use language server installer
    use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
    use({ "RRethy/vim-illuminate" })

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
        --commit = "518e27589c0463af15463c9d675c65e464efc2fe",
        --commit = "4cccb6f494eb255b32a290d37c35ca12584c74d0",
    })

    use({
        "nvim-treesitter/nvim-treesitter-context"
    })

    -- Git
    use({ "lewis6991/gitsigns.nvim" })
    use({ "tpope/vim-fugitive" })

    -- DAP
    use({
        "mfussenegger/nvim-dap",
        requires = {
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
            "mxsdev/nvim-dap-vscode-js",
            "anuvyklack/hydra.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "rcarriga/cmp-dap",
        },
    })

    -- Dadbod-ui
    use({ "kristijanhusak/vim-dadbod-ui", requires = {
        "tpope/vim-dadbod",
        "tpope/vim-dotenv",
    } })

    use({ "kristijanhusak/vim-dadbod-completion" })
    use({ "b0o/schemastore.nvim" })
    use({ "tomlion/vim-solidity" })
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
    -- LSP Based folding
    use({
        "kevinhwang91/nvim-ufo",
        opt = true,
        event = { "BufReadPre" },
        wants = { "promise-async" },
        requires = "kevinhwang91/promise-async",
        disable = false,
    })

    use({ "ThePrimeagen/vim-be-good" })

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })

    -- Harpoo
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
    use("theprimeagen/harpoon")
    --Undotree
    use("mbbill/undotree")

    --HTTP client
    use({
        "rest-nvim/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
