return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                auto_integrations = true,
            })

            vim.cmd.colorscheme "catppuccin-nvim"
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = false,
                theme = 'catppuccin-nvim',
                component_separators = '|',
                section_separators = { right = '', left = '' },
            },
        },
    },
}
