local status_ok, color_picker = pcall(require, "color-picker")
if not status_ok then
	return
end

local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap("", "<Space>", "<Nop>", opts)

keymap("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)
color_picker.setup()

