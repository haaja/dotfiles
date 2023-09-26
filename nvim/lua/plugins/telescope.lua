return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.3',
  dependencies = {
    {'nvim-lua/plenary.nvim'},
  },
  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules", "build", "dist", "yarn.lock"
       },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--smart-case", "--glob", "!**/.git/*" },
          hidden = true
        },
        grep_string = {
          hidden = true
        },
        live_grep = {
          hidden = true
        },
      }
    })
  end
}
