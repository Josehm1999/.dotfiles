return {
	on_setup = function(server)
		server.setup({
			filestypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
			settings = {
				format = { enable = true },
				lint = { enable = true },
			},
		})
	end,
}
