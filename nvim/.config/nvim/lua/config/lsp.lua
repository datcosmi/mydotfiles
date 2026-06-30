-- Per-server configs live in lsp/*.lua

-- Shared keymaps for every LSP client, set once per buffer on attach.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
	callback = function(args)
		local map = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { buffer = args.buf })
		end
		map("n", "K", vim.lsp.buf.hover)
		map("n", "gd", vim.lsp.buf.definition)
		map("n", "gr", vim.lsp.buf.references)
		map("n", "gI", vim.lsp.buf.implementation)
		map("n", "gy", vim.lsp.buf.type_definition)
		map("n", "gD", vim.lsp.buf.declaration)
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
	end,
})

-- Enable the native, file-based server configs
-- Each one only actually starts when its filetype is opened AND a root_marker is found.
vim.lsp.enable({
	"lua_ls",
	"rust_analyzer",
	"ts_ls",
	"html",
	"cssls",
	"tailwindcss",
	"svelte",
	"pyright",
	"astro",
	"eslint",
})
