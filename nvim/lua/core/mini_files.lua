-- 現在のファイルのディレクトリで mini.files を開く関数
function ToggleCurrentFile()
    local current_file = vim.fn.expand('%:p:h')
    if not require('mini.files').close() then
        require('mini.files').open(current_file)
    end
end

vim.api.nvim_set_keymap('n', '<C-f>', ':lua ToggleCurrentFile()<CR>', { noremap = true, silent = true })
