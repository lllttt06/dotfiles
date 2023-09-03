local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- 行の端に行く
keymap("n", "<Space>h", "^", opts)
keymap("n", "<Space>l", "$", opts)

-- ;でコマンド入力( ;と:を入れ替)
keymap("n", ";", ":", opts)

-- Delete a word backwards
keymap("n", "dw", 'vb"_d', opts)

-- 削除の時にコピーしない
keymap("n", "d", '"_d', opts)
keymap("x", "d", '"_d', opts);
keymap("n", "x", '"_x', opts)
keymap("x", "x", '"_x', opts);
keymap("x", "p", '"_dP', opts);

-- ファイルツリーを開く
keymap("n", "<C-n>", ":NvimTreeOpen<Return>", opts)

-- ファイル検索
keymap("n", "sf", '<cmd>lua require("telescope.builtin").find_files()<cr>',opts)
keymap("n", "sg", '<cmd>lua require("telescope.builtin").live_grep()<cr>',opts)
keymap("n", "sb", '<cmd>lua require("telescope.builtin").buffers()<cr>',opts)
keymap("n", "sh", '<cmd>lua require("telescope.builtin").help_tags()<cr>',opts)

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
keymap("t", "jj", "<C-\\><C-n>", opts)

-- buffer
keymap("n", "[b", ":bprev<CR>", opts)
keymap("n", "]b", ":bnext<CR>", opts)

