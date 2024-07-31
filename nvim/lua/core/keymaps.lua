local opts = { noremap = true, silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<space>", "<Nop>", opts)

-- Esc 連打でハイライトを消す
keymap("n", "<Esc><Esc>", ":nohlsearch<CR><Esc>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- 行の端に行く
keymap("n", "<C-a>", "^", opts)
keymap("n", "<C-e>", "$", opts)

-- ;でコマンド入力( ;と:を入れ替)
keymap("n", ";", ":", opts)

-- Delete a word backwards
keymap("n", "dw", 'vb"_d', opts)

-- 削除の時にコピー
keymap("n", "d", '"_d', opts)
keymap("x", "d", '"_d', opts)
keymap("n", "x", '"_x', opts)
keymap("x", "x", '"_x', opts)
keymap("x", "p", '"_dP', opts)

-- バッファを中央に寄せる
keymap("n", "-", ":NoNeckPain<cr>", opts)

-- ScreenKey
keymap("n", "sk", ':Screenkey toggle<cr>', opts)

-- ファイル検索
keymap("n", "sf", '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
keymap("n", "sg", '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
keymap("n", "sb", '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
keymap("n", "sh", '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)
keymap("n", "sn", '<cmd>lua require("telescope").extensions.notify.notify()<cr>', opts)
keymap("n", "fl", '<cmd>lua require("telescope").extensions.flutter.commands()<cr>', opts)

-- Insert
-- Emacs keybind
keymap("i", "jj", "<ESC>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-l>", "<Right>", opts)
keymap("i", "<C-a>", "<C-o>^", opts)
keymap("i", "<C-e>", "<C-o>$", opts)

-- Terminal
keymap("n", "@t", ":terminal<CR>", opts)
keymap('n', '@tv', '<C-w>v<C-w><C-w>:terminal<CR>', opts)
keymap('n', '@ts', '<C-w>s<C-w><C-w>:terminal<CR>', opts)
keymap("t", "jj", "<C-\\><C-n>", opts)

-- buffer
keymap("n", "bh", ":bprev<CR>", opts)
keymap("n", "bl", ":bnext<CR>", opts)
