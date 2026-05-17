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

					-- Transparent sidebars and special windows
					NeoTreeNormal = { bg = "NONE" },
					NeoTreeNormalNC = { bg = "NONE" },

					-- Telescope transparency
					TelescopeNormal = { bg = "NONE" },
					TelescopeBorder = { bg = "NONE" },
					TelescopePromptNormal = { bg = "NONE" },
					TelescopePromptBorder = { bg = "NONE" },
					TelescopeResultsNormal = { bg = "NONE" },
					TelescopeResultsBorder = { bg = "NONE" },
					TelescopePreviewNormal = { bg = "NONE" },
					TelescopePreviewBorder = { bg = "NONE" },

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

					-- Make indent guides subtle
					IblIndent = {
						-- fg = "#615F72",
						fg = colors.surface1,
						bg = "NONE",
						bold = false,
					},
					IblWhitespace = {
						-- fg = "#615F72",
						fg = colors.surface1,
						bg = "NONE",
						bold = false,
					},

					-- Indent scope
					MiniIndentscopeSymbol = {
						fg = colors.pink,
						bold = true,
					},

					-- Git signs column
					SignColumn = { bg = "NONE" },

					-- Folded text
					Folded = { bg = "NONE" },

					-- Neo-tree specific highlights
					NeoTreeNormal = { bg = "NONE" },
					NeoTreeNormalNC = { bg = "NONE" },

					-- Make current file/directory more visible
					NeoTreeCursorLine = {
						bg = "NONE",
						fg = colors.pink,
					},

					NeoTreeCursorLineNr = {
						fg = colors.pink,
						bold = true,
					},

					-- Make the current file text stand out
					NeoTreeFileName = {
						fg = colors.text,
					},

					NeoTreeFileNameOpened = {
						fg = colors.pink,
						bold = true,
					},

					-- Directory highlighting
					NeoTreeDirectoryName = {
						fg = colors.blue,
					},

					NeoTreeDirectoryIcon = {
						fg = colors.blue,
					},

					-- Root directory
					NeoTreeRootName = {
						fg = colors.mauve,
						bold = true,
					},

					-- Git status colors
					NeoTreeGitAdded = { fg = colors.green },
					NeoTreeGitDeleted = { fg = colors.red },
					NeoTreeGitModified = { fg = colors.yellow },
					NeoTreeGitUntracked = { fg = colors.overlay2 },

					-- Indent markers in Neo-tree
					NeoTreeIndentMarker = {
						fg = "#56617D",
					},

					-- Neo-tree status line
					NeoTreeStatusLine = {
						fg = colors.text,
						bg = "NONE",
					},

					NeoTreeStatusLineNC = {
						fg = colors.subtext0,
						bg = "NONE",
					},

					-- Visual = { bg = "#4F587D" },
					-- Visual = { bg = "#5E5E75" },
					Visual = { bg = colors.surface2 },
				}
			end,
			integrations = {
				aerial = true,
				alpha = true,
				cmp = true,
				dashboard = true,
				flash = true,
				fzf = true,
				grug_far = true,
				gitsigns = true,
				headlines = true,
				illuminate = true,
				indent_blankline = true,
				leap = true,
				lsp_trouble = true,
				mason = true,
				mini = true,
				navic = { enabled = true, custom_bg = "NONE" },
				neotest = true,
				neotree = true,
				noice = true,
				notify = true,
				snacks = true,
				telescope = true,
				treesitter_context = true,
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
