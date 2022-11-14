return {
    settings = {
        Lua = {
          format = {
            enable = true,
            -- Put format options here
            -- NOTE: the value should be STRING!!
            defaultConfig = {
              indent_style = "space",
              indent_size = "4",
            }
          },
          diagnostics = {
                enable = true,
                globals = {"vim"},
                ignoredFiles = "Opened",
                neededFileStatus = "Opened",
                -- workspaceDelay = 6000,
            },
            workspace = {
                useGitIgnore = true,
                -- maxPreload = 5000,
                checkThirdParty = true
            },
            runtime = {
                version = 'lua 5.3',
                special = {
                    include = "require",
                    gSingleton = "require"
                },
                pathStrict = false
            },
        },
    },
}
