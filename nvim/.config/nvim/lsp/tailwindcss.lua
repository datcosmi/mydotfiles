return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "astro" },
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "package.json", ".git" },
}
