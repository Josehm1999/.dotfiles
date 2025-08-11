local conform_status_ok, conform = pcall(require, "conform")
if not conform_status_ok then
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		sql = { "sql_formatter" },
		javascript = { "biome" },
		typescript = { "biome" },
		toml = { "prettier" },
		astro = { "biome" },
		mdx = { "prettier" },
		html = { "biome" },
		css = { "prettier" },
		javascriptreact = { "biome" },
		typescriptreact = { "biome" },
		svelte = { "prettier" },
		htmlangular = { "prettier" },
		lemminx = { "prettier" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>lf", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (in visual mode)", silent = true })
