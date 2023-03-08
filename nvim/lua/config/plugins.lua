vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  --
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
  use({ 'rose-pine/neovim', as = 'rose-pine' })

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

  use {
      'nvim-tree/nvim-tree.lua',
      requires = {
          'nvim-tree/nvim-web-devicons'
      }
      --after = 'nvim-web-devicons', -- optional, for file icons
      --requires = 'nvim-tree/nvim-web-devicons'
      --tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use('tpope/vim-fugitive')

  use('fatih/vim-go')


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  --if packer_bootstrap then
  --  require('packer').sync()
  --end
end)

