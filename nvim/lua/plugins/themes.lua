return {
  {
    'EdenEast/nightfox.nvim',
    config = function()
      vim.cmd.colorscheme 'nightfox'
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
