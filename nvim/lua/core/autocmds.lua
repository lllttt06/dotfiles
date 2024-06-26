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
-- vim.api.nvim_create_autocmd("VimEnter", {
--     pattern = "*",
--     command = "Screenkey toggle"
-- })



-- local function has_flutter_dependency_in_pubspec()
--     local pubspec = vim.fn.glob("pubspec.yaml")
--     if pubspec == "" then return false end
--     local pubspec_content = vim.fn.readfile(pubspec)
--     local joined_content = table.concat(pubspec_content, "\n")
--
--     local flutter_dependency = string.match(joined_content, "flutter:\n[%s\t]*sdk:[%s\t]*flutter")
--     return flutter_dependency ~= nil
-- end
--
-- vim.api.nvim_create_autocmd("VimEnter", {
--     pattern = "*",
--     callback = function()
--         if has_flutter_dependency_in_pubspec() then
--             vim.notify("Flutter dependency found in pubspec.yaml", "info", {
--                 title = "Neovim",
--                 timeout = 5000,
--             })
--         else
--             vim.notify("Flutter dependency not found in pubspec.yaml", "error", {
--                 title = "Neovim",
--                 timeout = 5000,
--             })
--         end
--     end
-- })
