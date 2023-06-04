local M = {}

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_force_echo_notifications = 1
vim.g.db_ui_auto_execute_table_helpers = 1
vim.g.db_ui_tmp_query_location = "./queries"
vim.g.completion_matching_strategy_list = { "exact", "substring" }

local function db_completion()
	require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
end

function M.setup()
	vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

	vim.api.nvim_create_autocmd("FileType", {
		pattern = {
			"sql",
		},
		command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = {
			"sql",
			"mysql",
			"plsql",
		},
		callback = function()
			vim.schedule(db_completion)
		end,
	})
end

vim.g.completion_chain_complete_list = {
	sql = {
		{ complete_items = { "vim-dadbod-completion" } },
	},
}

vim.g.db_ui_table_helpers = {
	mysql = {
		Count = "select count(1) from {optional_schema}{table}",
		Explain = "EXPLAIN {last_query}",
	},

	sqlite = {
		Describe = "PRAGMA table_info({table})",
	},
	sqlserver = {
		Stored_Procedures = "SELECT name FROM sys.procedures WHERE schema_id = SCHEMA_ID('{schema}') ORDER BY name",
	},
	default = {
		Stored_Procedures = "SELECT name FROM sys.procedures WHERE schema_id = SCHEMA_ID('{schema}') ORDER BY name",
	},
}

vim.g.db_ui_icons = {
	expanded = {
		db = "▾ ",
		buffers = "▾ ",
		saved_queries = "▾ ",
		schemas = "▾ ",
		schema = "▾ פּ",
		tables = "▾ 藺",
		table = "▾ ",
	},
	collapsed = {
		db = "▸ ",
		buffers = "▸ ",
		saved_queries = "▸ ",
		schemas = "▸ ",
		schema = "▸ פּ",
		tables = "▸ 藺",
		table = "▸ ",
	},
	saved_query = "",
	new_query = "璘",
	tables = "離",
	buffers = "﬘",
	add_connection = "",
	connection_ok = "✓",
	connection_error = "✕",
}

--opening it in a new tab
vim.keymap.set("n", "<leader><leader>db", ":tab DBUI<cr>", {})

-- just close the tab, but context related of the keybinding
vim.keymap.set("n", "<leader><leader>tq", ":tabclose<cr>")

return M
