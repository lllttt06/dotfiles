return {
    -- Dashboard
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u', },
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
                            action = 'edit ~/dotfiles/nvim/lua/plugins/init.lua',
                            key = 'd',
                        },
                    },
                },
            }
        end,
    },
    -- {
    --     'AlexvZyl/nordic.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require('nordic').load()
    --         require('lualine').setup {
    --             options = {
    --                 theme = 'nordic'
    --             }
    --         }
    --     end
    -- },
    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd("colorscheme vscode")
        end
    },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function()
    --         vim.cmd("colorscheme tokyonight-night")
    --     end
    -- },
    {
        "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'linrongbin16/lsp-progress.nvim',
            'AndreM222/copilot-lualine',
            'uloco/bluloco.nvim',
        },
        event = 'VimEnter', -- 画面がちらつく
        config = function()
            require('lsp-progress').setup {}
            local lualine = require 'lualine'
            local config = {
                options = {
                    disabled_filetypes = {
                        statusline = { 'alpha' },
                    },
                    component_separators = '',
                    section_separators = { right = '', left = '' },
                },
                sections = {
                    lualine_a = {
                        {
                            function()
                                return ''
                            end,
                            padding = { left = 2, right = 2 },
                            separator = { right = '' },
                        },
                    },
                    lualine_b = {
                        {
                            'branch',
                            icon = ' ',
                            padding = { left = 2, right = 1 },
                            separator = { right = '' },
                        },
                    },
                    lualine_c = {
                        "'%='",
                        {
                            'diff',
                            symbols = { added = '  ', modified = '  ', removed = '  ' },
                            separator = ' ',
                        },
                        {
                            'diagnostics',
                            sources = { 'nvim_diagnostic' },
                            symbols = { error = '  ', warn = '  ', info = '  ', hint = '  ' },
                        },
                    },
                    lualine_x = {
                        function()
                            return require('lsp-progress').progress {
                                format = function(messages)
                                    local active_clients = vim.lsp.get_clients()
                                    local client_count = #active_clients
                                    if #messages > 0 then
                                        return ' LSP:' ..
                                            client_count ..
                                            ' ' .. table.concat(messages, ' ')
                                    end
                                    if #active_clients <= 0 then
                                        return ' LSP:' .. client_count
                                    else
                                        local client_names = {}
                                        for _, client in ipairs(active_clients) do
                                            if client and client.name ~= '' then
                                                table.insert(
                                                    client_names,
                                                    '[' ..
                                                    client.name ..
                                                    ']')
                                            end
                                        end
                                        return ' LSP:' ..
                                            client_count ..
                                            ' ' ..
                                            table.concat(client_names, ' ')
                                    end
                                end,
                            }
                        end,
                    },
                    lualine_y = {
                        {
                            'copilot',
                            symbols = {
                                -- spinners = require("copilot-lualine.spinners").moon
                                -- https://github.com/AndreM222/copilot-lualine/blob/main/lua/copilot-lualine/spinners.lua
                                spinners = {
                                    ' ',
                                    ' ',
                                    ' ',
                                    ' ',
                                    ' ',
                                    ' ',
                                    ' ',
                                    ' ',
                                    ' ',
                                    ' ',
                                    ' ',
                                    ' ',
                                    ' ',
                                    ' ',
                                },
                            },
                            separator = { left = '' },
                            padding = { left = 1, right = 2 },
                        },
                    },
                    lualine_z = {
                        {
                            'filetype',
                            icons_enabled = false,
                            separator = { left = '' },
                            padding = { left = 1, right = 2 },
                        },
                    },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
            }
            lualine.setup(config)
        end,
    },
    -- Buffer
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
    {
        "j-morano/buffer_manager.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>b", ":lua require('buffer_manager.ui').toggle_quick_menu()<cr>", desc = "Buffer Manager" }
        },

    },

    -- 中央寄せ
    {
        "shortcuts/no-neck-pain.nvim",
        version = "*",
        config = function()
            require("no-neck-pain").setup {
                width = 125,
            }
        end,
    },

    -- Chunk
    {
        'echasnovski/mini.indentscope',
        event = { 'BufRead', 'BufNewFile' },
        config = function()
            require('mini.indentscope').setup {
                options = {
                    try_as_border = false,
                    indent_at_cursor = true,
                },
                draw = {
                    delay = 100,
                },
                mappings = {
                    object_scope = 'ii',
                    object_scope_with_border = 'ai',
                    goto_top = '[i',
                    goto_bottom = ']i',
                },
            }

            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
                    'help',
                    'alpha',
                    'Trouble',
                    'lazy',
                    'mason',
                    'notify',
                    'toggleterm',
                    'lazyterm',
                    'NvimTree',
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    -- 通知
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        config = function() require("fidget").setup {} end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "muniftanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("notify").setup {
                stages = "fade_in_slide_out",
                background_colour = "floatshadow",
                timeout = 500,
            }
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
                        title = "Trouble Preview",
                        title_pos = "center",
                        position = { 18, 2 },
                        size = { width = 0.5, height = 0.4 },
                        zindex = 200,
                    },
                },
            },
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>dd",
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
        keys = {
            { "sk", mode = { "n" }, function() require("screenkey").toggle() end, desc = "Screenkey" },
        }
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
    -- Help ページのハイライト
    {
        "OXY2DEV/helpview.nvim",
        lazy = false, -- Recommended
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        }
    },
    {
        "brenoprata10/nvim-highlight-colors",
        event = "VeryLazy",
        config = function() require("nvim-highlight-colors").setup {} end
    },
    -- ログハイライト
    {
        'fei6409/log-highlight.nvim',
        ft = 'log',
        config = function()
            -- ログのバッファだけ背景色を変える
            -- vim.api.nvim_create_autocmd('FileType', {
            --     pattern = 'log',
            --     callback = function()
            --         vim.cmd 'highlight LogNormal guibg=#282828 ctermbg=darkgray'
            --         vim.cmd 'setlocal winhighlight=Normal:LogNormal'
            --     end,
            -- })
        end,
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
        "sphamba/smear-cursor.nvim",
        opts = {},
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
    {
        'gen740/SmoothCursor.nvim',
        event = "VeryLazy",
        config = function()
            require('smoothcursor').setup()
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
    -- TODO コメント
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        opts = {},
    },

    -- brackets 補完
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function() require("nvim-autopairs").setup {} end
    },
    -- surround 操作
    {
        'tpope/vim-surround',
        event = 'VeryLazy',
    },

    -- ファイル検索
    {
        "nvim-lua/plenary.nvim",
        event = "VeryLazy",
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        keys = {
            { "sf", mode = { "n" }, function() require("telescope.builtin").find_files({ hidden = true }) end, },
            { "sg", mode = { "n" }, function() require("telescope.builtin").live_grep({ hidden = true }) end, },
            { "sb", mode = { "n" }, function() require("telescope.builtin").buffers() end, },
            { "sh", mode = { "n" }, function() require("telescope.builtin").help_tags() end, },
            -- {
            --     "<leader>ccp",
            --     mode = { "n", "v" },
            --     function()
            --         local actions = require("CopilotChat.actions")
            --         require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
            --     end,
            --     desc = "CopilotChat - Prompt actions",
            -- },

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
                    vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)",
                        prompt_win))
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
            vim.keymap.set("n", "sn", '<cmd>lua require("telescope").extensions.notify.notify()<cr>')
            vim.keymap.set("n", "fl", '<cmd>lua require("telescope").extensions.flutter.commands()<cr>')
        end
    },

    -- Url Open
    {
        "sontungexpt/url-open",
        event = "VeryLazy",
        cmd = "URLOpenUnderCursor",
        config = function()
            local status_ok, url_open = pcall(require, "url-open")
            if not status_ok then
                return
            end
            url_open.setup({})
            vim.keymap.set("n", "gl", "<esc>:URLOpenUnderCursor<cr>")
        end,
    },

    -- ファイルビューワ
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'b0o/nvim-tree-preview.lua',
        },
        event = 'VeryLazy',
        config = function()
            local preview = require 'nvim-tree-preview'
            local function on_attach(bufnr)
                local api = require 'nvim-tree.api'
                local function opts(desc)
                    return {
                        desc = 'nvim-tree: ' .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true,
                    }
                end

                api.config.mappings.default_on_attach(bufnr)
                -- カーソルの巡回を行う
                local function wrap_cursor(direction)
                    local line_count = vim.api.nvim_buf_line_count(bufnr)
                    local cursor = vim.api.nvim_win_get_cursor(0)
                    if direction == 'j' then
                        if cursor[1] == line_count then
                            vim.api.nvim_win_set_cursor(0, { 1, 0 })
                        else
                            vim.api.nvim_win_set_cursor(0, { cursor[1] + 1, 0 })
                        end
                    elseif direction == 'k' then
                        if cursor[1] == 1 then
                            vim.api.nvim_win_set_cursor(0, { line_count, 0 })
                        else
                            vim.api.nvim_win_set_cursor(0, { cursor[1] - 1, 0 })
                        end
                    end
                end
                vim.keymap.set('n', 'j', function()
                    wrap_cursor 'j'
                end, opts 'Down')
                vim.keymap.set('n', 'k', function()
                    wrap_cursor 'k'
                end, opts 'Up')
                vim.keymap.set('n', 'x', api.node.run.system, opts 'Open System')
                vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
                vim.keymap.set('n', '=', api.tree.change_root_to_node, opts 'CD')
                vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts 'Dir Up')
                vim.keymap.set('n', 'l', api.node.open.edit, opts 'Edit')
                vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Node')
                vim.keymap.set('n', 's', '', opts 'Nop')
                vim.keymap.set('n', 'sl', '<c-w>l', opts 'Nop')
                vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
                vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
                vim.keymap.set('n', '<Tab>', function()
                    local ok, node = pcall(api.tree.get_node_under_cursor)
                    if ok and node then
                        if node.type == 'directory' then
                            api.node.open.edit()
                        else
                            preview.watch()
                        end
                    end
                end, opts 'Preview')
            end

            preview.setup {
                keymaps = {
                    ['<Esc>'] = { action = 'close', unwatch = true },
                },
                min_width = 60,
                min_height = 15,
                max_width = 160,
                max_height = 40,
                wrap = false,       -- Whether to wrap lines in the preview window
                border = 'rounded', -- Border style for the preview window
            }

            require('nvim-tree').setup {
                on_attach = on_attach,
                view = {
                    signcolumn = 'yes',
                    float = {
                        enable = true,
                        open_win_config = {
                            height = 65,
                            width = 50,
                        },
                    },
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = false,
                },
                diagnostics = {
                    enable = true,
                    icons = {
                        hint = ' ',
                        info = ' ',
                        warning = ' ',
                        error = ' ',
                    },
                    show_on_dirs = true,
                },
                renderer = {
                    group_empty = true,
                    highlight_git = true,
                    highlight_opened_files = 'name',
                    icons = {
                        git_placement = 'signcolumn',
                        modified_placement = 'signcolumn',
                        glyphs = {
                            git = {
                                deleted = '',
                                unstaged = '',
                                untracked = '',
                                staged = '',
                                unmerged = '',
                                renamed = '»',
                                ignored = '◌',
                            },
                        },
                    },
                },
                filters = {
                    dotfiles = false,
                },
                git = {
                    enable = true,
                    ignore = false,
                },
            }
            vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', {
                noremap = true,
                silent = true,
            })
            vim.keymap.set('n', '<C-f>', ':NvimTreeFindFile<CR>', {
                noremap = true,
                silent = true,
            })
        end,
    },
    -- ---@type LazySpec
    -- {
    --     "mikavilpas/yazi.nvim",
    --     event = "VeryLazy",
    --     keys = {
    --         -- 👇 in this section, choose your own keymappings!
    --         {
    --             "<C-f>",
    --             "<cmd>Yazi<cr>",
    --             desc = "Open yazi at the current file",
    --         },
    --         {
    --             -- Open in the current working directory
    --             "<leader>cw",
    --             "<cmd>Yazi cwd<cr>",
    --             desc = "Open the file manager in nvim's working directory",
    --         },
    --         {
    --             -- NOTE: this requires a version of yazi that includes
    --             -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
    --             '<c-up>',
    --             "<cmd>Yazi toggle<cr>",
    --             desc = "Resume the last yazi session",
    --         },
    --     },
    --     ---@type YaziConfig
    --     opts = {
    --         -- if you want to open yazi instead of netrw, see below for more info
    --         open_for_directories = false,
    --         keymaps = {
    --             show_help = '<C-g>',
    --         },
    --     },
    -- },

    -- nvim-tree でファイル名変更した場合などに自動で更新
    {
        'antosha417/nvim-lsp-file-operations',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-tree.lua',
        },
        event = 'VeryLazy',
        config = function()
            require('lsp-file-operations').setup()
        end,
    },

    -- LSP Management
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.keymap.set('n', '<space>di', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
            vim.keymap.set('n', '<space>qq', vim.diagnostic.setqflist)

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig.sourcekit.setup {
                capabilities = {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                },
            }
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
            require("mason-lspconfig").setup()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- LSP
                    -- "typos-lsp",
                    "gopls",
                    "lua-language-server",
                    "typescript-language-server",
                    "graphql-language-service-cli",

                    -- Formatter
                    "prettier",
                    "actionlint",
                    "goimports",
                    "ktlint",
                    "shellcheck",
                    "shfmt",
                    "swiftlint",
                    "yamlfmt",
                    "yamllint",
                },
                auto_update = true,
                run_on_start = true,
                start_delay = 3000,
                debounce_hours = 5,
            })
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    -- if server_name ~= "dartls" then
                    lspconfig[server_name].setup({
                        -- on_attach = on_attach,
                        capabilities = capabilities,
                    })
                    -- end
                end,
            })
        end,
    },

    -- LSP のガベージコレクション
    {
        'zeioth/garbage-day.nvim',
        dependencies = 'neovim/nvim-lspconfig',
        event = 'VeryLazy',
        opts = {
            excluded_lsp_clients = { 'copilot', 'dartls', 'sourcekit' },
            aggressive_mode = false,
            grace_period = 60 * 30, -- 30 minutes
            wakeup_delay = 5000,
            notifications = true,
        },
    },

    -- LSP cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "onsails/lspkind-nvim",
            "L3MON4D3/LuaSnip",
            "vim-skk/skkeleton",
        },
        event = { "InsertEnter", "LspAttach" },
        config = function()
            vim.diagnostic.config({
                -- virtual_text は非表示
                -- virtual_text = {
                --   severity = vim.diagnostic.severity.ERROR,
                -- },
                virtual_text = false,
                -- signcolumn のアイコンを変える
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                },
            })

            local cmp = require("cmp")
            local types = require("cmp.types")
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")

            lspkind.init({
                mode = "symbol_text",
                symbol_map = {
                    Copilot = "",
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰊕",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈙",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                },
            })

            vim.opt.completeopt = { "menu", "menuone", "noselect" }
            vim.o.completefunc = 'v:lua.require("cmp").complete()'

            local has_words_before = function()
                if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    autocomplete = {
                        types.cmp.TriggerEvent.InsertEnter,
                        types.cmp.TriggerEvent.TextChanged,
                    },
                    completeopt = "longest,menu,menuone,noselect,noinsert,preview",
                    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
                    keyword_length = 1,
                },
                window = {
                    completion = cmp.config.window.bordered({
                        border = "rounded",
                        -- max_width = 80,
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                    }),
                    documentation = cmp.config.window.bordered({
                        border = "rounded",
                    }),
                },
                formatting = {
                    expandable_indicator = true,
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = lspkind.cmp_format({
                            ellipsis_char = "…",
                            maxwidth = 50,
                            mode = "symbol_text",
                            with_text = true,
                        })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"

                        return kind
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.confirm({ select = true })
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end),
                    ['<C-s>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end)
                }),
                sources = cmp.config.sources({
                    { name = "copilot",                 group_index = 2 },
                    { name = "nvim_lsp",                group_index = 2 },
                    { name = "luasnip",                 group_index = 2 },
                    { name = "nvim_lsp_signature_help", group_index = 2 },
                    { name = "path",                    group_index = 2 },
                    { name = "skkeleton",               group_index = 2 },
                }, {
                    { name = "buffer", group_index = 2 },
                }),
                experimental = {
                    native_menu = false,
                    ghost_text = { hl_group = 'BufferInactive' },
                },
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "nvim_lsp_document_symbol" },
                }, {
                    { name = "buffer" },
                }),
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })
        end,
    },

    -- SKK
    {
        "vim-skk/skkeleton",
        dependencies = {
            "vim-denops/denops.vim",
            -- nvim-cmp との連携
            "rinx/cmp-skkeleton"
        },
        keys = {
            { "<C-t>", mode = { "i", "c", "t" }, '<Plug>(skkeleton-enable)', desc = "skkeleton" },
        },
        config = function()
            vim.fn['skkeleton#config']({
                eggLikeNewline = true,
                keepState = true,
                globalDictionaries = {
                    '~/dotfiles/skk/SKK-JISYO.L',
                },
            })
        end
    },

    -- LSP Copilot
    {
        'zbirenbaum/copilot-cmp',
        dependencies = {
            'zbirenbaum/copilot.lua',
        },
        event = { 'InsertEnter', 'LspAttach' },
        fix_pairs = true,
        cmd = 'Copilot',
        config = function()
            -- Copilot の Suggestion の色を変更する
            vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#E5C07B" })
            require('copilot').setup {
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = false,
                },
                filetypes = {
                    yaml = true,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ['.'] = false,
                },
                -- copilot_node_command = vim.env.HOME .. '/.asdf/shims/node',
                server_opts_overrides = {},
            }
            require('copilot.api').register_status_notification_handler(function(data)
                local ns = vim.api.nvim_create_namespace 'user.copilot'
                vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
                if vim.fn.mode() == 'i' and data.status == 'InProgress' then
                    vim.api.nvim_buf_set_extmark(0, ns, vim.fn.line '.' - 1, 0, {
                        virt_text = { { '  ...', 'Comment' } },
                        virt_text_pos = 'eol',
                        hl_mode = 'combine',
                    })
                end
            end)
            require('copilot_cmp').setup {
                method = 'getCompletionsCycling',
            }
        end,
    },
    -- {
    --     "CopilotC-Nvim/CopilotChat.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    --         { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    --     },
    --     build = "make tiktoken",          -- Only on MacOS or Linux
    --     keys = {
    --         { "<leader>cc", "<cmd>CopilotChatToggle<cr>",       desc = "CopilotChat" },
    --         { "<leader>co", "<cmd>CopilotChatCommitStaged<cr>", desc = "CopilotChat" },
    --         { "<leader>cr", "<cmd>CopilotChatReview<cr>",       desc = "CopilotChat" }
    --     },
    --     config = function()
    --         local select = require('CopilotChat.select')
    --         local commit_staged_prompt = [[
    --             以下の条件を踏まえて変更に対するコミットメッセージを書いてください。
    --
    --             - コミットメッセージのprefixは、commitizenの規約に従ってください。
    --             - コミットメッセージ本文は日本語で書いてください。
    --             - タイトルは最大50文字、変更理由を含めてください。
    --             - メッセージは72文字で折り返してください。
    --             - コミットメッセージをgitcommit言語のコードブロックで囲んでください。
    --         ]]
    --
    --         require('CopilotChat').setup {
    --             debug = true,               -- Enable debugging
    --             window = {
    --                 layout = 'float',       -- 'vertical', 'horizontal', 'float', 'replace'
    --                 width = 0.7,            -- fractional width of parent, or absolute width in columns when > 1
    --                 height = 0.7,           -- fractional height of parent, or absolute height in rows when > 1
    --                 relative = 'editor',    -- 'editor', 'win', 'cursor', 'mouse'
    --                 border = 'rounded',     -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
    --                 row = nil,              -- row position of the window, default is centered
    --                 col = nil,              -- column position of the window, default is centered
    --                 title = 'Copilot Chat', -- title of chat window
    --                 footer = nil,           -- footer of chat window
    --                 zindex = 1,             -- determines if window is on top or below other floating windows
    --             },
    --             prompts = {
    --                 Explain = {
    --                     prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text in Japanese.',
    --                 },
    --                 Fix = {
    --                     prompt =
    --                     '/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed. If you explane the problem, it will be in Japanese.',
    --                 },
    --                 Optimize = {
    --                     prompt = '/COPILOT_GENERATE Optimize the selected code to improve performance and readability.',
    --                 },
    --                 Docs = {
    --                     prompt = '/COPILOT_GENERATE Please add documentation comment for the selection in Japanese.',
    --                 },
    --                 Tests = {
    --                     prompt = '/COPILOT_GENERATE Please generate tests for my code.',
    --                 },
    --                 FixDiagnostic = {
    --                     prompt = 'Please assist with the following diagnostic issue in file:',
    --                     selection = select.diagnostics,
    --                 },
    --                 Commit = {
    --                     prompt = "/COPILOT_GENERATE" .. commit_staged_prompt,
    --                     selection = select.gitdiff,
    --                     callback = function(response, _)
    --                         local commit_message = response:match("```gitcommit(.-)```")
    --                         if commit_message then
    --                             -- 2行目を抽出
    --                             local second_line = commit_message:match("^[^\n]*\n([^\n]*)")
    --                             if second_line then
    --                                 vim.fn.setreg("+", second_line, "c")
    --                             end
    --                         end
    --                     end,
    --                 },
    --                 CommitStaged = {
    --                     prompt = "/COPILOT_GENERATE" .. commit_staged_prompt,
    --                     selection = function(source)
    --                         return select.gitdiff(source, true)
    --                     end,
    --                     callback = function(response, _)
    --                         local commit_message = response:match("```gitcommit(.-)```")
    --                         if commit_message then
    --                             -- 2行目を抽出
    --                             local second_line = commit_message:match("^[^\n]*\n([^\n]*)")
    --                             if second_line then
    --                                 vim.fn.setreg("+", second_line, "c")
    --                             end
    --                         end
    --                     end,
    --                 },
    --                 Review = {
    --                     prompt = '/COPILOT_REVIEW Review the selected code and answer in Japanese.',
    --                     callback = function(response, source)
    --                         local ns = vim.api.nvim_create_namespace('copilot_review')
    --                         local diagnostics = {}
    --                         for line in response:gmatch('[^\r\n]+') do
    --                             if line:find('^line=') then
    --                                 local start_line = nil
    --                                 local end_line = nil
    --                                 local message = nil
    --                                 local single_match, message_match = line:match('^line=(%d+): (.*)$')
    --                                 if not single_match then
    --                                     local start_match, end_match, m_message_match = line:match(
    --                                         '^line=(%d+)-(%d+): (.*)$')
    --                                     if start_match and end_match then
    --                                         start_line = tonumber(start_match)
    --                                         end_line = tonumber(end_match)
    --                                         message = m_message_match
    --                                     end
    --                                 else
    --                                     start_line = tonumber(single_match)
    --                                     end_line = start_line
    --                                     message = message_match
    --                                 end
    --                                 if start_line and end_line then
    --                                     table.insert(diagnostics, {
    --                                         lnum = start_line - 1,
    --                                         end_lnum = end_line - 1,
    --                                         col = 0,
    --                                         message = message,
    --                                         severity = vim.diagnostic.severity.WARN,
    --                                         source = 'Copilot Review',
    --                                     })
    --                                 end
    --                             end
    --                         end
    --                         vim.diagnostic.set(ns, source.bufnr, diagnostics)
    --                     end,
    --                 },
    --             },
    --         }
    --     end
    -- },
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
                flutter_lookup_cmd = "mise where flutter",
                fvm = false,
                widget_guides = { enabled = true },
                closing_tags = {
                    enabled = true,
                    highlight = 'LineNr',
                    prefix = '󰡒  ',
                    priority = 0,
                },
                dev_log = {
                    enabled = true,
                    notify_errors = false,
                    -- ImpellerValidationBreak は表示しない
                    filter = function(log_line)
                        if log_line:find('ImpellerValidationBreak') then
                            return false
                        end
                        return true
                    end,
                },
                decorations = {
                    statusline = {
                        app_version = true,
                        device = true,
                        project_config = true,
                    }
                },
                lsp = {
                    settings = {
                        showTodos = true,
                        completeFunctionCalls = true,
                        analysisExcludedFolders = {
                            vim.fn.expand('$HOME/.pub-cache'),
                            vim.fn.expand('$HOME/.local/share/mise/installs/flutter'),
                            vim.fn.expand('$HOME/.local/share/mise/installs/dart'),
                        },
                        renameFilesWithClasses = "prompt",
                        enableSnippets = true,
                        updateImportsOnRename = true,
                    },
                },
                debugger = {
                    enabled = true,
                    run_via_dap = true,
                    exception_breakpoints = {},
                    evaluate_to_string_in_debug_views = true,
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
    -- テストフレームワーク
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
            -- マルチパッケージに対応していないので Fork したものを使用
            -- https://github.com/sidlatau/neotest-dart/pull/13
            -- 'sidlatau/neotest-dart',
            'IgorKhramtsov/neotest-dart',
        },
        event = 'VeryLazy',
        config = function()
            require('neotest').setup {
                adapters = {
                    require 'neotest-dart' {
                        command = 'flutter',
                        use_lsp = true,
                        custom_test_method_names = {},
                    },
                },
                consumers = { require('neotest').diagnostic, require('neotest').status },
            }
            vim.keymap.set('n', '<Leader>te', "<cmd>lua require('neotest').run.run()<CR>", keymap_opts)
            vim.keymap.set('n', '<Leader>ta', "<cmd>lua require('neotest').run.run(vim.fn.expand '%')<CR>", keymap_opts)
            vim.keymap.set('n', '<Leader>td', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", keymap_opts)
            vim.keymap.set('n', '<Leader>tu', "<cmd>lua require('neotest').output_panel.open()<CR>", keymap_opts)
            vim.keymap.set('n', '<Leader>tp', "<cmd>lua require('neotest').output.open()<CR>", keymap_opts)
            vim.keymap.set('n', '<Leader>ts', "<cmd>lua require('neotest').summary.toggle()<CR>", keymap_opts)
        end,
    },
    {
        "stevearc/overseer.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        event = "VeryLazy",
        config = function()
            local overseer = require("overseer")

            overseer.setup({
                strategy = {
                    "toggleterm",
                    -- quit_on_exit = "success",
                    dap = false,
                },
            })
            vim.api.nvim_set_keymap("n", "<C-.>", "<cmd>OverseerRun<CR>", { noremap = true, silent = true })
        end,
    },
    -- pubspec.yaml のヘルパー
    {
        "akinsho/pubspec-assist.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = {
            "PubspecAssistAddPackage",
            "PubspecAssistAddDevPackage",
            "PubspecAssistPickVersion",
        },
        ft = { "yaml" },
        event = "BufEnter pubspec.yaml",
        config = function()
            require("pubspec-assist").setup()
            vim.api.nvim_set_keymap(
                "n",
                "<Leader>p",
                "<cmd>PubspecAssistPickVersion<CR>",
                { noremap = true, silent = true }
            )
        end,
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
                open_mapping = [[<C-4>]],
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
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']c', bang = true })
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end)

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[c', bang = true })
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end)

                    -- Actions
                    map('n', '<leader>hs', gitsigns.stage_hunk)
                    map('n', '<leader>hr', gitsigns.reset_hunk)
                    map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                    map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                    map('n', '<leader>hS', gitsigns.stage_buffer)
                    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
                    map('n', '<leader>hR', gitsigns.reset_buffer)
                    map('n', '<leader>hp', gitsigns.preview_hunk)
                    -- map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
                    -- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                    map('n', '<leader>hd', gitsigns.diffthis)
                    map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
                    map('n', '<leader>td', gitsigns.toggle_deleted)

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            }
        end
    },
    {
        "FabijanZulj/blame.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>tb", "<cmd>BlameToggle<cr>", desc = "Blame" },
        },
        config = function()
            require('blame').setup {
                date_format = "%Y.%m.%d",
            }
        end,
    },
    {
        'akinsho/git-conflict.nvim',
        -- event = 'VeryLazy',
        version = "*",
        config = true,
    },
    {
        'isakbm/gitgraph.nvim',
        opts = {
            symbols = {
                merge_commit = 'M',
                commit = '*',
            },
            format = {
                timestamp = '%H:%M:%S %d-%m-%Y',
                fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
            },
            hooks = {
                on_select_commit = function(commit)
                    print('selected commit:', commit.hash)
                end,
                on_select_range_commit = function(from, to)
                    print('selected range:', from.hash, to.hash)
                end,
            },
        },
        keys = {
            {
                "<leader>pp",
                function()
                    require('gitgraph').draw({}, { all = true, max_count = 5000 })
                end,
                desc = "GitGraph - Draw",
            },
        },
    },
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        event = "VeryLazy",
        config = function()
            require('tiny-code-action').setup()
            vim.keymap.set("n", "<leader>ca", function()
                require("tiny-code-action").code_action()
            end, { noremap = true, silent = true })
        end
    },
    -- dynamic macro
    {
        'tani/dmacro.vim',
        keys = {
            { "dm", mode = { "n", "i" }, '<Plug>(dmacro-play-macro)', desc = "dmacro" },
        }
    },
    {
        "nvzone/timerly",
        dependencies = { "nvzone/volt" }
    },
    -- snippet
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets/" } })
        end
    },
    {
        "saadparwaiz1/cmp_luasnip",
        event = "VeryLazy",
    },
    {
        "marcussimonsen/let-it-snow.nvim",
        cmd = "LetItSnow", -- Wait with loading until command is run
        event = "VeryLazy",
        opts = {},
    },
    -- {
    --     'eero-lehtinen/oklch-color-picker.nvim',
    --     event = "VeryLazy",
    --     config = function()
    --         require('oklch-color-picker').setup {}
    --         -- One handed keymaps recommended, you will be using the mouse
    --         vim.keymap.set('n', '<leader>v', function()
    --             require('oklch-color-picker').pick_under_cursor()
    --         end, { desc = 'Color pick under cursor' })
    --     end,
    -- },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- set this if you want to always pull the latest change
        opts = {
            -- add any opts here
            provider = "copilot",
            -- provider = "claude",
            -- provider = "openai",
            auto_suggestions_provider = "copilot",
            windows = {
                position = "right",
                width = 40,
                sidebar_header = {
                    align = "center",
                    rounded = false,
                },
            },
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua",      -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    }
}
