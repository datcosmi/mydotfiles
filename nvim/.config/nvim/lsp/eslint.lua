local root_files = {
	".eslintrc",
	".eslintrc.js",
	".eslintrc.cjs",
	".eslintrc.yaml",
	".eslintrc.yml",
	".eslintrc.json",
	"eslint.config.js",
	"eslint.config.mjs",
	"eslint.config.cjs",
	"eslint.config.ts",
	"eslint.config.mts",
	"eslint.config.cts",
	"package.json",
	".git",
}

return {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = root_files,
	settings = {
		validate = "on",
		run = "onType",
		format = false, -- formatting is handled by conform.nvim
		quiet = false,
		onIgnoredFiles = "off",
		useESLintClass = false,
		workingDirectory = { mode = "auto" },
		nodePath = "",
		problems = { shortenToSingleLine = false },
		rulesCustomizations = {},
		experimental = vim.empty_dict(),
		codeAction = {
			disableRuleComment = { enable = true, location = "separateLine" },
			showDocumentation = { enable = true },
		},
	},
	-- The server needs to know the workspace folder
	before_init = function(_, config)
		local root = config.root_dir
		if root then
			config.settings = config.settings or {}
			config.settings.workspaceFolder = { uri = vim.uri_from_fname(root), name = vim.fn.fnamemodify(root, ":t") }
		end
	end,
	-- Custom requests the eslint server sends and expects an answer to
	handlers = {
		["eslint/openDoc"] = function(_, result)
			if result then
				vim.ui.open(result.url)
			end
			return {}
		end,
		["eslint/confirmESLintExecution"] = function(_, result)
			if not result then
				return
			end
			return 4 -- approved
		end,
		["eslint/probeFailed"] = function()
			vim.notify("ESLint probe failed.", vim.log.levels.WARN)
			return {}
		end,
		["eslint/noLibrary"] = function()
			vim.notify("Unable to find ESLint library.", vim.log.levels.WARN)
			return {}
		end,
	},
}
