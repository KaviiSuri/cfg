local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_setup(name)
    return string.format('require("i.setup.%s")', name)
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    use {
        "akinsho/toggleterm.nvim",
        config = get_setup("toggleterm"),
    }
    use {
        "folke/which-key.nvim",
        config = get_setup("which-key"),
    }

    -- Optimizations
    use "lewis6991/impatient.nvim"

    -- Visual Plugins ====================================
    use "lunarvim/colorschemes" -- A collection of colorschemes to try out
    use "Mofiqul/dracula.nvim" -- Dracula Theme for Nvim
    use "ryanoasis/vim-devicons" -- Vim Dev Icons
    -- use {
    --     "akinsho/bufferline.nvim",
    --     config = get_setup("bufferline"),
    -- }
    use "moll/vim-bbye"
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = get_setup("indentline")
    }
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = get_setup("lualine")
    }


    -- Editor Plugins ====================================
    use {
        "numToStr/Comment.nvim",
        config = get_setup("comment")
    } -- Easily comment stuff

    use {
        "windwp/nvim-autopairs",
        config = get_setup("autopairs"),
    } -- Autopairs, integrates with both cmp and treesitter

    -- Files & Navigation ================================
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        config = get_setup("nvim-tree"),
    }

    -- CMP Plugins =======================================
    use "hrsh7th/cmp-buffer" -- Buffer Completions
    use "hrsh7th/cmp-path" -- Path Completions
    use "hrsh7th/cmp-cmdline" -- Cmdline Completions
    use "saadparwaiz1/cmp_luasnip" -- Snippet Completions
    use "hrsh7th/cmp-nvim-lsp" -- LSP Completion
    use { -- The Completion Plugins
        "hrsh7th/nvim-cmp",
        config = get_setup("cmp"),
    }
    use "hrsh7th/cmp-nvim-lua" -- VIM LUA Completions

    -- Snippets Plugins ==================================
    use "L3MON4D3/LuaSnip" -- snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP Plugins =======================================
    use "neovim/nvim-lspconfig" -- Enable LSP
    use "williamboman/nvim-lsp-installer" -- Simple to use language server installer
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

    -- Project Management ===============================
    use {
        "ahmedkhalf/project.nvim",
        config = get_setup("project"),
        requries = { "nvim-telescope/telescope.nvim" }
    }

    -- DAP Plugins ======================================
    use "mfussenegger/nvim-dap"

    -- Rust ==============================================
    use 'rust-lang/rust.vim'
    use {
        "simrat39/rust-tools.nvim",
        config = get_setup("rust-tools"),
        requries = { "neovim/nvim-lspconfig" }
    }
    -- Fuzzy Finder ======================================
    use {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
        config = get_setup("telescope"),
    }
    use "nvim-telescope/telescope-media-files.nvim"

    -- Treesitter =======================================
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = get_setup("treesitter")
    }

    use "p00f/nvim-ts-rainbow"
    use "nvim-treesitter/playground"
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Local Config =====================================
    use {
        "klen/nvim-config-local",
        config = get_setup("config-local")
    }
    -- Git
    use {
        "lewis6991/gitsigns.nvim",
        config = get_setup("gitsigns"),
    }

    -- Markdown Plugins ==================================
    use { "iamcco/markdown-preview.nvim", run = "cd app && yarn install", cmd = "MarkdownPreview" }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
