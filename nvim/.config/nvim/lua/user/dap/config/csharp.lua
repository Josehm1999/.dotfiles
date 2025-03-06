local dap = require("dap")
local csharp_debugger = vim.fn.exepath("netcoredbg")
dap.adapters.coreclr = {
    type = "executable",
    command = csharp_debugger,
    args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
    },
}
