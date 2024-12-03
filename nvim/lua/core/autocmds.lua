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

-- Conflict がある際にその Buffer を開く
vim.api.nvim_create_autocmd('User', {
    pattern = 'GitConflictDetected',
    callback = function()
        vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
        vim.keymap.set('n', 'cww', function()
            engage.conflict_buster()
            create_buffer_local_mappings()
        end)
    end
})

-- 前回開いたファイルのカーソル位置を復旧する
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
    pattern = "*",
    callback = function()
        local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
        if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, { row, col })
        end
    end,
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
--         if has_flutter_dependency_in_pubspec()
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
