local M = {}

local function getEntryAbsolutePath()
    local api = require('nvim-tree.api')
    local node = api.tree.get_node_under_cursor()
    if not node then
        return
    end
    local dir = node.absolute_path
    local entry = node.name
    return dir, entry
end

function M.openWithQuickLook()
    local dir, entry = getEntryAbsolutePath()
    if dir and entry then
        local path = ("%s/%s"):format(dir, entry)
        vim.notify("Path: " .. path, "info", {
            title = "Neovim",
            timeout = 5000,
        })

        vim.cmd(("silent !qlmanage -p %s &"):format(dir))
    else
        vim.notify("No valid node selected", "info", {
            title = "Neovim",
            timeout = 5000,
        })
    end
end

-- local function getNeovimWeztermPane()
--     local wezterm_pane_id = vim.env.WEZTERM_PANE
--     if not wezterm_pane_id then
--         vim.notify("Wezterm pane not found", vim.log.levels.ERROR)
--         return
--     end
--     return tonumber(wezterm_pane_id)
-- end
--
-- local activeWeztermPane = function(wezterm_pane_id)
--     vim.system({ "wezterm", "cli", "activate-pane", "--pane-id", wezterm_pane_id })
-- end
--
-- ---@param opt table
-- local openNewWeztermPane = function(opt)
--     local _opt = opt or {}
--     local percent = _opt.percent or 30
--     local direction = _opt.direction or "right"
--
--     local cmd = {
--         "wezterm",
--         "cli",
--         "split-pane",
--         ("--percent=%d"):format(percent),
--         ("--%s"):format(direction),
--         "--",
--         "bash",
--     }
--     local obj = vim.system(cmd, { text = true }):wait()
--     local wezterm_pane_id = assert(tonumber(obj.stdout))
--
--     return wezterm_pane_id
-- end
--
-- local closeWeztermPane = function(wezterm_pane_id)
--     vim.system({
--         "wezterm",
--         "cli",
--         "kill-pane",
--         ("--pane-id=%d"):format(wezterm_pane_id),
--     })
-- end
--
-- local sendCommandToWeztermPane = function(wezterm_pane_id, command)
--     local cmd = {
--         "echo",
--         ("'%s'"):format(command),
--         "|",
--         "wezterm",
--         "cli",
--         "send-text",
--         "--no-paste",
--         ("--pane-id=%d"):format(wezterm_pane_id),
--     }
--     vim.fn.system(table.concat(cmd, " "))
-- end
--
-- local function listWeztermPanes()
--     local cli_result = vim.system({
--         "wezterm",
--         "cli",
--         "list",
--         "--format=json",
--         -- ("--format=%s"):format("json"),
--     }, { text = true }):wait()
--     local json = vim.json.decode(cli_result.stdout)
--     local panes = vim.iter(json):map(_l("obj: { pane_id = obj.pane_id, tab_id = obj.tab_id }"))
--
--     return panes
-- end
--
-- local function getPreviewWeztermPaneId()
--     local panes = listWeztermPanes()
--     local neovim_wezterm_pane_id = getNeovimWeztermPane()
--     local current_tab_id = assert(panes:find(function(obj)
--         return obj.pane_id == neovim_wezterm_pane_id
--     end)).tab_id
--     local preview_pane = panes:find(function(obj)
--         return                               --
--             obj.tab_id == current_tab_id     --
--             and tonumber(obj.pane_id) >
--             tonumber(neovim_wezterm_pane_id) -- new pane id should be greater than current pane id
--     end)
--     return preview_pane ~= nil and preview_pane.pane_id or nil
-- end
--
-- local function openWeztermPreviewPane()
--     local preview_pane_id = getPreviewWeztermPaneId()
--     if preview_pane_id == nil then
--         preview_pane_id = openNewWeztermPane({ percent = 30, direction = "right" })
--     end
--     return preview_pane_id
-- end
--
-- local is_wezterm_preview_open = function()
--     return getPreviewWeztermPaneId() ~= nil
-- end
--
-- function M.weztermPreview()
--     if is_wezterm_preview_open() then
--         closeWeztermPane(getPreviewWeztermPaneId())
--     end
--     local nvim_tree = require("nvim-tree.api")
--     local preview_entry_id = nil
--     local prev_cmd = nil
--
--     local neovim_wezterm_pane_id = getNeovimWeztermPane()
--     local bufnr = vim.api.nvim_get_current_buf()
--
--     local updateWeztermPreview = debounce(
--         vim.schedule_wrap(function()
--             if vim.api.nvim_get_current_buf() ~= bufnr then
--                 return
--             end
--
--             local node = nvim_tree.tree.get_node_under_cursor()
--             if not node then
--                 return
--             end
--             local entry = node.name
--
--             if entry ~= nil then
--                 local preview_pane_id = openWeztermPreviewPane()
--                 activeWeztermPane(neovim_wezterm_pane_id)
--
--                 if preview_entry_id == entry.id then
--                     return
--                 end
--
--                 if prev_cmd == "bat" then
--                     sendCommandToWeztermPane(preview_pane_id, "q")
--                     prev_cmd = nil
--                 end
--
--                 local dir, entry = assert(getEntryAbsolutePath())
--                 local path = ("%s/%s"):format(dir, entry)
--                 local command = ""
--                 if entry.type == "directory" then
--                     local cmd = "ls -l"
--                     command = command .. ("%s %s"):format(cmd, path)
--                     prev_cmd = cmd
--                 elseif entry.type == "file" and isImage(path) then
--                     local cmd = "wezterm imgcat"
--                     command = command .. ("%s %s"):format(cmd, path)
--                     prev_cmd = cmd
--                 elseif entry.type == "file" then
--                     local cmd = "bat"
--                     command = command .. ("%s %s"):format(cmd, path)
--                     prev_cmd = cmd
--                 end
--
--                 sendCommandToWeztermPane(preview_pane_id, command)
--                 preview_entry_id = entry.id
--             end
--         end),
--         50
--     )
--
--     updateWeztermPreview()
--
--     -- local config = require("oil.config")
--     -- if config.preview.update_on_cursor_moved then
--     --     vim.api.nvim_create_autocmd("CursorMoved", {
--     --         desc = "Update oil wezterm preview",
--     --         group = "Oil",
--     --         buffer = bufnr,
--     --         callback = function()
--     --             updateWeztermPreview()
--     --         end,
--     --     })
--     -- end
--     --
--     -- vim.api.nvim_create_autocmd({ "BufLeave", "BufDelete", "VimLeave" }, {
--     --     desc = "Close oil wezterm preview",
--     --     group = "Oil",
--     --     buffer = bufnr,
--     --     callback = function()
--     --         closeWeztermPane(getPreviewWeztermPaneId())
--     --     end,
--     -- })
-- end

return M
