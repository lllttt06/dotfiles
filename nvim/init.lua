require('autocmds')
require('options')
require('plugins')
require('keymaps')
require('z_autopairs')
require('z_lspconfig')
require('z_lspconfig_for_mason')
require('z_nvim_cmp')
require('z_nvim_tree')
-- Lua 関数を読み込む
require("sample")

-- コマンドを定義する
vim.api.nvim_create_user_command("IsFlutterProject", function()
    local is_flutter = require("sample")
    print("Is Flutter project: " .. tostring(is_flutter))
end, {})
