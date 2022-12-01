local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
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
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	-- snapshot = "july-24",
	snapshot_path = fn.stdpath("config") .. "/snapshots",
	max_jobs = 50,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
		prompt_border = "rounded", -- Border style of prompt popups.
	},
})

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself

	-- Lua Development
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("nvim-lua/popup.nvim")
	use("christianchiarulli/lua-dev.nvim")

	--Color Schemes
	use("shaunsingh/nord.nvim")
	use("lunarvim/colorschemes")
	use("catppuccin/nvim")
	use("kvrohit/substrata.nvim")
	-- use "lunarvim/darkplus.nvim"
	-- use "ChristianChiarulli/nvcode-color-schemes.vim"

	-- Telescope
	use("nvim-telescope/telescope.nvim")

	-- Nvim Tree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	})

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to -- use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("github/copilot.vim") -- Github Copilot.
	use("williamboman/mason.nvim") -- simple to use language server installer
	use("williamboman/mason-lspconfig.nvim")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch onippets to -- use

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({
		"m-demare/hlargs.nvim",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- Utilities
  --- STILL NOT DONE
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to -- use `main` branch for the latest features
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	---@diagnostic disable-next-line: undefined-global
	if packer_bootstrap then
		require("packer").sync()
	end
end)
