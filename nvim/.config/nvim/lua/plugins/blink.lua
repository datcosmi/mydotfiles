return {
	"saghen/blink.cmp",
	-- v2 is still under active, breaking development
	version = "1.*",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
	},
	opts = {
		keymap = {
			-- "default" preset: <C-y> = accept, <C-n>/<C-p> = next/prev, <C-space> = show,
			-- <Tab>/<S-Tab> = jump through snippet placeholders.
			preset = "default",
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 200 },
			menu = { border = "rounded" },
		},
		signature = {
			enabled = true,
			window = { border = "rounded" },
		},
		-- Built-in snippet engine support for LuaSnip
		snippets = { preset = "luasnip" },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			-- Completion for vim.*, Snacks.*, require("...") in lua files
			per_filetype = {
				lua = { inherit_defaults = true, "lazydev" },
			},
			providers = {
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
			},
		},
		-- Falls back to the Lua matcher automatically if the Rust binary
		-- can't be downloaded/loaded for any reason, with a one-time warning.
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	config = function(_, opts)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Merge blink's expanded capabilities into every LSP config
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		require("blink.cmp").setup(opts)
	end,
}
