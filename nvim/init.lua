require("autocmds")
require("options")
require("plugins")
require("keymaps")
require("z_autopairs")
require("z_lspconfig")
require("z_nvim_cmp")
require("z_nvim_tree")
require("flutter-tools").setup({
  flutter_lookup_cmd = "asdf where flutter",
})
require("lualine").setup()
require("tabline").setup()
require("mini.indentscope").setup({
  symbol = "▏",
})
require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = {
    enable = true,
  },
})
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
vim.cmd[[colorscheme tokyonight-moon]] 
