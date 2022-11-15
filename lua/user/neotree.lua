local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
    return
end

local function copy_to_clipboard(content)
    vim.fn.setreg("+", content)
    vim.fn.setreg('"', content)
    return vim.notify(string.format("Copied %s to system clipboard!", content))
end

local uv = vim.loop

local commands = { cmd = {}, args = {} }
if vim.fn.has "win32" == 1 or vim.fn.has "win32unix" == 1 then
    commands = {
        cmd = "cmd",
        args = { "/c", "C:\\>explorer.exe /select", '""' },
    }
elseif vim.fn.has "mac" == 1 or vim.fn.has "macunix" == 1 then
    commands = {
        cmd = "open",
        args = { "-R" }
    }
elseif vim.fn.has "unix" == 1 then
    commands = "nautilus"
end

local function revealInExplorer(path)
    if #commands.cmd == 0 then
        vim.notify("Cannot open file with system application. Unrecognized platform.", vim.log.levels.WARN)
        return
    end

    local process = {
        cmd = commands.cmd,
        args = commands.args,
        errors = "\n",
        stderr = uv.new_pipe(false),
    }
    table.insert(process.args, path or "~")
    process.handle, process.pid = uv.spawn(
        process.cmd,
        { args = process.args, stdio = { nil, nil, process.stderr }, detached = true },
        function(code)
            process.stderr:read_stop()
            process.stderr:close()
            process.handle:close()
            if code ~= 0 then
                process.errors = process.errors .. string.format("Neotree system_open: return code %d.", code)
                error(process.errors)
            end
        end
    )
    table.remove(process.args)
    if not process.handle then
        error("\n" .. process.pid .. "\nNeotree system_open: failed to spawn process using '" .. process.cmd .. "'.")
        return
    end
    uv.read_start(process.stderr, function(err, data)
        if err then
            return
        end
        if data then
            process.errors = process.errors .. data
        end
    end)
    uv.unref(process.handle)
end

neotree.setup({
    filesystem = {
        commands = {
            copy_file_name = function(state)
                local node = state.tree:get_node()
                copy_to_clipboard(node.name)
            end,
            copy_path = function(state)
                local node = state.tree:get_node()
                local full_path = node.path
                local relative_path = full_path:sub(#state.path + 2)
                copy_to_clipboard(relative_path)
            end,
            copy_absolute_path = function(state)
                local node = state.tree:get_node()
                copy_to_clipboard(node.path)
            end,
            reveal_in_explorer = function(state)
                local node = state.tree:get_node()
                revealInExplorer(node.path)
            end
        },
        window = {
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = {
                ["<space>"] = "",
                ["za"] = { "toggle_node" },
                ["y"] = "copy_file_name",
                ["Y"] = "copy_path",
                ["gy"] = "copy_absolute_path",
                ["go"] = "reveal_in_explorer",
                ["C"] = "copy",
                ["c"] = "copy_to_clipboard",
                ["zR"] = "expand_all_nodes",
                ["zm"] = "close_node",
                ["zM"] = "close_all_nodes",
                ["z"] = "",
            }
        }
    }
})
