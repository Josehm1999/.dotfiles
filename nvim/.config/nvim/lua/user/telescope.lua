local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

require('telescope').load_extension('media_files')

local actions = require("telescope.actions")

telescope.setup({
	defaults = {

		prompt_prefix = "> ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },

		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
})

local M = {}

M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		promt_title = "< VimRC >",
		cwd = "~/.config/nvim",
		hidden = true,
	})
end

local function set_background(content)
	print(content)
	vim.fn.system("feh --bg-max " .. content)
end

local function select_background(prompt_bufnr, map)
	local function set_the_background(close)
		local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
		set_background(content.cwd .. "/" .. content.value)
		if close then
			require("telescope.actions").close(prompt_bufnr)
		end
	end

	map("i", "<C-p>", function()
		set_the_background()
	end)

	map("i", "<CR>", function()
		set_the_background(true)
	end)
end

local function image_selector(prompt, cwd)
	return function()
		require("telescope.builtin").find_files({
			promt_title = prompt,
			cwd = cwd,

			attach_mappings = function(prompt_bufnr, map)
				select_background(prompt_bufnr, map)
				return true
			end,
		})
	end
end

M.anime_selector = image_selector("< She's like me FR FR >", "~/Desktop/jjhm/imgs")

return M
