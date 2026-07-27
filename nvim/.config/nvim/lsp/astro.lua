return {
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	root_markers = { "package.json", ".git" },
	init_options = {
		typescript = {
			tsdk = "node_modules/typescript/lib",
		},
	},
	before_init = function(_, config)
		config.init_options.typescript.tsdk = config.root_dir .. "/node_modules/typescript/lib"
	end,
}
