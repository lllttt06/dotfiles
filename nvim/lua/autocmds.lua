vim.api.nvim_exec([[
  autocmd TermOpen * startinsert
]], false)

vim.api.nvim_exec([[
  autocmd BufWritePre *.dart :DartFmt
]], false)
