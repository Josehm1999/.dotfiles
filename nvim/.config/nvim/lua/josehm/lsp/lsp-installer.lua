local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  "emmet_ls",
  "html",
  -- "jdtls",
  "jsonls",
  "solc",
  "sumneko_lua",
  --"tflint",
  "tsserver",
  --"pyright",
}

local settings = {
  ensure_installed = servers,
  -- automatic_installation = false,
  ui = {
    icons = {
      -- server_installed = "◍",
      -- server_pending = "◍",
      -- server_uninstalled = "◍",
      -- server_installed = "✓",
      -- server_pending = "➜",
      -- server_uninstalled = "✗",
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
    },
  },

  log_level = vim.log.levels.INFO,
  -- max_concurrent_installers = 4,
  -- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
}

<<<<<<< HEAD
      if server.name == "sumneko_lua" then
        local sumneko_opts = require("josehm.lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
      end
      if server.name == "csharp_ls" then
        local csharp_opts = require("josehm.lsp.settings.csharp-ls")
        opts = vim.tbl_deep_extend("force", csharp_opts, opts)
      end
      -- This setup() function is exactly the same as lspconfig's setup function
      -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      server:setup(opts)
 end)
=======
lsp_installer.setup(settings)

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("josehm.lsp.handlers").on_attach,
    capabilities = require("josehm.lsp.handlers").capabilities,
  }
   lspconfig[server].setup(opts)
end
>>>>>>> 89e1308d3a9d96d465d4392614f0f1131d035210
