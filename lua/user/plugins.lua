local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerInstall
--   augroup end
-- ]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here

    use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
    use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
    use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
    use("numToStr/Comment.nvim")
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    use({ "akinsho/bufferline.nvim" })
    use({ "moll/vim-bbye" })
    use({ "nvim-lualine/lualine.nvim" })
    use({ "akinsho/toggleterm.nvim" })
    use({ "ahmedkhalf/project.nvim" })
    use({ "lewis6991/impatient.nvim" })
    -- use({ "lukas-reineke/indent-blankline.nvim" })
    use({ "goolord/alpha-nvim" })
    use("folke/which-key.nvim")

    -- Colorschemes
    use({ "folke/tokyonight.nvim" })
    use("lunarvim/darkplus.nvim")
    use("EdenEast/nightfox.nvim")
    use("shaunsingh/solarized.nvim")
    use("olimorris/onedarkpro.nvim")

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
    use({ "hrsh7th/cmp-buffer" }) -- buffer completions
    use({ "hrsh7th/cmp-path" }) -- path completions
    use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-nvim-lua" })

    -- snippets
    use({ "L3MON4D3/LuaSnip" }) --snippet engine
    use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

    -- LSP
    use({ "neovim/nvim-lspconfig" }) -- enable LSP
    use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer

    -- Telescope
    use({ "nvim-telescope/telescope.nvim" })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
    })

    -- Git
    use({ "lewis6991/gitsigns.nvim" })

    -- EasyMotion
    use("easymotion/vim-easymotion")

    -- Surround
    use("tpope/vim-surround")

    -- ReplaceWithRegister
    use("vim-scripts/ReplaceWithRegister")

    -- Exchange
    use("tommcdo/vim-exchange")

    -- document hightlight
    -- use('RRethy/vim-illuminate')
    use("stevearc/aerial.nvim")
    use({ "ray-x/lsp_signature.nvim", })
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use("rickhowe/spotdiff.vim")
    use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })
    use("stevearc/stickybuf.nvim")
    -- use("rcarriga/nvim-notify")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
