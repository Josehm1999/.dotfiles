return {
	on_setup = function(server)
		server.setup({
			filestypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
			settings = {
				workingDirectories = { mode = "auto" },
				format = auto_format,
			},
			flags = {
				allow_incremental_sync = false,
				debounce_text_changes = 1000,
			},
		})
	end,
}
