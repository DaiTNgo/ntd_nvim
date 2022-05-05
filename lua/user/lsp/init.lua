local status_ok, _ = pcall(require, "lspconfig")
local lspconfig = require("lspconfig")
if not status_ok then
	return
end
require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")
require("lspconfig").diagnosticls.setup({})
-- local configs = require("lspconfig/configs")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup({
	-- on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
})
