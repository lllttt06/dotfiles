local opts = { noremap = true, silent = true }

-- Define key mappings using variables for key combinations and commands
local keymap = vim.keymap.set

-- Remap space as leader key
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

-- 削除の時にコピーしない
keymap("n", "d", '"_d', opts)
keymap("x", "d", '"_d', opts)
keymap("n", "D", '"_D', opts)
keymap("x", "D", '"_D', opts)
keymap("n", "x", '"_x', opts)
keymap("x", "x", '"_x', opts)
keymap("x", "p", '"_dP', opts)

keymap("n", "-", ":NoNeckPain<cr>", opts)

-- Insert
-- Emacs keybind
keymap("i", "ii", "<ESC>", opts)
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
keymap("t", "ii", "<C-\\><C-n>", opts)

-- buffer
keymap("n", "bh", ":bprev<CR>", opts)
keymap("n", "bl", ":bnext<CR>", opts)

-- zz でカーソル位置を中央にする
local function z1()
    vim.cmd("zt")
end

-- Map the functions to keys
keymap("n", "zz", function() z1() end, opts)
