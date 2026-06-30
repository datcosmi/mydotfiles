return {
	"saghen/blink.cmp",
	-- Pin to a tagged release so lazy.nvim downloads the pre-built fuzzy-matcher
	-- binary instead of requiring a Rust toolchain to compile from source.
	-- v2 is still under active, breaking development
	version = "1.*",
	-- Capabilities must be registered before any LSP client attaches. Your
	-- servers start on FileType (see lua/config/lsp.lua), which fires right
	-- after BufReadPre/BufNewFile -- so loading here (not on InsertEnter,
	-- which is the more common recommendation) preserves that ordering.
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
	},
	opts = {
		keymap = {
			preset = "default", -- <CR> = accept, <Tab>/<S-Tab> = next/prev, <C-space> = show
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
