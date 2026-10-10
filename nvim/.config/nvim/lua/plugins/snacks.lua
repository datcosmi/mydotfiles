return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Quality of life
		bigfile = { enabled = true }, -- disable heavy features on huge files
		quickfile = { enabled = true }, -- render the file quickly before plugins load
		input = { enabled = true }, -- nicer vim.ui.input
		words = { enabled = true }, -- highlight LSP references under cursor (]] / [[)
		scope = { enabled = true }, -- scope text objects (ii / ai) and jumps ([i / ]i)
		notifier = { enabled = true, timeout = 3000 }, -- editor notifications
		rename = {}, -- LSP-aware file rename (used by the explorer and <leader>cR)
		bufdelete = {}, -- delete buffers without breaking the window layout
		scratch = {}, -- persistent scratch buffers
		dim = {}, -- dim everything except the current scope
		zen = {}, -- zen / zoom mode
		terminal = {}, -- floating terminal toggle

		-- Smooth scroll without it being too slow
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 10, total = 50 },
				easing = "linear",
			},
		},

		-- Indent guides + current scope
		indent = {
			indent = { char = "│", hl = "SnacksIndent" },
			scope = { enabled = true, char = "│", hl = "SnacksIndentScope", treesitter = { enabled = false } },
			chunk = { enabled = false },
		},

		-- Git / GitHub
		git = {},
		gitbrowse = {},
		lazygit = {}, -- needs `lazygit` in $PATH
		gh = {}, -- needs `gh` in $PATH (and `gh auth login`)

		-- Dashboard
		dashboard = {
			enabled = true,
			width = 75,
			preset = {
				header = table.concat({
					[[                                                                     ]],
					[[       ████ ██████           █████      ██                     ]],
					[[      ███████████             █████                             ]],
					[[      █████████ ███████████████████ ███   ███████████   ]],
					[[     █████████  ███    █████████████ █████ ██████████████   ]],
					[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
					[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
					[[ ██████  █████████████████████ ████ ████ █████ ████ ██████ ]],
				}, "\n"),
				keys = {
					{
						icon = "󰥨  ",
						key = "f",
						desc = "Find Files",
						action = function()
							Snacks.picker.files({ cwd = vim.fn.expand("~") })
						end,
					},
					{
						icon = "  ",
						key = "g",
						desc = "Find Words",
						action = function()
							Snacks.picker.grep({ cwd = vim.fn.expand("~") })
						end,
					},
					{
						icon = "󰱼  ",
						key = "r",
						desc = "Recent Files",
						action = function()
							Snacks.picker.recent()
						end,
					},
					{
						icon = "  ",
						key = "s",
						desc = "Restore Session",
						action = ":lua require('persistence').load()",
					},
					{
						icon = "  ",
						key = "c",
						desc = "Config",
						action = function()
							Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
						end,
					},
					{ icon = "󰒲  ", key = "l", desc = "Lazy", action = ":Lazy" },
					{
						icon = "  ",
						key = "u",
						desc = "Update Plugins",
						action = function()
							require("lazy").sync()
						end,
					},
					{ icon = "  ", key = "p", desc = "Update Parsers", action = ":TSUpdate" },
					{ icon = "󰋠  ", key = "h", desc = "Check Health", action = ":checkhealth" },
					{ icon = "  ", key = "q", desc = "Quit NeoVim", action = ":qa" },
				},
			},
			sections = {
				{ section = "header", padding = 2 },
				{ section = "keys", gap = 1, padding = 2 },
				function()
					local stats = require("lazy").stats()
					local v = vim.version()
					local text = os.date(" %d-%m-%Y   %H:%M:%S")
						.. "   "
						.. stats.count
						.. " plugins"
						.. "   v"
						.. v.major
						.. "."
						.. v.minor
						.. "."
						.. v.patch
					return { align = "center", text = { { text, hl = "footer" } } }
				end,
			},
		},

		-- Explorer and Picker
		explorer = { enabled = true, replace_netrw = true },
		picker = {
			enabled = true,
			ui_select = true,
			sources = {
				explorer = {
					hidden = true, -- show dotfiles
					ignored = true, -- show gitignored files
					-- neo-tree: width = "16%"
					layout = function()
						return {
							preset = "sidebar",
							preview = false,
							layout = { width = math.max(30, math.floor(vim.o.columns * 0.16)) },
						}
					end,
					win = {
						list = {
							keys = {
								["s"] = "edit_split",
								["v"] = "edit_vsplit",
								["t"] = "edit_tab",
							},
						},
					},
				},
			},
		},
	},

  -- stylua: ignore
  keys = {
    -- Explorer
    { "<C-n>",      function() Snacks.explorer() end,                                        desc = "File Explorer" },
    { "<leader>e",  function() Snacks.explorer() end,                                        desc = "File Explorer" },

    -- Find
    { "<leader>ff", function() Snacks.picker.files() end,                                    desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.grep() end,                                     desc = "Live Grep" },
    { "<leader>fb", function() Snacks.picker.buffers() end,                                  desc = "Buffers" },
    { "<leader>fh", function() Snacks.picker.help() end,                                     desc = "Help Pages" },
    { "<leader>fr", function() Snacks.picker.recent() end,                                   desc = "Recent Files" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,  desc = "Config Files" },
    { "<leader>fp", function() Snacks.picker.projects() end,                                 desc = "Projects" },
    { "<leader>fG", function() Snacks.picker.git_files() end,                                desc = "Git Files" },
    { "<leader><space>", function() Snacks.picker.smart() end,                               desc = "Smart Find Files" },
    { "<leader>,",  function() Snacks.picker.buffers() end,                                  desc = "Buffers" },
    { "<leader>/",  function() Snacks.picker.grep() end,                                     desc = "Grep" },
    { "<leader>:",  function() Snacks.picker.command_history() end,                          desc = "Command History" },

    -- Search
    { '<leader>s"', function() Snacks.picker.registers() end,                                desc = "Registers" },
    { "<leader>s/", function() Snacks.picker.search_history() end,                           desc = "Search History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end,                                 desc = "Autocmds" },
    { "<leader>sb", function() Snacks.picker.lines() end,                                    desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end,                             desc = "Grep Open Buffers" },
    { "<leader>sc", function() Snacks.picker.command_history() end,                          desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end,                                 desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end,                              desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                       desc = "Buffer Diagnostics" },
    { "<leader>sg", function() Snacks.picker.grep() end,                                     desc = "Grep" },
    { "<leader>sh", function() Snacks.picker.help() end,                                     desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end,                               desc = "Highlights" },
    { "<leader>si", function() Snacks.picker.icons() end,                                    desc = "Icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end,                                    desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end,                                  desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end,                                  desc = "Location List" },
    { "<leader>sm", function() Snacks.picker.marks() end,                                    desc = "Marks" },
    { "<leader>sM", function() Snacks.picker.man() end,                                      desc = "Man Pages" },
    { "<leader>sp", function() Snacks.picker.lazy() end,                                     desc = "Plugin Specs" },
    { "<leader>sq", function() Snacks.picker.qflist() end,                                   desc = "Quickfix List" },
    { "<leader>sR", function() Snacks.picker.resume() end,                                   desc = "Resume Last Picker" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                              desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                    desc = "LSP Workspace Symbols" },
    { "<leader>su", function() Snacks.picker.undo() end,                                     desc = "Undo History" },
    { "<leader>sw", function() Snacks.picker.grep_word() end,                                desc = "Word / Selection", mode = { "n", "x" } },
    { "<leader>uC", function() Snacks.picker.colorschemes() end,                             desc = "Colorschemes" },
    { "<leader>n",  function() Snacks.picker.notifications() end,                            desc = "Notification History" },

    -- Todo comments
    { "<leader>st", function() Snacks.picker.todo_comments() end,                            desc = "Todo" },
    { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },

    -- Git
    { "<leader>gg", function() Snacks.lazygit() end,                                         desc = "Lazygit" },
    { "<leader>gG", function() Snacks.lazygit({ cwd = vim.fn.expand("%:p:h") }) end,         desc = "Lazygit (file dir)" },
    { "<leader>gb", function() Snacks.picker.git_branches() end,                             desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end,                                  desc = "Git Log" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end,                             desc = "Git Log (current file)" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end,                             desc = "Git Log (current line)" },
    { "<leader>gs", function() Snacks.picker.git_status() end,                               desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end,                                desc = "Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end,                                 desc = "Git Diff (hunks)" },
    { "<leader>gB", function() Snacks.gitbrowse() end,                                       desc = "Git Browse (open)", mode = { "n", "v" } },
    { "<leader>gY", function()
        Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
      end,                                                                                    desc = "Git Browse (copy URL)", mode = { "n", "v" } },
    -- GitHub (needs the `gh` CLI)
    { "<leader>gi", function() Snacks.picker.gh_issue() end,                                 desc = "GitHub Issues (open)" },
    { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end,                desc = "GitHub Issues (all)" },
    { "<leader>gp", function() Snacks.picker.gh_pr() end,                                    desc = "GitHub Pull Requests (open)" },
    { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end,                   desc = "GitHub Pull Requests (all)" },

    -- Buffers / files
    { "<leader>bd", function() Snacks.bufdelete() end,                                       desc = "Delete Buffer" },
    { "<leader>bo", function() Snacks.bufdelete.other() end,                                 desc = "Delete Other Buffers" },
    { "<leader>cR", function() Snacks.rename.rename_file() end,                              desc = "Rename File" },

    -- Scratch / terminal / words
    { "<leader>.",  function() Snacks.scratch() end,                                         desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,                                  desc = "Select Scratch Buffer" },
    { "<c-/>",      function() Snacks.terminal() end,                                        desc = "Toggle Terminal", mode = { "n", "t" } },
    { "<c-_>",      function() Snacks.terminal() end,                                        desc = "which_key_ignore", mode = { "n", "t" } },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end,                          desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                         desc = "Prev Reference", mode = { "n", "t" } },

    -- Notifications
    { "<leader>un", function() Snacks.notifier.hide() end,                                   desc = "Dismiss Notifications" },
  },

	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Debug helpers:  dd(foo)  and  bt()
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd

				-- Toggles (these show up in which-key under <leader>u)
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option(
						"conceallevel",
						{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }
					)
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
				Snacks.toggle.zen():map("<leader>uz")
				Snacks.toggle.zoom():map("<leader>uZ")
			end,
		})
	end,
}
