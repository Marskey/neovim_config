local palettes = require('nightfox.palette').load('nordfox')
local groups = {
    NormalFloat = { link = "Normal" },
    WhichKeyFloat = { link = "Normal" },
    NeoTreeTitleBar = { link = "TermCursor" },

    DiffText = { link = "lualine_a_command" },
    -- DiffChange = { link = "lualine_b_command" },
    -- DiffAdd = { link = "Substitute" },
    -- DiffDelete = { link = "Substitute" },

    -- Telescope
    TelescopeBorder = { bg = palettes.bg0, fg = palettes.bg0 },
    TelescopePromptBorder = { bg = palettes.black.dim, fg = palettes.black.dim },
    TelescopePromptNormal = { bg = palettes.black.dim, fg = palettes.white.base, },
    TelescopePromptPrefix = { bg = palettes.black.dim, fg = palettes.red.base },

    TelescopeNormal = { bg = palettes.bg0 },

    TelescopePreviewTitle = { bg = palettes.green.base, fg = palettes.black.base },
    TelescopePromptTitle = { bg = palettes.red.base, fg = palettes.black.base },
    TelescopeResultsTitle = { bg = palettes.bg0, fg = palettes.bg0 },

    TelescopeSelection = { bg = palettes.bg3 }
}

local nigtfox = require("nightfox")
if nigtfox then
    nigtfox.setup({ groups = { all = groups } })
end

local onedarkpro = require("onedarkpro")
if onedarkpro then
    onedarkpro.setup({
        dark_theme = "onedark", -- The default dark theme
        light_theme = "onelight", -- The default light theme
        colors = {}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
        highlights = groups, -- Override default highlight groups
        ft_highlights = {}, -- Override default highlight groups for specific filetypes
        plugins = { -- Override which plugin highlight groups are loaded
            -- See the Supported Plugins section for a list of available plugins
        },
        styles = { -- Choose from "bold,italic,underline"
            strings = "NONE", -- Style that is applied to strings.
            comments = "NONE", -- Style that is applied to comments
            keywords = "NONE", -- Style that is applied to keywords
            functions = "NONE", -- Style that is applied to functions
            variables = "NONE", -- Style that is applied to variables
            virtual_text = "NONE", -- Style that is applied to virtual text
        },
        options = {
            bold = true, -- Use the colorscheme's opinionated bold styles?
            italic = true, -- Use the colorscheme's opinionated italic styles?
            underline = true, -- Use the colorscheme's opinionated underline styles?
            undercurl = true, -- Use the colorscheme's opinionated undercurl styles?
            cursorline = true, -- Use cursorline highlighting?
            transparency = false, -- Use a transparent background?
            terminal_colors = false, -- Use the colorscheme's colors for Neovim's :terminal?
            window_unfocused_color = false, -- When the window is out of focus, change the normal background?
        }
    })
end

vim.cmd [[
try
  colorscheme nordfox
  set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
