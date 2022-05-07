local null_ls_status_ok, null_ls = pcall(require, "null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({
      extra_filetypes = { "toml", "solidity" },
      extra_args = { "--single-quote", "--jsx-single-quote" },
      print_width = 50,
    }),
    -- formatting.stylua,
    -- formatting.black.with({ extra_args = { "--fast" } }),
    -- diagnostics.write_good,
  },
  -- on_attach = function(client)
  -- 	if client.resolved_capabilities.document_formatting then
  -- 		vim.cmd([[
  -- 	          augroup LspFormatting
  -- 	              autocmd!
  -- 	              autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
  -- 	          augroup END
  -- 	          ]])
  -- 	end
  -- end,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
