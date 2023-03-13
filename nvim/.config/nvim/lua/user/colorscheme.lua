-- local colorscheme = "tokyonight"
--
-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
-- 	return
-- end
local catppuccin = require("catppuccin")

catppuccin.setup({
	transparent_background = true,
	term_colors = false,
	-- styles = { comments = "italic", functions = "italic", keywords = "italic", strings = "NONE", variables = "NONE" },
	integrations = {
		treesitter = true,
		-- native_lsp = {
		-- 	enabled = true,
		-- 	virtual_text = { errors = "italic", hints = "italic", warnings = "italic", information = "italic" },
		-- 	underlines = {
		-- 		errors = "underline",
		-- 		hints = "underline",
		-- 		warnings = "underline",
		-- 		information = "underline",
		-- 	},
		-- },
		lsp_trouble = false,
		lsp_saga = false,
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		nvimtree = { enabled = true, show_root = true },
		which_key = true,
		indent_blankline = { enabled = true, colored_indent_levels = true },
		neogit = false,
		vim_sneak = false,
		fern = false,
		barbar = false,
		bufferline = true,
		markdown = false,
		lightspeed = false,
		ts_rainbow = true,
	},
	highlight_overrides = {
		mocha = function(mocha)
			return {
				NvimTreeNormal = { bg = mocha.none },
			}
		end,
	},
})
local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end

