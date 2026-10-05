return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>gh", group = "hunks" },
      { "<leader>q", group = "session" },
      { "<leader>s", group = "search" },
      { "<leader>sn", group = "noice" },
      { "<leader>t", group = "trouble / todo" },
      { "<leader>u", group = "ui toggles" },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps",
    },
  },
}
