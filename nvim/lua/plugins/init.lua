return {
    -- UI
    {
        'Mofiqul/vscode.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('vscode').setup {}
        end
    },
    {
        'nvim-tree/nvim-web-devicons'
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function() require('lualine').setup {} end
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
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
    },

    -- 中央よせ
    {
        "shortcuts/no-neck-pain.nvim", version = "*"
    },
    -- Chunk の表示
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },

    -- 通知
    {
        'j-hui/fidget.nvim',
        config = function() require('fidget').setup {} end,
    },

    {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                stages = 'fade_in_slide_out',
                background_colour = 'floatshadow',
                timeout = 3000,
            }
            vim.notify = require('notify')
        end
    },

    {
        'folke/noice.nvim',
        event = 'VimEnter',
        config = function()
            require('noice').setup {
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins **treesitter**
                    override = {
                        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                        ['vim.lsp.util.stylize_markdown'] = true,
                        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            find = "%[buffer%]",
                        },
                        opts = { skip = true },
                    },
                },
            }
        end,
        dependencies ={
            'muniftanjim/nui.nvim',
            'rcarriga/nvim-notify',
        }
    },

    -- シンタックスハイライト
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                auto_install = true,
                highlight = {
                    enable = true,
                },
            }
        end
    },
    {
        'brenoprata10/nvim-highlight-colors',
        config = function() require('nvim-highlight-colors').setup {} end
    },

    -- スクロール
    {
        'karb94/neoscroll.nvim',
        config = function()
            require('neoscroll').setup {
                mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-y>', 'zt', 'zz', 'zb' },
            }
        end
    },
    {
        'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup {
                handle = {
                    color = '#51504f',
                },
                marks = {
                    search = { color = '#f6ad55' },
                    error = { color = '#f56565' },
                    warn = { color = '#ed8936' },
                    info = { color = '#4fd1c5' },
                    hint = { color = '#68d391' },
                    misc = { color = '#805ad5' },
                }
            }
        end
    },

    -- コメントアウト
    {
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup {
                line_mapping = "gk",
                operator_mapping = "gkk",
            }
        end
    },

    -- brackets 補完
    {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup {} end
    },

    -- ファイル検索
    {
        'nvim-lua/plenary.nvim'
    },
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').load_extension('flutter')
            -- require('telescope').load_extension('dap')
            require('telescope').load_extension('notify')
        end
    },

    -- ファイルビューワ
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('oil').setup {
                columns = {
                    "icon",
                    "size",
                    "mtime",
                },
                vim.keymap.set("n", "-", "<CMD>OIL --float<CR>", { desc = "open parent directory" })
            }
        end,
    },
    -- lsp
    {
        'williamboman/mason.nvim'
    },
    {
        'williamboman/mason-lspconfig.nvim',
    },
    {
        'neovim/nvim-lspconfig',
    },

    -- cmp
    {
        'hrsh7th/nvim-cmp'
    },
    {
        'hrsh7th/cmp-nvim-lsp'
    },
    {
        'hrsh7th/vim-vsnip'
    },
    {
        'hrsh7th/cmp-path'
    },
    {
        'hrsh7th/cmp-buffer'
    },
    {
        'hrsh7th/cmp-cmdline'
    },
    {
        'onsails/lspkind.nvim'
    },

    -- debugger
    -- 'mfussenegger/nvim-dap'
    -- 'nvim-telescope/telescope-dap.nvim'
    -- 'nvim-neotest/nvim-nio'
    -- {
    --     'rcarriga/nvim-dap-ui',
    --     dependencies ={ 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
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
    -- },
    -- {
    --     'folke/neodev.nvim',
    --     config = function()
    --         require('neodev').setup {
    --             library = { plugins = { 'nvim-dap-ui' }, types = true },
    --         }
    --     end
    -- },

    -- flutter
    {
        'akinsho/flutter-tools.nvim',
        dependencies ={
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
                    showtodos = true,
                    completefunctioncalls = true,
                    analysisexcludedfolders = {
                        vim.fn.expand('$home/.pub-cache'),
                    },
                    renamefileswithclasses = 'prompt',
                    updateimportsonrename = true,
                    enablesnippets = true
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
    },

    -- auto save
    {
        'pocco81/auto-save.nvim',
        config = function()
            require('auto-save').setup {
                trigger_events = { 'insertleave', 'bufleave', 'focuslost' },
            }
        end,
    },

    -- git
    {
        'sindrets/diffview.nvim'
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {}
            require('scrollbar.handlers.gitsigns').setup {}
        end
    },
    {
        'kdheepak/lazygit.nvim',
        dependencies ={
            'nvim-lua/plenary.nvim',
        },
    },
}
