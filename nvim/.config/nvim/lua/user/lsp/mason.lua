local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
    "rust_analyzer",
    "csharp_ls",
    "taplo"
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = false,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

    if server == "rust_analyzer" then
    require("rust-tools").setup {
      tools = {
        on_initialized = function()
          vim.cmd [[
            autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
          ]]-- Rust specific keybindings
                    local keymap = vim.keymap.set
                    local key_opts = { silent = true }

                    keymap("n", "<leader>rh", "<cmd>RustSetInlayHints<Cr>", key_opts)
                    keymap("n", "<leader>rhd", "<cmd>RustDisableInlayHints<Cr>", key_opts)
                    keymap("n", "<leader>th", "<cmd>RustToggleInlayHints<Cr>", key_opts)
                    keymap("n", "<leader>rr", "<cmd>RustRunnables<Cr>", key_opts)
                    keymap("n", "<leader>rem", "<cmd>RustExpandMacro<Cr>", key_opts)
                    keymap("n", "<leader>roc", "<cmd>RustOpenCargo<Cr>", key_opts)
                    keymap("n", "<leader>rpm", "<cmd>RustParentModule<Cr>", key_opts)
                    keymap("n", "<leader>rjl", "<cmd>RustJoinLines<Cr>", key_opts)
                    keymap("n", "<leader>rha", "<cmd>RustHoverActions<Cr>", key_opts)
                    keymap("n", "<leader>rhr", "<cmd>RustHoverRange<Cr>", key_opts)
                    keymap("n", "<leader>rmd", "<cmd>RustMoveItemDown<Cr>", key_opts)
                    keymap("n", "<leader>rmu", "<cmd>RustMoveItemUp<Cr>", key_opts)
                    keymap("n", "<leader>rsb", "<cmd>RustStartStandaloneServerForBuffer<Cr>", key_opts)
                    keymap("n", "<leader>rd", "<cmd>RustDebuggables<Cr>", key_opts)
                    keymap("n", "<leader>rv", "<cmd>RustViewCrateGraph<Cr>", key_opts)
                    keymap("n", "<leader>rw", "<cmd>RustReloadWorkspace<Cr>", key_opts)
                    keymap("n", "<leader>rss", "<cmd>RustSSR<Cr>", key_opts)
                    keymap("n", "<leader>rxd", "<cmd>RustOpenExternalDocs<Cr>", key_opts)
        end,
      },
      server = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
        settings = {
          ["rust-analyzer"] = {
            lens = {
              enable = true,
            },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      },
    }

    goto continue
  end

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
    ::continue::
end
