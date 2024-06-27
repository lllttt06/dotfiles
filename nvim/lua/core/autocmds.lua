vim.api.nvim_exec([[
  autocmd TermOpen * startinsert
  cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. '%s///g<Left><Left>' : 's'
]], false)

-- ターミナルモードで行番号を非表示
vim.cmd [[
  autocmd TermOpen * setlocal norelativenumber
  autocmd TermOpen * setlocal nonumber
]]

-- Neovimを開いた際に :NoNeckPain コマンドを実行
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    command = "NoNeckPain"
})

