  return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = {
      {'nvim-lua/plenary.nvim'},
    },
    config = function()
      require('telescope').setup({
        pickers = {
          live_grep = {
            hidden = true
          },
          find_files = {
            hidden = true
          }
        }
      })
    end
  }
