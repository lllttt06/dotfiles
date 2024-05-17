return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- UI
    use {
        'folke/tokyonight.nvim',
        config = function()
            require('tokyonight').setup {}
            vim.cmd([[colorscheme tokyonight-night]])
        end
    }
    use 'nvim-tree/nvim-web-devicons'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function() require('lualine').setup {} end
    }
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.opt.termguicolors = true

            require('bufferline').setup {
                highlights = {
                    buffer_selected = { bold = true },
                    diagnostic_selected = { bold = true },
                    info_selected = { bold = true },
                    info_diagnostic_selected = { bold = true },
                    warning_selected = { bold = true },
                    warning_diagnostic_selected = { bold = true },
                    error_selected = { bold = true },
                    error_diagnostic_selected = { bold = true },
                },
                options = {
                    offsets = { {
                        filetype = "NvimTree",
                        text = "NvimTree",
                        text_align = "center",
                        separator = true, }
                    },
                    color_icons = true,
                    diagnostics = 'nvim_lsp',
                    separator_style = "slant",
                    diagnostics_indicator = function(_, _, diagnostics_dict, _)
                        local s = " "
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == "error" and " "
                                or (e == "warning" and " " or " ")
                            s = s .. sym .. n .. ' '
                        end
                        return s
                    end
                },
            }
        end
    }

    -- Chunk の表示
    use {
        'shellRaining/hlchunk.nvim',
        config = function()
            require('hlchunk').setup {
                chunk = {
                    notify = true,
                    use_treesitter = true,
                    chars = {
                        horizontal_line = "─",
                        vertical_line = "│",
                        left_top = "╭",
                        left_bottom = "╰",
                        right_arrow = ">",
                    },
                    style = {
                        { fg = "#4FD1C5" },
                        { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
                    },
                    textobject = "",
                    max_file_size = 1024 * 1024,
                    error_sign = true,
                },
                indent = {
                    enable = false,
                }
            }
        end,
    }

    -- 非アクティブウィンドウに影をつける
    use {
        'sunjon/shade.nvim',
        config = function()
            require('shade').setup {
                overlay_opacity = 50,
                opacity_step = 1,
            }
        end
    }


    -- キーマップの表示
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    -- 通知
    use {
        'j-hui/fidget.nvim',
        config = function() require('fidget').setup {} end,
    }


    use {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                stages = 'fade_in_slide_out',
                background_colour = 'FloatShadow',
                timeout = 3000,
            }
            vim.notify = require('notify')
        end
    }

    use {
        'folke/noice.nvim',
        event = 'VimEnter',
        config = function()
            require('noice').setup {
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                        ['vim.lsp.util.stylize_markdown'] = true,
                        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            find = "%[Buffer%]",
                        },
                        opts = { skip = true },
                    },
                },
            }
        end,
        requires = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        }
    }

    -- 画像表示
    -- use {
    --     'edluffy/hologram.nvim',
    --     config = function()
    --         require('hologram').setup {
    --             auto_display = true -- WIP automatic markdown image display, may be prone to breaking
    --         }
    --     end
    -- }

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
                    color = '#4FD1C5',
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
        config = function()
            require('nvim_comment').setup {
                line_mapping = "gk",
                operator_mapping = "gkk",
            }
        end
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
        config = function()
            require('telescope').load_extension('flutter')
            -- require('telescope').load_extension('dap')
            require('telescope').load_extension('notify')
        end
    }

    -- ファイルツリー
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('nvim-tree').setup {
                filters = {
                    git_ignored = false, -- デフォルトはtrue
                },
            }
        end
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

    -- Debugger
    -- use 'mfussenegger/nvim-dap'
    -- use 'nvim-telescope/telescope-dap.nvim'
    -- use 'nvim-neotest/nvim-nio'
    -- use {
    --     'rcarriga/nvim-dap-ui',
    --     requires = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    --     config = function()
    --         require('dapui').setup({
    --             icons = { expanded = '▾', collapsed = '▸' },
    --             expand_lines = vim.fn.has('nvim-0.7'),
    --             layouts = {
    --                 {
    --                     elements = {
    --                         { id = 'scopes', size = 0.25 },
    --                         'breakpoints',
    --                         'stacks',
    --                         'watches',
    --                     },
    --                     size = 10, -- columns
    --                     position = 'bottom',
    --                 },
    --             },
    --         })
    --     end
    -- }
    -- use {
    --     'folke/neodev.nvim',
    --     config = function()
    --         require('neodev').setup {
    --             library = { plugins = { 'nvim-dap-ui' }, types = true },
    --         }
    --     end
    -- }

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
                widget_guides = { enabled = true },
                dev_tools = {
                    autostart = true,
                    auto_open_browser = false,
                },
                settings = {
                    showTodos = true,
                    completeFunctionCalls = true,
                    analysisExcludedFolders = {
                        vim.fn.expand('$HOME/.pub-cache'),
                    },
                    renameFilesWithClasses = 'prompt',
                    updateImportsOnRename = true,
                    enableSnippets = true
                },
                -- debugger = {
                --     enabled = true,
                --     -- run_via_dap = true,
                --     exception_breakpoints = {},
                --     register_configurations = function(_)
                --         require("dap").configurations.dart = {}
                --         require('dap.ext.vscode').load_launchjs()
                --     end,
                -- },
            }
        end
    }


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

    -- Multi cursor
    use 'mg979/vim-visual-multi'
end)
