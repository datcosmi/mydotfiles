local map = vim.keymap.set

-- Tabs
map({ "n", "v" }, "<leader>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map({ "n", "v" }, "<leader>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })

-- Buffers: close the current buffer without messing up the window layout
map({ "n", "v" }, "<leader>x", function()
	Snacks.bufdelete()
end, { desc = "Close Buffer" })
