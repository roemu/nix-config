---@type LazySpec
return {
  'mistweaverco/kulala.nvim',
  keys = {
    { "<leader>kr", "<cmd>lua require('kulala').run()<cr>",              "n", "http" },
    { "<leader>kR", "<cmd>lua require('kulala').run_all()<cr>",          "n", "http" },
    { "<leader>ki", "<cmd>lua require('kulala').inspect()<cr>",          "n", "http" },
    { "<leader>kc", "<cmd>lua require('kulala').copy()<cr>",             "n", "http" },
    { "<leader>kC", "<cmd>lua require('kulala').from_curl()<cr>",        "n", "http" },
    { "<leader>kt", "<cmd>lua require('kulala').toggle_view()<cr>",      "n", "http" },
    { "<leader>kf", "<cmd>lua require('kulala').search()<cr>",           "n", "http" },
    { "<leader>ke", "<cmd>lua require('kulala').set_selected_env()<cr>", "n", "http" },
  },
  config = function()
    require('kulala').setup({
      default_env = "dev",
      additional_curl_options = { "--location" },
      ui = {
        winbar = true,
        default_view = "headers_body",
        default_winbar_panes = { "body", "headers", "headers_body" },
      },
      contenttypes = {
        ["application/json"] = {
          ft = "json",
          formatter = vim.fn.executable("jq") == 1 and { "jq", "." },
          pathresolver = function(...)
            return require("kulala.parser.jsonpath").parse(...)
          end,
        },
        ["application/problem+json"] = "application/json",
      },
    })
    vim.filetype.add({
      extension = {
        ['http'] = 'http',
      },
    })
  end,
}
