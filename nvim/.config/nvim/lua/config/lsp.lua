-- Shared on_attach
local on_attach = function(_, bufnr)
	local map = function(mode, lhs, rhs)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
	end

	map("n", "K", vim.lsp.buf.hover)
	map("n", "gd", vim.lsp.buf.definition)
	map("n", "gr", vim.lsp.buf.references)
	map("n", "gI", vim.lsp.buf.implementation)
	map("n", "gy", vim.lsp.buf.type_definition)
	map("n", "gD", vim.lsp.buf.declaration)
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
end

-- Helper to find project root by walking up for markers
local find_root = function(markers)
	return function(bufnr)
		local path = vim.api.nvim_buf_get_name(bufnr)
		local found = vim.fs.find(markers, { path = path, upward = true })[1]
		return found and vim.fs.dirname(found) or vim.fn.getcwd()
	end
end

local start = function(opts)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = opts.filetypes,
		callback = function()
			vim.lsp.start({
				name = opts.name,
				cmd = opts.cmd,
				root_dir = opts.root_dir,
				settings = opts.settings,
				init_options = opts.init_options,
				on_attach = on_attach,
			})
		end,
	})
end

-- Lua
start({
	name = "lua_ls",
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})

-- Rust
start({
	name = "rust_analyzer",
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
})

-- JS / TS
start({
	name = "ts_ls",
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "typescript" },
})

-- HTML
start({
	name = "html",
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
})

-- CSS
start({
	name = "cssls",
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css" },
})

-- Tailwind
start({
	name = "tailwindcss",
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = { "html", "css", "javascript", "typescript", "svelte" },
})

-- Svelte
start({
	name = "svelte",
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },
})

-- Python
start({
	name = "pyright",
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
})

-- Astro
start({
	name = "astro",
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
})

-- C#
start({
	name = "csharp_ls",
	cmd = { "csharp-ls" },
	filetypes = { "cs" },
	root_dir = find_root({ "*.sln", "*.csproj" }),
	init_options = {
		AutomaticWorkspaceInit = true,
	},
})

-- ESLint
start({
	name = "eslint",
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
	settings = {
		workingDirectory = { mode = "auto" },
	},
})
