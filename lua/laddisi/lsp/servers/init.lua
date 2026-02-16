local M = {}

-- Get all server configuration files in the servers directory
local function get_server_files()
    local servers_path = vim.fn.stdpath('config') .. '/lua/laddisi/lsp/servers'
    local files = vim.fn.globpath(servers_path, '*.lua', false, true)

    local server_names = {}
    for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ':t:r')
        if name ~= 'init' then
            table.insert(server_names, name)
        end
    end

    return server_names
end

-- Load all server configurations
function M.load()
    local servers = {}
    local server_names = get_server_files()

    for _, name in ipairs(server_names) do
        local ok, config = pcall(require, 'laddisi.lsp.servers.' .. name)
        if ok then
            servers[name] = config
        else
            vim.notify('Failed to load LSP server config: ' .. name, vim.log.levels.WARN)
            servers[name] = {}
        end
    end

    return servers
end

return M
