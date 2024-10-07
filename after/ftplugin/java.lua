-- Follow https://github.com/mfussenegger/nvim-jdtls and https://github.com/eclipse-jdtls/eclipse.jdt.ls to configure
local cache_vars = {}

local function get_jdtls_paths()
    if cache_vars.paths then
        return cache_vars.paths
    end

    local path = {}

    local jdtls_install = require('mason-registry')
    .get_package('jdtls')
    :get_install_path()

    path.java_agent = jdtls_install .. '/lombok.jar'
    path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')
    path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'

    if vim.fn.has('mac') == 1 then
        path.platform_config = jdtls_install .. '/config_mac'
    elseif vim.fn.has('unix') == 1 then
        path.platform_config = jdtls_install .. '/config_linux'
    elseif vim.fn.has('win32') == 1 then
        path.platform_config = jdtls_install .. '/config_win'
    end


    ---
    -- Include java-debug
    ---

    local java_debug_path = require('mason-registry')
    .get_package('java-debug-adapter')
    :get_install_path()

    path.bundles = {
        vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar')
    }

    -- TODO: Get Mason installation directory
    -- FIXME: This should be updated manually. 
    local mason_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/vscode-java-test/server/"
    vim.list_extend(path.bundles, vim.split(vim.fn.glob(mason_path .. "*.jar", 1), "\n"))

    ---
    -- Include java-test bundle if present
    ---
    local java_test_path = require('mason-registry')
    .get_package('java-test')
    :get_install_path()

    local java_test_bundle = vim.split(
    vim.fn.glob(java_test_path .. '/extension/server/*.jar'),
    '\n'
    )

    vim.list_extend(path.bundles, java_test_bundle)

    cache_vars.paths = path

    return path
end

local jdtls = require('jdtls')

jdtls.setup_dap({hotcodereplace = 'auto'})
jdtls.setup.add_commands()

local path = get_jdtls_paths()
local data_dir = path.data_dir .. '/' ..  vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1])
local workspace_folder = 'file://' .. root_dir

vim.keymap.set("n", "<leader>ra", "<Cmd>lua require'jdtls'.test_class()<CR>", { desc = "" }) -- (r)un (a)ll 
vim.keymap.set("n", "<leader>rc", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", { desc = "" }) -- (r)un (c)urrent
vim.keymap.set("n", "<leader>rs", "<Cmd>lua require'dap'.repl.open()<CR>", { desc = "" }) -- (r)un (s)how
vim.keymap.set("n", "<leader>gt", "<Cmd>lua require'jdtls.tests'.goto_subjects()<CR>", { desc = "" }) -- (g)o to (t)ests
vim.keymap.set("n", "<leader>oi", "<Esc><Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "" })
vim.keymap.set({'n', 'v'}, "<leader>em", "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", { desc = "" })
vim.keymap.set({'n', 'v'}, "<leader>ev", "<Esc><Cmd>lua require'jdtls'.extract_variable_all(true)<CR>", { desc = "" })
vim.keymap.set({'n', 'v'}, "<leader>ec", "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", { desc = "" })

local cmd = {
    -- 💀
    'java',

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. path.java_agent,
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar',
    path.launcher_jar,

    -- 💀
    '-configuration',
    path.platform_config,

    -- 💀
    '-data',
    data_dir,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;

local init_options = {
  bundles = path.bundles;
  extendedClientCapabilities = extendedClientCapabilities;
}

-- See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request 
local settings = {}

-- print('Project specific data directory: ' .. data_dir .. ' | Root dir: ' .. root_dir .. ' | Workspace Folder: ' .. workspace_folder)
local config = {
    cmd = cmd,
    root_dir = root_dir,
    workspaceFolders={workspace_folder},
    init_options = init_options,
    capabilities = capabilities,
    settings = settings
}

jdtls.start_or_attach(config)

