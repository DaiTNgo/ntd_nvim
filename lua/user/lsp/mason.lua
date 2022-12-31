local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"cssmodules_ls",
	"tailwindcss",
	"rust_analyzer",
}
-- require("rust-tools").inlay_hints.enable()
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

-- local opts = {}
local lsp_flags = {
	-- This is the default in Nvim 0.7+ ::: 150
	debounce_text_changes = 100,
}
local opts = {
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
	flags = lsp_flags,
}

for _, server in pairs(servers) do
	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end
	if server == "rust_analyzer" then
		require("rust-tools").setup({
			tools = {
				on_initialized = function()
					vim.cmd([[
	           autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
	         ]])
				end,
			},
			-- These apply to the default RustSetInlayHints command
			inlay_hints = {
				-- automatically set inlay hints (type hints)
				-- default: true
				auto = true,

				-- Only show inlay hints for the current line
				-- only_current_line = false, --default
				only_current_line = true, --default

				-- whether to show parameter hints with the inlay hints or not
				-- default: true
				show_parameter_hints = true,

				-- prefix for parameter hints
				-- default: "<-"
				parameter_hints_prefix = "<- ",

				-- prefix for all the other hints (type, chaining)
				-- default: "=>"
				other_hints_prefix = "=> ",

				-- whether to align to the length of the longest line in the file
				max_len_align = false,

				-- padding from the left if max_len_align is true
				max_len_align_padding = 1,

				-- whether to align to the extreme right or not
				-- right_align = false, -- default
				right_align = true,

				-- padding from the right if right_align is true
				right_align_padding = 7,

				-- The color of the hints
				highlight = "Comment",
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
					},
				},
			},
		})
	end
	lspconfig[server].setup(opts)
end

-- require("typescript").setup({
-- 	disable_commands = false, -- prevent the plugin from creating Vim commands
-- 	debug = false, -- enable debug logging for commands
-- 	go_to_source_definition = {
-- 		fallback = true, -- fall back to standard LSP definition on failure
-- 	},
-- 	server = { -- pass options to lspconfig's setup method
-- 		on_attach = opts.on_attach,
-- 	},
-- })
