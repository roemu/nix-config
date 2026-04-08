return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
            vim.g.no_plugin_maps = true
        end,
        config = function()
            require("nvim-treesitter-textobjects").setup {
                select = {
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = 'V',
                        -- ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    include_surrounding_whitespace = false,
                },
            }

            -- select keymaps
            local sel = function(query)
                return function()
                    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
                end
            end

            vim.keymap.set({ "x", "o" }, "aa", sel("@parameter.outer"))
            vim.keymap.set({ "x", "o" }, "ia", sel("@parameter.inner"))

            vim.keymap.set({ "x", "o" }, "am", sel("@function.outer"))
            vim.keymap.set({ "x", "o" }, "im", sel("@function.inner"))

            vim.keymap.set({ "x", "o" }, "ac", sel("@class.outer"))
            vim.keymap.set({ "x", "o" }, "ic", sel("@class.inner"))

            vim.keymap.set({ "x", "o" }, "ai", sel("@conditional.outer"))
            vim.keymap.set({ "x", "o" }, "ii", sel("@conditional.inner"))

            vim.keymap.set({ "x", "o" }, "al", sel("@loop.outer"))
            vim.keymap.set({ "x", "o" }, "il", sel("@loop.inner"))

            vim.keymap.set({ "x", "o" }, "af", sel("@call.outer"))
            vim.keymap.set({ "x", "o" }, "if", sel("@call.inner"))

            -- swap keymaps
            vim.keymap.set("n", "<leader>na", function()
                require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
            end)
            vim.keymap.set("n", "<leader>pa", function()
                require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
            end)
        end,
    },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        config = function()
            vim.defer_fn(function()
                local ensureInstalled = {
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
                    'http',
                    'css',
                    'scss',
                    'yaml',
                    'go',
                    'c',
                    'vim',
                    'vimdoc',
                    'markdown',
                }
                local alreadyInstalled = require('nvim-treesitter.config').get_installed()
                local parsersToInstall = vim.iter(ensureInstalled)
                    :filter(function(parser)
                        return not vim.tbl_contains(alreadyInstalled, parser)
                    end)
                    :totable()
                require('nvim-treesitter').install(parsersToInstall)

                vim.api.nvim_create_autocmd('FileType', {
                    callback = function()
                        -- Enable treesitter highlighting and disable regex syntax
                        pcall(vim.treesitter.start)
                        -- Enable treesitter-based indentation
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end,
                })
            end, 0)
        end
    }
}
