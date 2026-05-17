return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local function editor_state()
			local parts = {}

			-- Macro recording
			local reg = vim.fn.reg_recording()
			if reg ~= "" then
				table.insert(parts, "󰑋 @" .. reg)
			end

			-- Paste mode
			if vim.o.paste then
				table.insert(parts, " PASTE")
			end

			-- Spell check
			if vim.wo.spell then
				table.insert(parts, "󰓆 SPELL")
			end

			-- Readonly
			if vim.bo.readonly then
				table.insert(parts, " RO")
			end

			-- Modified
			if vim.bo.modified then
				table.insert(parts, "●")
			end

			return table.concat(parts, "  ")
		end

		require("lualine").setup({
			options = {
				-- theme = "catppuccin",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },

				lualine_x = {
					{
						editor_state,
						color = function()
							if vim.fn.reg_recording() ~= "" then
								return { fg = "#f5c2e7", gui = "bold" }
							end
							return { fg = "#a6adc8" }
						end,
					},
					"encoding",
					"fileformat",
					"filetype",
				},

				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
