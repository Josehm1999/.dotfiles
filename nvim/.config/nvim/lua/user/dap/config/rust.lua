local dap = require("dap")

local rust_adapter = nil
local rust_adapters = { "lldb-vscode", "codelldb" }
for _, adapter in pairs(rust_adapters) do
	if vim.fn.executable(adapter) then
		rust_adapter = adapter
	end
end

if rust_adapter ~= nil then
	dap.adapters.codelldb = {
		type = "server",
		name = "codelldb",
		port = "${port}",
		executable = {
			command = rust_adapter,
			args = { "--port", "${port}" },
		},
	}

	dap.configurations.rust = {
		{
			name = "launch",
			type = "codelldb",
			request = "launch",
			program = function()
				local dir = vim.fn.getcwd()
				return dir .. "/target/debug/" .. vim.fs.basename(dir)
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = function()
				local resp = vim.fn.input("Arguments: ")
				if resp == "" then
					return {}
				end

				return vim.fn.split(resp, " ")
			end,
		},
		{
			name = "custom",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = function()
				local resp = vim.fn.input("Arguments: ")
				if resp == "" then
					return {}
				end

				return vim.fn.split(resp, " ")
			end,
		},
	}
end
