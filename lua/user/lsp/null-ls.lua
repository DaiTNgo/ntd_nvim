local null_ls_status_ok, null_ls = pcall(require, "null-ls")
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
		formatting.stylua,
		-- formatting.black.with({ extra_args = { "--fast" } }),
		-- diagnostics.write_good,
	},
	on_attach = function(client)
		-- if client.resolved_capabilities.document_formatting then
		-- 	vim.cmd([[
		--           augroup LspFormatting
		--               autocmd! 
		--               autocmd BufWritePre * lua vim.lsp.buf.formatting()
		--           augroup END
		--           ]])
		-- end
	end,
})
