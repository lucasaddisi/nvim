local function get_jdtls_paths()
    local path = {}

    local jdtls_install = require('mason-registry')
    .get_package('jdtls')
    :get_install_path()

    path.java_agent = jdtls_install .. '/lombok.jar'
    path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

    if vim.fn.has('mac') == 1 then
        path.platform_config = jdtls_install .. '/config_mac'
    elseif vim.fn.has('unix') == 1 then
        path.platform_config = jdtls_install .. '/config_linux'
    elseif vim.fn.has('win32') == 1 then
        path.platform_config = jdtls_install .. '/config_win'
    end

    path.exec = jdtls_install .. '/bin/jdtls'

    return path
end

local jdtls_exec = get_jdtls_paths().exec
print(jdtls_exec)

local config = {
    cmd = {jdtls_exec},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}

require('jdtls').start_or_attach(config)

