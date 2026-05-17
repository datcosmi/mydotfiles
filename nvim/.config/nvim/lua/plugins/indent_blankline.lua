return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = {
			char = "│",
			-- Use a semi-transparent color
			highlight = { "IblIndent" },
		},
		scope = {
			enabled = false,
		},
	},
	-- config = function(_, opts)
	-- 	-- Define the highlight with transparency
	-- 	-- vim.api.nvim_set_hl(0, "IblIndent", { fg = "#535970" })
	-- 	vim.api.nvim_set_hl(0, "IblIndent", { fg = "#494E63" })
	--
	-- 	require("ibl").setup(opts)
	-- end,
}
