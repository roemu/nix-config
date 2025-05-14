return {
	'kristijanhusak/vim-dadbod-ui',
	event = "VeryLazy",
	dependencies = {
		{ 'tpope/vim-dadbod',                     lazy = true },
		{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
	},
	cmd = {
		'DBUI',
		'DBUIToggle',
		'DBUIAddConnection',
		'DBUIFindBuffer',
	},
	keys = {
		{ "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle [DB]UI" },
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_win_position = 'right'
	end,
}
