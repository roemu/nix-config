return {
	-- Highlight, edit, and navigate code
	'nvim-treesitter/nvim-treesitter',
	event = "BufEnter",
	lazy = false,
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	build = ':TSUpdate',
	config = function()
		vim.defer_fn(function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = {
					'make',
					'helm',
					'lua',
					'rust',
					'gitcommit',
					'javascript',
					'typescript',
					'vimdoc',
					'vim',
					'bash',
					'java',
					'angular',
					'html',
					'css',
					'scss',
					'yaml',
					'go',
					'c',
					'vim',
					'vimdoc',
					'markdown',
				},

				auto_install = false,
				sync_install = false,
				ignore_install = {},

				modules = {},
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = '<C-space>',
						node_incremental = '<C-space>',
						-- scope_incremental = '<C-s>',
						-- node_decremental = '<M-space>',
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/nvim-treesitter-text-objects.lua
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
							["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

							["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
							["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

							["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
							["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

							["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
							["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

							["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
							["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

							["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = { query = "@call.outer", desc = "Next function call start" },
							["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
							["]c"] = { query = "@class.outer", desc = "Next class start" },
							["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
							["]l"] = { query = "@loop.outer", desc = "Next loop start" },

							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]F"] = { query = "@call.outer", desc = "Next function call end" },
							["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
							["]C"] = { query = "@class.outer", desc = "Next class end" },
							["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
							["]L"] = { query = "@loop.outer", desc = "Next loop end" },
						},
						goto_previous_start = {
							["[f"] = { query = "@call.outer", desc = "Prev function call start" },
							["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
							["[c"] = { query = "@class.outer", desc = "Prev class start" },
							["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
							["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
						},
						goto_previous_end = {
							["[F"] = { query = "@call.outer", desc = "Prev function call end" },
							["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
							["[C"] = { query = "@class.outer", desc = "Prev class end" },
							["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
							["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
							["<leader>n:"] = "@property.outer", -- swap object property with next
							["<leader>nm"] = "@function.outer", -- swap function with next
						},
						swap_previous = {
							["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
							["<leader>p:"] = "@property.outer", -- swap object property with prev
							["<leader>pm"] = "@function.outer", -- swap function with previous
						},
					},
				},
			}
			local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
			parser_config.bruno = {
				install_info = {
					url = "~/personal/tree-sitter-bruno", -- local path or git repo
					files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
					-- optional entries:
					branch = "main",        -- default branch in case of git repo if different from master
					generate_requires_npm = false, -- if stand-alone parser without npm dependencies
					requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
				},
				filetype = "bru",           -- if filetype does not match the parser name
			}
		end, 0)
	end
}
