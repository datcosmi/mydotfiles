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
		-- Use the project's own TypeScript (guard: root_dir can be nil for single files)
		if config.root_dir then
			config.init_options.typescript.tsdk = config.root_dir .. "/node_modules/typescript/lib"
		end
	end,
}
