vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  --
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.3',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
  use 'nvim-treesitter/nvim-treesitter-context'

  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},

          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'saadparwaiz1/cmp_luasnip'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-nvim-lua'},

          -- Snippets
          {'L3MON4D3/LuaSnip'},
          {'rafamadriz/friendly-snippets'},
      }
  }

  use('tpope/vim-fugitive')

  use('fatih/vim-go')


  --use({ 'rose-pine/neovim', as = 'rose-pine' })
  use('bluz71/vim-nightfly-colors')

  use('theprimeagen/harpoon')

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  --if packer_bootstrap then
  --  require('packer').sync()
  --end
end)

