return {
	'stevearc/oil.nvim',
	keys = {
		{ "<leader>o", "<cmd>Oil<cr>", desc = "Open Oil in parent directory" },
	},
	lazy = false,
	opts = {
		default_file_explorer = true,
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true
		}
	},
}
