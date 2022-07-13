return {
	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim" },
        ignoredFiles = "Disable",
        --workspaceDelay = 6000,
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
      runtime = {
        version = 'lua 5.3',
        special = {
          include = "require",
          gSingleton = "require"
        }
      },
      hint = {
        enable = true,
      },
      telemetry = {
        enable = true
      }
		},
	},
}
