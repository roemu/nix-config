return {
  'barrettruth/canola.nvim', -- NOTE: stevearc/oil.nvim is not very actively maintained, this is a community managed fork
  branch = 'canola',
  lazy = false,
  keys = {
    { "<leader>o", "<cmd>Canola<cr>", desc = "Open Canola in parent directory" },
  },
  init = function()
    vim.g.canola = {
      columns = { 'icon' },
      hidden = {
        enabled = false,
      },
      watch = true,
      confirm = 'delete',
    }
  end,
}
