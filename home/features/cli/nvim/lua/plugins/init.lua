return {
	-- Useful plugin to show you pending keybinds.
	{
		'folke/which-key.nvim',
		event = "VeryLazy",
		opts = {
			delay = 1000
		},
	},
	{
		'chomosuke/term-edit.nvim',
		event = 'TermOpen',
		version = '1.*',
		opts = {
			prompt_end = " ❯ ",
		},
	},
	{
		'numToStr/Comment.nvim',
		opts = {},
		event = "VeryLazy",
		init = function()
			local ft = require "Comment.ft"
			ft({ 'angular' }, ft.get('html'))
		end
	},
	{
		'nvim-tree/nvim-web-devicons',
		event = "VeryLazy",
	},
	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		event = "BufEnter",
		main = 'ibl',
		opts = {},
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		event = "BufEnter",
		opts = {},
	},
	{ 'towolf/vim-helm', ft = { 'helm', 'yaml', 'yml' }, event = "BufEnter" },
	{
		'lucidph3nx/nvim-sops',
		event = 'BufEnter',
		opts = {},
		ft = { 'json', 'yaml', 'yml' }
	},
}
