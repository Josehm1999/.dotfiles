local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require("user.lsp.mason")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")

local lspconfig = require("lspconfig")
local servers = {
    emmet_ls = require("user.lsp.settings.emmet_ls"),
    lua_ls = require("user.lsp.settings.sumneko_lua"),
    jsonls = require("user.lsp.settings.json_ls"),
    eslint = require("user.lsp.settings.eslint_ls"),
}

for name, config in pairs(servers) do
    if config ~= nil and type(config) == "table" then
        config.on_setup(lspconfig[name])
    else
        lspconfig[name].setup({})
    end
end
