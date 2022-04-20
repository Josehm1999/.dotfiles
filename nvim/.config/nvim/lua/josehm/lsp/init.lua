local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("josehm.lsp.lsp-installer")
require("josehm.lsp.handlers").setup()
require "josehm.lsp.null-ls"
