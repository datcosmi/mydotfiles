vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()

    -- If this is an empty, unnamed buffer
    if vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) == "" then
      -- And there are other listed buffers
      if #vim.fn.getbufinfo({ buflisted = 1 }) > 1 then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
})
