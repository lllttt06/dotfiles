vim.loader.enable()

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Obsidian API key をセットする
-- vim.env.OBSIDIAN_REST_API_KEY = '86dcd3f82d555be94345a66fa7f960fdb1c7f82dede0bfd680940f6812ed9e04'
vim.opt.rtp:prepend(lazypath)
require('lazy').setup {
    spec = {
        { import = "plugins" },
    },
    ui = {
        border = "rounded",
    }
}
require('core')
--
