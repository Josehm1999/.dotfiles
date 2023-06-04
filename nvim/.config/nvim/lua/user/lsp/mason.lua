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
    "solidity",
    "graphql",
    "prismals",
    "tailwindcss",
    "emmet_ls",
    "angularls",
    "eslint"
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

require("mason").setup(settings)
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
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

    if server == "rust_analyzer" then
        local ih = require("inlay-hints")
        require("rust-tools").setup {
            tools = {
                executor = require("rust-tools/executors").termopen,
                reload_workspace_from_cargo_toml = true,
                runnables = {
                    use_telescope = true,
                },
                inlay_hints = {
                    auto = false,
                    only_current_line = false,
                    show_parameter_hints = false,
                    parameter_hints_prefix = "<-",
                    other_hints_prefix = "=>",
                    max_len_align = false,
                    max_len_align_padding = 1,
                    right_align = false,
                    right_align_padding = 7,
                    highlight = "Comment",
                },
                hover_actions = {
                    border = "rounded",
                },
                dap = {
                    adapter = {
                        type = "executable",
                        command = "codelldb",
                        name = "rt_lldb"
                    }
                },
                on_initialized = function()
                    ih.set_all()
                    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                        pattern = { "*.rs" },
                        callback = function()
                            local _, _ = pcall(vim.lsp.codelens.refresh)
                        end,
                    })
                end,
            },
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
                        procMacro = {
                            enable = true
                        },
                        cargo = {
                            loadOutDirsFromCheck = true,
                        }
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


-- filter the list for the ones not globally installed
require("mason-tool-installer").setup {
    ensure_installed = require "user.lsp.tools",
}
