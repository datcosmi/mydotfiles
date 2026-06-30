-- Keymaps are picked up automatically from the shared LspAttach autocmd in
-- lua/config/lsp.lua -- no need to duplicate on_attach here.
return {
	"seblyng/roslyn.nvim",
	ft = "cs",
	opts = {
		-- Search upward through parent directories for a .sln/.slnx/.slnf
		-- if one isn't found in the buffer's immediate project folder.
		broad_search = true,
	},
	config = function(_, opts)
		vim.lsp.config("roslyn", {
			cmd = {
				"Microsoft.CodeAnalysis.LanguageServer",
				"--logLevel",
				"Information",
				"--extensionLogDirectory",
				vim.fs.joinpath(vim.fn.stdpath("log"), "roslyn"),
				"--stdio",
			},
		})
		require("roslyn").setup(opts)
	end,
}
