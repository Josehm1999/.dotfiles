local servers = {
	"lua_ls",
	"cssls",
	"html",
	"ts_ls",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"omnisharp",
	"taplo",
	"solidity",
	"graphql",
	"prismals",
	"tailwindcss",
	"emmet_ls",
	"angularls",
	"lemminx",
	"gopls",
	"astro",
    "biome",
    "eslint"
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
	automatic_installation = true,
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

	if server == "omnisharp" then
		-- vim.lsp.handlers["textDocument/definition"] = require("omnisharp_extended").definition_handler
		-- vim.lsp.handlers["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler
		-- vim.lsp.handlers["textDocument/references"] = require("omnisharp_extended").references_handler
		-- vim.lsp.handlers["textDocument/implementation"] = require("omnisharp_extended").implementation_handler
	end

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end
	if server ~= "ts_ls" then
		lspconfig[server].setup(opts)
	end
end

-- filter the list for the ones not globally installed
-- require("mason-tool-installer").setup {
--     ensure_installed = {
--         "go-debug-adapter",
--         "php-debug-adapter",
--         "js-debug-adapter",
--         "codelldb",
--     }
-- }
