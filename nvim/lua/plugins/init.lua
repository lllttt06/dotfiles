return {
    -- Dashboard
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                        {
                            icon = ' ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                        {
                            desc = ' Apps',
                            group = 'DiagnosticHint',
                            action = 'Telescope app',
                            key = 'a',
                        },
                        {
                            desc = ' dotfiles',
                            group = 'Number',
                            action = 'Telescope dotfiles',
                            key = 'd',
                        },
                    },
                },
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },
    -- カラーテーマ
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd("colorscheme tokyonight-night")
        end
    },
    {
        "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
        config = function() require("lualine").setup {} end
    },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            vim.opt.termguicolors = true

            require("bufferline").setup {
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
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "NvimTree",
                            text_align = "center",
                            separator = true,
                        }
                    },
                    color_icons = true,
                    diagnostics = "nvim_lsp",
                    separator_style = "slant",
                    diagnostics_indicator = function(_, _, diagnostics_dict, _)
                        local s = " "
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == "error" and " "
                                or (e == "warning" and " " or " ")
                            s = s .. sym .. n .. " "
                        end
                        return s
                    end
                },
            }
        end
    },

    -- 中央寄せ
    {
        "shortcuts/no-neck-pain.nvim",
        version = "*",
    },
    -- Chunk
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            chunk = {
                enable = true,
                use_treesitter = true,
                style = {
                    { fg = "#4fd1c5" },
                    { fg = "#c21f30" },
                },
            },
            indent = { enable = true },
            line_num = { enable = true },
        },
    },
    -- 通知
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        config = function() require("fidget").setup {} end,
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            require("notify").setup {
                stages = "fade_in_slide_out",
                background_colour = "floatshadow",
                timeout = 3000,
            }
            vim.notify = require("notify")
        end
    },
    {
        "folke/noice.nvim",
        event = "VimEnter",
        config = function()
            require("noice").setup {
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins **treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
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
        dependencies = {
            "muniftanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },

    -- Diagnostics
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                preview_float = {
                    mode = "diagnostics",
                    preview = {
                        type = "float",
                        relative = "editor",
                        border = "rounded",
                        title = "Preview",
                        title_pos = "center",
                        position = { 0, -2 },
                        size = { width = 0.3, height = 0.3 },
                        zindex = 200,
                    },
                },
            },
        }, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble preview_float toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },


    -- Screenkey
    {
        "NStefan002/screenkey.nvim",
        version = "*",
        event = "VeryLazy",
    },


    -- シンタックスハイライト
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                auto_install = true,
                highlight = {
                    enable = true,
                },
            }
        end
    },
    {
        "brenoprata10/nvim-highlight-colors",
        event = "VeryLazy",
        config = function() require("nvim-highlight-colors").setup {} end
    },

    -- カーソル位置ハイライト
    {
        "RRethy/vim-illuminate",
        event = 'VeryLazy',
        config = function()
            require('illuminate').configure({
                providers = {
                    'lsp',
                    'treesitter',
                },
                delay = 100,
                filetype_overrides = {},
                filetypes_denylist = {
                    'dirvish',
                    'fugitive',
                },
                filetypes_allowlist = {},
                modes_denylist = {},
                modes_allowlist = {},
                providers_regex_syntax_denylist = {},
                providers_regex_syntax_allowlist = {},
                under_cursor = true,
                large_file_cutoff = nil,
                large_file_overrides = nil,
                min_count_to_highlight = 1,
            })
        end
    },

    -- スクロール
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        config = function()
            require("neoscroll").setup {
                mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-y>", "zt", "zz", "zb" },
            }
        end
    },
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = function()
            require("scrollbar").setup {
                handle = {
                    color = "#51504f",
                },
                marks = {
                    search = { color = "#f6ad55" },
                    error = { color = "#f56565" },
                    warn = { color = "#ed8936" },
                    info = { color = "#4fd1c5" },
                    hint = { color = "#68d391" },
                    misc = { color = "#805ad5" },
                }
            }
        end
    },

    -- コメントアウト
    {
        "terrortylor/nvim-comment",
        event = "VeryLazy",
        config = function()
            require("nvim_comment").setup {
                line_mapping = "gk",
                operator_mapping = "gkk",
            }
        end
    },

    -- brackets 補完
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function() require("nvim-autopairs").setup {} end
    },

    -- ファイル検索
    {
        "nvim-lua/plenary.nvim",
        event = "VeryLazy",
    },

    -- Motion
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = {
            "folke/trouble.nvim",
        },
        config = function()
            local focus_preview = function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local picker = action_state.get_current_picker(prompt_bufnr)
                local prompt_win = picker.prompt_win
                local previewer = picker.previewer
                local winid = previewer.state.winid
                local bufnr = previewer.state.bufnr
                vim.keymap.set("n", "<Tab>", function()
                    vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
                end, { buffer = bufnr })
                vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
                -- api.nvim_set_current_win(winid)
            end

            require("telescope").setup {
                defaults = {
                    mappings = {
                        n = {
                            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
                            ["<Tab>"] = focus_preview,
                            ["Q"] = require("telescope.actions").close,
                        },
                        i = {
                            ["<esc>"] = require("telescope.actions").close,
                            ["<C-u>"] = false,
                            ["<S-Tab>"] = false,
                            ["<Tab>"] = focus_preview,
                            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
                        },
                    },
                },
            }
            require("telescope").load_extension("flutter")
            -- require("telescope").load_extension("dap")
            require("telescope").load_extension("notify")
        end
    },

    -- ファイルビューワ
    {
        'echasnovski/mini.nvim',
        version = false,
        event = "VeryLazy",
        keys = {
            -- mini.filesオープン用のショートカット
            { '<C-n>', ':lua if not MiniFiles.close() then MiniFiles.open() end<CR>' }
        },
        config = function()
            require('mini.files').setup({})
        end,
    },

    -- lsp
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
    },

    -- cmp
    {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "onsails/lspkind.nvim",
        event = "VeryLazy",
    },

    -- snippet
    {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy",
        config = function()
            require("luasnip").config.set_config {
                history = true,
                updateevents = "TextChanged,TextChangedI",
            }
        end
    },
    {
        "rafamadriz/friendly-snippets",
        event = "VeryLazy",
    },
    {
        "saadparwaiz1/cmp_luasnip",
        event = "VeryLazy",
    },

    -- debugger
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            'nvim-neotest/nvim-nio',
            'rcarriga/nvim-dap-ui',
        },
        event = 'VeryLazy',
        config = function()
            require("dapui").setup({
                icons = { expanded = "▾", collapsed = "▸" },
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.25 },
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 10, -- columns
                        position = "bottom",
                    },
                },
            })
        end
    },

    -- Flutter
    {
        "akinsho/flutter-tools.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
        },
        config = function()
            require("flutter-tools").setup {
                flutter_path = nil,
                flutter_lookup_cmd = "asdf where flutter",
                fvm = false,
                widget_guides = { enabled = true },
                lsp = {
                    settings = {
                        showtodos = true,
                        completefunctioncalls = true,
                        analysisexcludedfolders = {
                            vim.fn.expand("$Home/.pub-cache"),
                        },
                        renamefileswithclasses = "prompt",
                        updateimportsonrename = true,
                        enablesnippets = false,
                    },
                },
                debugger = {
                    enabled = true,
                    run_via_dap = true,
                    exception_breakpoints = {},
                    register_configurations = function(paths)
                        local dap = require("dap")
                        -- これを入れないと debugger が動かない
                        -- See also: https://github.com/akinsho/flutter-tools.nvim/pull/292
                        dap.adapters.dart = {
                            type = "executable",
                            command = paths.flutter_bin,
                            args = { "debug-adapter" },
                        }
                        dap.configurations.dart = {}
                        require("dap.ext.vscode").load_launchjs()
                    end,
                },
            }
        end
    },

    -- auto save
    {
        "pocco81/auto-save.nvim",
        event = "VeryLazy",
        config = function()
            require("auto-save").setup {
                trigger_events = { "InsertLeave", "BufLeave", "FocusLost" },
            }
        end,
    },

    -- ToggleTerm
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        version = "*",
        config = function()
            require("toggleterm").setup {
                open_mapping = [[<C-\>]],
                direction = "float",
                float_opts = {
                    border = "curved",
                    winblend = 10,
                },
            }
        end
    },

    -- git
    {
        "kdheepak/lazygit.nvim",
        event = "VeryLazy",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require('gitsigns').setup()
        end
    },

    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    debounce = 75,
                    keymap = {
                        accept = "<C-a>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    yaml = true,
                    markdown = true,
                    help = false,
                    gitcommit = true,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
            })
        end,
    },
}
