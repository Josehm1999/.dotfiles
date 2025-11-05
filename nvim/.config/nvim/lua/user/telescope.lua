local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
--local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
	defaults = {
		color_devicos = true,
		previewer = false,
		hidden = true,
		file_ignore_patterns = { "node_modules", "package-lock.json" },
		initial_mode = "insert",
		select_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.5,
			height = 0.4,
			prompt_position = "top",
			preview_cutoff = 120,
		},
	},
	pickers = {
		find_files = {
			previewer = false,
			hidden = true,
		},
		git_files = {
			previewer = false,
			hidden = true,
		},
		buffers = {
			previewer = false,
			hidden = true,
		},
		live_grep = {
			only_sort_text = true,
			previewer = false,
			hidden = true,
			layout_config = {
				horizontal = {
					width = 0.9,
					height = 0.75,
					preview_width = 0.6,
				},
			},
		},
		grep_string = {
			only_sort_text = true,
			previewer = false,
			hidden = true,
			layout_config = {
				horizontal = {
					width = 0.9,
					height = 0.75,
					preview_width = 0.6,
				},
			},
		},
		lsp_references = {
			show_line = false,
			previewer = true,
			layout_config = {
				horizontal = {
					width = 0.9,
					height = 0.75,
					preview_width = 0.6,
				},
			},
		},
		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
			},
		},
		extensions = {
			fzf_native = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					previewer = false,
					initial_mode = "normal",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							width = 0.5,
							height = 0.4,
							preview_width = 0.6,
						},
					},
				}),
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

function M.grep_string()
	vim.ui.input({ prompt = "Grep for > " }, function(input)
		if input == nil then
			return
		end
		require("telescope.builtin").grep_string({ search = input })
	end)
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

require("telescope").load_extension("media_files")
-- require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("dap")
return M
