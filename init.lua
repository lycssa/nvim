-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- add your plugins here
		{
			"catppuccin/nvim",
			name = "catppuccin",
			opts = {
				color_overrides = {
					mocha = {
						text = "#ffffff",
						base = "#000000",
						mantle = "#000000",
						crust = "#1e1e2e",
					},
				},
				no_italic = true,
				term_colors = true,
			},
			priority = 1000,
		},
		{ "mason-org/mason.nvim", opts = {} },
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", lazy = false },
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			},
			keys = {
				{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
				{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
				{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
				{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
			},
			version = "*",
		},
		{
			"saghen/blink.cmp",
			dependencies = { "rafamadriz/friendly-snippets" },
			opts = {},
			opts_extend = { "sources.default" },
			version = "1.*",
		},
		{
			"stevearc/conform.nvim",
			opts = {
				format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
				formatters_by_ft = {}, -- List formatters here
			},
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- Setup other plugins
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" }, -- List filetypes here
	callback = function()
		vim.treesitter.start()
	end,
})
vim.cmd.colorscheme("catppuccin")
vim.diagnostic.config({
	virtual_text = true,
})
-- vim.lsp.enable() after it's configured
