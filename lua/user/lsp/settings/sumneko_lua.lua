return {
	settings = {
		Lua = {
			diagnostics = {
        enable = false,
				globals = { "vim" },
        ignoredFiles = "Opened",
        neededFileStatus = "Opened"
        --workspaceDelay = 6000,
			},
			workspace = {
        useGitIgnore = true,
        maxPreload = 5000,
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
