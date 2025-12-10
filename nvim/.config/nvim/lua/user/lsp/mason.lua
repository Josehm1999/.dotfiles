local servers = {
	"lua_ls",
	"cssls",
	"html",
	"ts_ls",
	"bashls",
	"jsonls",
	"yamlls",
	"csharp_ls",
	"taplo",
	"prismals",
	"tailwindcss",
	"emmet_ls",
	"angularls",
	"lemminx",
	"gopls",
	"astro",
	"biome",
    "jdtls"
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
	automatic_enable = false,
})

local handlers = require("user.lsp.handlers")

for _, server in pairs(servers) do
	server = vim.split(server, "@")[1]

	-- Base configuration with handlers
	local config = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
	}

	-- Merge server-specific settings if they exist
	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		config = vim.tbl_deep_extend("force", conf_opts, config)
	end

	-- Special handling for omnisharp
	-- if server == "omnisharp" then
	-- 	vim.g.OmniSharp_server_use_net6 = 1
	-- 	config = vim.tbl_deep_extend("force", config, {
	-- 		cmd = {
	-- 			"Omnisharp",
	-- 			"--languageserver",
	-- 			"--hostPID",
	-- 			tostring(vim.fn.getpid()),
	-- 		},
	-- 		settings = {
	-- 			RoslynExtensionsOptions = {
	-- 				enableDecompilationSupport = false,
	-- 				enableImportCompletion = true,
	-- 				enableAnalyzersSupport = true,
	-- 			},
	-- 		},
	-- 		root_markers = { "*.sln", "*.csproj" },
	-- 	})
	-- end
	--
	if server == "angularls" then
		local mason_path = vim.fn.stdpath("data") .. "/mason/packages"

		-- Find node_modules in current working directory
		config = vim.tbl_deep_extend("force", config, {
			cmd = {
				"ngserver",
				"--stdio",
				"--tsProbeLocations",
				mason_path .. "/typescript-language-server/node_modules/typescript/lib",
				"--ngProbeLocations",
				mason_path .. "/angular-language-server/node_modules/@angular/language-server/bin",
			},
		})
	end

	vim.lsp.config("angularls", config)
	vim.lsp.enable("angularls")

	-- Apply configuration and enable server
	--
	if server ~= "angularls" then
		vim.lsp.config(server, config)
		vim.lsp.enable(server)
	end
end
