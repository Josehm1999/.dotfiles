pcall(require, "impatient")

if require "josehm.first_load"() then
	return
end

vim.g.mapleader = " "

vim.g.snippets =  "luasnip"

require "josehm"


