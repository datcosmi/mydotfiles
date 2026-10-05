-- Lua LSP setup for editing Neovim config/plugins (replaces neodev.nvim, which
-- is deprecated). Completion for it is wired up in blink.lua.
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- luv types, only loaded when `vim.uv` is used
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- Snacks types, only loaded when `Snacks` is used
      { path = "snacks.nvim", words = { "Snacks" } },
      { path = "lazy.nvim", words = { "LazySpec" } },
    },
  },
}
