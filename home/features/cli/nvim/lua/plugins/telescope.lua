return {
	'nvim-telescope/telescope.nvim',
	event = "BufEnter",
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-ui-select.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
	},
	opts = {
		defaults = {
			mappings = {
				i = {
					['<C-u>'] = false,
					['<C-d>'] = false,
				},
			},
			layout_config = {
				width = 0.8
			},
		},
		extensions = {
			fzf = {},
		},
	},
	config = function()
		local function filenameFirst(_, path)
			local tail = vim.fs.basename(path)
			local parent = vim.fs.dirname(path)
			if parent == "." then return tail end
			return string.format("%s\t\t%s", tail, parent)
		end

		require("telescope").setup {
			pickers = {
				find_files = {
					path_display = filenameFirst,
				},
				git_branches = {
					mappings = {
						i = { ["<CR>"] = require("telescope.builtin.__git").git_switch_branch }
					}
				}
			}
		}

		vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
		vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_branches, { desc = '[G]it [S]witch' })

		vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
		vim.keymap.set('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols, { desc = '[F]ind [S]Symbols' })
		vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
		vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
		vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
		vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

		vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { desc = '[G]oto [D]efinition' })


		require('telescope').load_extension("ui-select")
		require('telescope').load_extension("fzf")
	end
}
