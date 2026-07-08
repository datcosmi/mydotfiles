return {
	{
		-- The original nvim-treesitter/nvim-treesitter was archived by its
		-- maintainer on 2026-04-03 :(. This is the actively maintained community
		-- continuation
		"neovim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		main = "nvim-treesitter",
		dependencies = { "nvim-lua/plenary.nvim", "neovim-treesitter/treesitter-parser-registry" },
		init = function()
			require("nvim-treesitter").install({
				"lua",
				"rust",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"svelte",
				"python",
				"astro",
				"c_sharp",
				"sql",
				"bash",
				"json",
				"toml",
				"yaml",
				"markdown",
				"markdown_inline",
			})

			-- Parser name doesn't always match Neovim's filetype name -- when it
			-- doesn't, vim.treesitter.start() silently fails to find a parser
			-- unless you register the mapping explicitly.
			vim.treesitter.language.register("c_sharp", "cs")
			vim.treesitter.language.register("bash", "sh")
			vim.treesitter.language.register("tsx", "typescriptreact")
			vim.treesitter.language.register("javascript", "javascriptreact")
		end,
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local ok = pcall(vim.treesitter.start)
					if not ok then
						return
					end
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					-- vim.wo.foldmethod = "expr"
				end,
			})
		end,
	},
}
