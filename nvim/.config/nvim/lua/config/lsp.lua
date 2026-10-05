-- Per-server configs live in lsp/*.lua

vim.lsp.config("*", {
	capabilities = {
		workspace = {
			fileOperations = { didRename = true, willRename = true },
		},
	},
})

-- Shared keymaps for every LSP client, set once per buffer on attach.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
	callback = function(args)
		local function map(mode, lhs, rhs, desc, extra)
			vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { buffer = args.buf, desc = desc }, extra or {}))
		end
		map("n", "K", vim.lsp.buf.hover, "Hover")
		map("n", "gd", function()
			Snacks.picker.lsp_definitions()
		end, "Goto Definition")
		map("n", "gr", function()
			Snacks.picker.lsp_references()
		end, "References", { nowait = true })
		map("n", "gI", function()
			Snacks.picker.lsp_implementations()
		end, "Goto Implementation")
		map("n", "gy", function()
			Snacks.picker.lsp_type_definitions()
		end, "Goto Type Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
		map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
	end,
})

-- Enable the native, file-based server configs.
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
