return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	init = function()
		vim.api.nvim_create_autocmd("VimEnter", {
			group = vim.api.nvim_create_augroup("PersistenceAutoload", { clear = true }),
			nested = true,
			callback = function()
				if vim.fn.argc() == 0 then
					require("persistence").load()
				end
			end,
		})
	end,
	keys = {
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Restore Session",
		},
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore Last Session",
		},
		{
			"<leader>qd",
			function()
				require("persistence").stop()
			end,
			desc = "Stop Session Saving",
		},
	},
}
