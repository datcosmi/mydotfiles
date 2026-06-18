-- Vim indent opts
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Set leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Cursor blink
vim.opt.guicursor = "n:block-blinkon500-blinkoff500"

-- Tabs
vim.keymap.set({ "n", "v" }, "<leader>h", ":tabp <CR>", {})
vim.keymap.set({ "n", "v" }, "<leader>l", ":tabn <CR>", {})
-- vim.keymap.set({ "n", "v" }, "<leader>x", ":tabc <CR>", {})
-- vim.keymap.set({ "n", "v" }, "<leader>X", ":tabo <CR>", {})

-- Buffers
vim.keymap.set({ "n", "v" }, "<leader>x", ":bd <CR>", {})
-- vim.keymap.set({ "n", "v" }, "<s-x>", ":close <CR>", {})

-- Turn off ~ symbols
vim.opt.fillchars = { eob = " " }

-- Format with conform
vim.api.nvim_set_keymap("n", "<leader>z", '<cmd>lua require("conform").format()<CR>', { noremap = true, silent = true })
