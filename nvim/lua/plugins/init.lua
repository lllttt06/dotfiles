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
    -- {
    --     "neanias/everforest-nvim",
    --     version = false,
    --     lazy = false,
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     -- Optional; default configuration will be used if setup isn't called.
    --     config = function()
    --         require("everforest").setup({
    --             background = "hard",
    --         })
    --         vim.cmd("colorscheme everforest")
    --     end,
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
                            padding = { left = 2, right = 3 },
                        },
                    },
                    lualine_b = {
                        {
                            'branch',
                            icon = ' ',
                            padding = { left = 1, right = 1 },
                        },
                        {
                            'filename',
                            path = 1, -- 1: Relative path
                            file_status = false,
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
                                        return ' LSP:' .. client_count .. ' ' .. table.concat(messages, ' ')
                                    end
                                    if #active_clients <= 0 then
                                        return ' LSP:' .. client_count
                                    else
                                        local client_names = {}
                                        for _, client in ipairs(active_clients) do
                                            if client and client.name ~= '' then
                                                table.insert(client_names, '[' .. client.name .. ']')
                                            end
                                        end
                                        return ' LSP:' .. client_count .. ' ' .. table.concat(client_names, ' ')
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
                            icon_only = true,
                            padding = { left = 2, right = 1 },
                        },
                        {
                            'filetype',
                            icons_enabled = false,
                            padding = { left = 0, right = 2 },
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
                        title = "Trouble Preview",
                        title_pos = "center",
                        position = { 18, 2 },
                        size = { width = 0.5, height = 0.4 },
                        zindex = 200,
                    },
                },
            },
        }, -- for default options, refer to the configuration section for custom setup.
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
    -- ログハイライト
    {
        'fei6409/log-highlight.nvim',
        ft = 'log',
        config = function()
            -- ログのバッファだけ背景色を変える
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'log',
                callback = function()
                    vim.cmd 'highlight LogNormal guibg=#282828 ctermbg=darkgray'
                    vim.cmd 'setlocal winhighlight=Normal:LogNormal'
                end,
            })
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
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'b0o/nvim-tree-preview.lua',
            'nvim-lua/plenary.nvim',
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
                vim.keymap.set('n', 'x', api.node.run.system, opts 'Open System')
                vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
                vim.keymap.set('n', '=', api.tree.change_root_to_node, opts 'CD')
                vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts 'Dir Up')
                vim.keymap.set('n', 'l', api.node.open.edit, opts 'Edit')
                vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Node')
                vim.keymap.set('n', 's', '', opts '')
                vim.keymap.set('n', 'sl', '<c-w>l', opts '')

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
                            width = 45,
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
            local custom_actions = require("core.image")
            vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<C-f>', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>i', function() custom_actions.openWithQuickLook() end,
                { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>w', function() custom_actions.weztermPreview() end,
                { noremap = true, silent = true })
        end,
    },

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
        event = "VeryLazy",
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

            -- local on_attach = function(_, bufnr)
            --     vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
            --
            --     local set = vim.keymap.set
            --     set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
            --     set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
            --     set("n", "<C-m>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
            --     set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
            --     set("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
            --     set("n", "ma", "<cmd>lua vim.lsp.buf.code_action()<CR>")
            --     set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
            --     set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
            --     set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
            --     set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
            -- end

            local lspconfig = require("lspconfig")
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
                    "typos-lsp",
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

            -- typo-lsp
            -- lspconfig.typos_lsp.setup({
            --     on_attach = function(client, bufnr)
            --         local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
            --         if filetype == "log" or filetype == "toggleterm" then
            --             client.stop()
            --         end
            --     end,
            --     init_options = {
            --         config = "$HOME/.config/nvim/typos.toml",
            --         diagnosticSeverity = "Warning",
            --     },
            -- })
        end,
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

            cmp.setup({
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
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "copilot",                 group_index = 2 },
                    { name = "nvim_lsp",                group_index = 2 },
                    { name = "vsnip",                   group_index = 2 },
                    { name = "nvim_lsp_signature_help", group_index = 2 },
                    { name = "path",                    group_index = 2 },
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
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        event = "LspAttach",
        config = function()
            require('tiny-code-action').setup()
            vim.keymap.set("n", "<leader>ca", function()
                require("tiny-code-action").code_action()
            end, { noremap = true, silent = true })
        end
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
                            vim.fn.expand("$HOME/.asdf/installs/flutter"),
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
            require('gitsigns').setup()
        end
    },

    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            -- Copilot の Suggestion の色を変更する
            vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#E5C07B" })
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
