local servers = {
    "sumneko_lua",
    "cssls",
    "html",
    "tsserver",
    "pyright",
    "bashls",
    "jsonls",
    "yamlls",
    "rust_analyzer",
    "csharp_ls",
    "taplo",
    "solc",
    "tailwindcss",
    "emmet_ls"
}

local settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

local codelldb_adapter = {
    type = "server",
    port = "${port}",
    executable = {
        command = mason_path .. "bin/codelldb",
        args = { "--port", "${port}" },
        -- On windows you may have to uncomment this:
        -- detached = false,
    },
}
require("mason").setup(settings)
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = false,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }

    if server == "emmet_ls" then
        local emmet_opts = require("user.lsp.settings.emmet_ls")
        opts = vim.tbl_deep_extend("force", emmet_opts, opts)
    end

    if server == "rust_analyzer" then
        require("rust-tools").setup {
            tools = {
                on_initialized = function()
                    vim.cmd [[
            autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
          ]]
                end,
            },
            -- dap = {
            --     adapter = {
            --         type = "executable",
            --         command = "lldb-vscode",
            --         name = "rt_lldb",
            --     },
            -- },
            server = {
                on_attach = require("user.lsp.handlers").on_attach,
                capabilities = require("user.lsp.handlers").capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        lens = {
                            enable = true,
                        },
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            },
        }

        goto continue
    end

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
    ::continue::
end
