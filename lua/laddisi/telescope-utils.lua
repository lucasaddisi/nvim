local M = {}

-- Cached paths (nil = not checked yet)
local git_root_cache = nil
local bazel_path_cache = nil
local has_bazelproject_cache = nil

-- Private helper: get git root and bazel path (cached for performance)
-- Returns: git_root, bazel_path
local function get_bazel_paths()
    if git_root_cache and bazel_path_cache then
        return git_root_cache, bazel_path_cache
    end

    git_root_cache = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'):gsub('\n', '')
    bazel_path_cache = git_root_cache .. '/core/.eclipse/.bazelproject'

    return git_root_cache, bazel_path_cache
end

-- Check if .bazelproject exists in core/eclipse directory
-- Returns: boolean
function M.has_bazelproject()
    if has_bazelproject_cache ~= nil then
        return has_bazelproject_cache
    end

    local _, bazel_path = get_bazel_paths()

    -- Synchronous file check (fast for single file)
    local stat = vim.uv.fs_stat(bazel_path)
    has_bazelproject_cache = stat ~= nil

    return has_bazelproject_cache
end

-- Parse .bazelproject file and extract directories
-- Returns: array of directory names (strings)
function M.get_bazel_directories()
    local _, bazel_path = get_bazel_paths()

    -- Read file
    local file = io.open(bazel_path, 'r')
    if not file then
        return {}
    end

    local content = file:read('*all')
    file:close()

    local directories = {}
    local in_directories_section = false

    -- Parse line by line
    for line in content:gmatch('[^\r\n]+') do
        -- Check if we're entering the directories section
        if line:match('^directories:') then
            in_directories_section = true
        -- Check if we're leaving the section (new section starts)
        elseif in_directories_section and line:match('^%w+:') then
            break
        -- Extract directory entries
        elseif in_directories_section then
            -- Trim whitespace
            local trimmed = line:match('^%s*(.-)%s*$')
            -- Skip empty lines and comments
            if trimmed ~= '' and not trimmed:match('^#') then
                table.insert(directories, trimmed)
            end
        end
    end

    return directories
end

-- Get absolute paths for Bazel directories
-- Returns: array of absolute directory paths
function M.get_bazel_directory_paths()
    local _, bazel_path = get_bazel_paths()

    -- Get base directory (parent of .eclipse) - avoids hardcoding '/core/'
    local base_path = vim.fn.fnamemodify(bazel_path, ':h:h')

    -- Get directory names from .bazelproject
    local directories = M.get_bazel_directories()

    -- Convert to absolute paths
    local paths = {}
    for _, dir in ipairs(directories) do
        table.insert(paths, base_path .. '/' .. dir)
    end

    return paths
end

return M
