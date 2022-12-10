function bind(mode, outer_opts)
	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force", {}, outer_opts or {}, opts or {})
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

local M = {}
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.noremap = bind("i")

M.buff_nnoremap = bind("n", {buffer = 0})
M.buff_vnoremap = bind("v", {buffer = 0})
M.buff_noremap = bind("i", {buffer = 0})

return M
