return {
  {
    'mfussenegger/nvim-dap',
    event = "VeryLazy",
    dependencies = {
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require 'dap'

      require('mason-nvim-dap').setup {
        automatic_setup = true,
        handlers = {},
        ensure_installed = {
          'javadbg',
          'delve',
        },
      }

      dap.configurations.java = {
        {
          type = "java",
          name = "Attach to the process",
          request = "attach",
          hostName = "localhost",
          port = "5005"
        }
      }

      local function show_dap_centered_scopes()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end

      vim.keymap.set('n', '<leader>dv', show_dap_centered_scopes, { desc = "Debug: show variables" })
      vim.keymap.set('n', '<leader>ds', dap.continue, { desc = 'Debug: Start' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug: Step Out' })

      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Toggle Breakpoint with condition' })
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    event = "VeryLazy",
    dependencies = {
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap',
    },
    keys = {
      { "<leader>dt", "<cmd>lua require('dapui').toggle()<cr>", desc = "Debug UI: Toggle" },
    },
    opts = {
      layouts = {
        {
          size = 40,
          position = "left",
          elements = {
            {
              id = "breakpoints",
              size = 0.3
            },
            {
              id = "scopes",
              size = 0.7
            },
          },
        },
        {
          size = 10,
          position = "bottom",
          elements = {
            {
              id = "repl",
              size = 1
            },
          },
        }
      },
    },
  }
}
