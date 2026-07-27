return {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "package.json", ".eslintrc.json", ".eslintrc.js", "eslint.config.js", ".git" },
	settings = {
		workingDirectory = { mode = "auto" },
		nodePath = "",
		experimental = {
			useFlatConfig = false,
		},
		problems = {},
		rulesCustomizations = {},
	},
}
