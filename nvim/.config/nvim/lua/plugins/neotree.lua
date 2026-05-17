return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<cr>", {})

    require("neo-tree").setup({
      window = {
        position = "left",
        width = "16%",
        auto_expand_width = true,
      },

      filesystem = {
        hijack_netrw_behavior = "open_default",
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },

        window = {
          mappings = {
            ["<cr>"] = "open",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["t"] = "open_tabnew",
          },
        },
      },
    })
  end,
}
