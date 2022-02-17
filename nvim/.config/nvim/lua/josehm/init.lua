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

p = function(v)
    print(vim.inspect(v))
    return v
end

if pcall(require, 'plenary') then
    RELOAD = require('plenary.reload').reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end
