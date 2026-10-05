return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("catppuccin-nvim")
		end,
		opts = {
			flavour = "mocha",
			transparent_background = true,
			custom_highlights = function(colors)
				return {
					-- Make backgrounds transparent
					Normal = { bg = "NONE" },
					NormalNC = { bg = "NONE" },
					NormalFloat = { bg = "NONE" },
					FloatBorder = { bg = "NONE" },

					-- Status and tab lines
					StatusLine = { bg = "NONE" },
					StatusLineNC = { bg = "NONE" },
					TabLine = { bg = "NONE" },
					TabLineFill = { bg = "NONE" },
					TabLineSel = { bg = "NONE" },

					-- Popup menus
					Pmenu = { bg = "NONE" },
					PmenuSel = { bg = colors.surface0 },
					PmenuSbar = { bg = "NONE" },
					PmenuThumb = { bg = colors.overlay0 },

					-- WhichKey
					WhichKeyFloat = { bg = "NONE" },

					-- Noice/Notify
					NoicePopup = { bg = "NONE" },
					NoiceCmdlinePopup = { bg = "NONE" },
					NotifyBackground = { bg = "NONE" },

					-- Line numbers
					LineNr = {
						fg = colors.overlay0,
						bg = "NONE",
						bold = false,
					},

					CursorLineNr = {
						fg = colors.pink,
						bg = "NONE",
						bold = true,
					},

					-- Make CursorLine completely transparent
					CursorLine = {
						bg = "NONE",
					},

					-- Indent guides / current scope
					SnacksIndent = { fg = colors.surface1 },
					SnacksIndentScope = { fg = colors.pink, bold = true },

					-- Git signs column
					SignColumn = { bg = "NONE" },

					-- Folded text
					Folded = { bg = "NONE" },

					Visual = { bg = colors.surface2 },
				}
			end,
			integrations = {
				blink_cmp = true,
				flash = true,
				gitsigns = true,
				grug_far = true,
				lsp_trouble = true,
				mini = { enabled = true },
				noice = true,
				snacks = { enabled = true, indent_scope_color = "pink" },
				which_key = true,
			},
		},
		specs = {
			{
				"akinsho/bufferline.nvim",
				optional = true,
				opts = function(_, opts)
					if (vim.g.colors_name or ""):find("catppuccin") then
						local bufferline_theme = require("catppuccin.special.bufferline").get

						local highlights = type(bufferline_theme) == "function" and bufferline_theme()
							or bufferline_theme

						-- Make bufferline transparent
						if type(highlights) == "table" then
							for _, hl in pairs(highlights) do
								if type(hl) == "table" and hl.bg then
									hl.bg = "NONE"
								end
							end
							opts.highlights = highlights
						end
					end
				end,
			},
		},
	},
}
