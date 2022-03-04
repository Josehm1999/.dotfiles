require("josehm.options")
require("josehm.keymaps")
require("josehm.telescope")
require("josehm.nvim-tree")
require("josehm.treesitter")
require("josehm.comment")
require("josehm.gitsigns")
require("josehm.bufferline")
require("josehm.cmp")
require("josehm.lualine")
require("josehm.lsp")
require("josehm.autopairs")
require("josehm.toggleterm")
require("josehm.nvim-web-devicons")
P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end
