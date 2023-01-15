local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
	return
end

dap_install.setup({
	-- installation_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/"),
	verbosely_call_debuggers = true,
})

dap_install.config("python", {})
dap_install.config("dnetcs", {
	-- type = "coreclr",
	-- name = "launch - netcoredbg",
	-- request = "launch",
	-- program = function()
	-- 	return vim.fn.input(vim.fn.glob(vim.fn.stdpath("data") .. "/mason/"), vim.fn.getcwd() .. "/bin/Debug/", "file")
	-- end,
})
dap_install.config("chrome",{})
-- dap_install.config("codelldb", {})
dapui.setup({
	sidebar = {
		elements = {
			{
				id = "scopes",
				size = 0.25, -- Can be float or integer > 1
			},
			{ id = "breakpoints", size = 0.25 },
		},
		size = 40,
		position = "right", -- Can be "left", "right", "top", "bottom"
	},
	tray = {
		elements = {},
	},
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
