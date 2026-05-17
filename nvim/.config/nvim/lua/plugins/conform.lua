return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },

				python = { "isort", "black" },

				rust = { "rustfmt", lsp_format = "fallback" },

				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },

				nix = { "alejandra" },

				kdl = { "kdlfmt" },
			},

			format_on_save = {
				timeout_ms = 2000,
				lsp_fallback = true,
			},
		})
	end,
}
