-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- Indentation
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- Cursor: blinking block in normal mode.
opt.guicursor = "n:block-blinkon500-blinkoff500,v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Turn off ~ symbols at the end of the buffer
opt.fillchars:append({ eob = " " })

-- Make search case-insensitive (unless the pattern has capitals)
opt.ignorecase = true
opt.smartcase = true

-- Needed so persistence.nvim also restores globals (e.g. bufferline pins)
opt.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"
