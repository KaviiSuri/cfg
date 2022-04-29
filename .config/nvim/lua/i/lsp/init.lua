local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require("i.lsp.installer")
require("i.lsp.handlers").setup()
require("i.lsp.null-ls")
