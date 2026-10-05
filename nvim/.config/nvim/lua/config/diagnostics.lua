local severity = vim.diagnostic.severity

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  signs = {
    text = {
      [severity.ERROR] = "",
      [severity.WARN] = "",
      [severity.HINT] = "󰌵",
      [severity.INFO] = "",
    }
  }
})
