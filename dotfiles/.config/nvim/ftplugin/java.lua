local jdtls = require('jdtls')
local home = os.getenv('HOME')
local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local os_name = vim.loop.os_uname().sysname

-- OS-specific configurations
local config_path
local java_cmd

if os_name == "Darwin" then
    -- macOS specific paths
    config_path = jdtls_path .. '/config_mac'
    java_cmd = '/opt/homebrew/Cellar/openjdk@21/21.0.9/libexec/openjdk.jdk/Contents/Home/bin/java'
elseif os_name == "Linux" then
    -- Linux specific paths
    config_path = jdtls_path .. '/config_linux'
    java_cmd = '/usr/bin/java' -- Adjust this if your Java is elsewhere on Linux
else
    -- Windows or other OS
    config_path = jdtls_path .. '/config_win'
    java_cmd = 'java' -- Assumes java is in PATH
end

-- Common path setups
local plugins_path = jdtls_path .. '/plugins/'
local path_to_jar = vim.fn.glob(plugins_path .. 'org.eclipse.equinox.launcher_*.jar')

-- Project root directory detection
local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
    root_dir = vim.fn.getcwd()
end

-- Project workspace
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = home .. '/.cache/jdtls/workspace/' .. project_name

-- Setup JDTLS config
local config = {
    cmd = {
        java_cmd,
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', path_to_jar,
        '-configuration', config_path,
        '-data', workspace_dir,
    },
    root_dir = root_dir,
    handlers = {
        ["language/status"] = function(_, _) end,
        ["$/progress"] = function(_, _) end,
    },
    -- Rest of your configuration...
}

vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true


jdtls.start_or_attach(config)
