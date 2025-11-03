require("user.lsp.mason")
require("user.lsp.handlers").setup()
require("user.lsp.conform")

local servers = {
	emmet_ls = require("user.lsp.settings.emmet_ls"),
	lua_ls = require("user.lsp.settings.lua_ls"),
	jsonls = require("user.lsp.settings.json_ls"),
	eslint = require("user.lsp.settings.eslint_ls"),
	angularls = require("user.lsp.settings.angular_ls"),
}

for name, config in pairs(servers) do
	if config ~= nil and type(config) == "table" then
		vim.lsp.config(name, config)
	end
	vim.lsp.enable(name)
end
