return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-jest',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-jest' {
            jestCommand = 'npm test --',
            jestConfigFile = 'custom.jest.config.ts',
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
        discovery = {
          enabled = false,
        },
      }
    end,
    keys = {
      {
        '<leader>tl',
        function()
          require('neotest').run.run_last()
        end,
        desc = '[T]est run last',
      },
      {
        '<leader>tr',
        function()
          require('neotest').run.run()
        end,
        desc = '[T]est run nearest',
      },
      {
        '<leader>ta',
        function()
          require('neotest').run.run_all()
        end,
        desc = '[T]est run all',
      },
      {
        '<leader>td',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = '[T]est DAP run',
      },
      {
        '<leader>tx',
        function()
          require('neotest').run.stop()
        end,
        desc = '[T]est stop',
      },
      {
        '<leader>tn',
        function()
          require('neotest').jump.next { status = 'failed' }
        end,
        desc = '[T]est jump to next failed',
      },
      {
        '<leader>tp',
        function()
          require('neotest').jump.prev { status = 'failed' }
        end,
        desc = '[T]est jump to previous failed',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = '[T]est open summary',
      },
      {
        '<leader>to',
        function()
          require('neotest').ouput.open()
        end,
        desc = '[T]est open output',
      },
      {
        '<leader>tw',
        function()
          require('neotest').watch.watch()
        end,
        desc = '[T]est run in watch mode',
      },
    },
  },
}
