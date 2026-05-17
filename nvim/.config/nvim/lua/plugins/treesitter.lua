return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		main = "nvim-treesitter",
		init = function()
			local wanted = {
				-- from your LSP setup
				"lua",
				"rust",
				"javascript",
				"typescript",
				"html",
				"css",
				"svelte",
				"python",
				"astro",
				-- good to have
				"bash",
				"json",
				"toml",
				"yaml",
				"markdown",
			}
			local installed = require("nvim-treesitter.config").get_installed()
			local to_install = vim.tbl_filter(function(p)
				return not vim.tbl_contains(installed, p)
			end, wanted)
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end
		end,
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
