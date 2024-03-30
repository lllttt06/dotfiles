return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- UI
    use {
        'folke/tokyonight.nvim',
        config = function()
            vim.cmd([[colorscheme tokyonight-night]])
        end
    }
    use 'nvim-tree/nvim-web-devicons'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function() require('lualine').setup {} end
    }
    use { 'kdheepak/tabline.nvim',
        config = function() require('tabline').setup {} end
    }
    use {
        'echasnovski/mini.indentscope',
        config = function()
            require('mini.indentscope').setup {
                symbol = '▏',
            }
        end,
    }

    -- Code highlight
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                auto_install = true,
                highlight = {
                    enable = true,
                },
            }
        end
    }
    use {
        'brenoprata10/nvim-highlight-colors',
        config = function() require('nvim-highlight-colors').setup {} end
    }

    -- スクロール
    use {
        'karb94/neoscroll.nvim',
        config = function()
            require('neoscroll').setup {
                mappings = { '<C-u>', '<C-d>', '<C-b>',
                    '<C-y>', 'zt', 'zz', 'zb' },
            }
        end
    }
    use {
        'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup {
                handle = {
                    color = '#292e42',
                },
                marks = {
                    Search = { color = '#F6AD55' },
                    Error = { color = '#F56565' },
                    Warn = { color = '#ED8936' },
                    Info = { color = '#4FD1C5' },
                    Hint = { color = '#68D391' },
                    Misc = { color = '#805AD5' },
                }
            }
        end
    }

    -- コメントアウト
    use {
        'terrortylor/nvim-comment',
        config = function() require('nvim_comment').setup {} end
    }

    -- brackets 補完
    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup {} end
    }

    -- ファイル検索
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        config = function() require('telescope').load_extension('flutter') end
    }

    -- ファイルツリー
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }

    -- Lsp
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    }

    -- Cmp
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'onsails/lspkind.nvim'

    -- Flutter
    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim',
        },
        config = function()
            require('flutter-tools').setup {
                flutter_lookup_cmd = 'asdf where flutter',
                dev_tools = {
                    autostart = true,          -- autostart devtools server if not detected
                    auto_open_browser = false, -- Automatically opens devtools in the browser
                },
                settings = {
                    analysisExcludedFolders = {},
                },
                debugger = {
                    enabled = true,
                    run_via_dap = true,
                    exception_breakpoints = {},
                    register_configurations = function(_)
                        require('dap').configurations.dart = {}
                        require('dap.ext.vscode').load_launchjs()
                    end,
                },
            }
        end
    }

    -- Debugger
    use 'mfussenegger/nvim-dap'

    -- auto save
    use {
        'Pocco81/auto-save.nvim',
        config = function()
            require('auto-save').setup {
                trigger_events = { 'InsertLeave', 'BufLeave', 'FocusLost' },
            }
        end,
    }

    -- Git
    use 'sindrets/diffview.nvim'
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {}
            require('scrollbar.handlers.gitsigns').setup {}
        end
    }
    use {
        'kdheepak/lazygit.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
    }
end)
