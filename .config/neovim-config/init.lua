-- Specify Python Interpreter for Neovim
vim.g.python3_host_prog = '~/.venvs/neovim/bin/python'

-------------------------------------------------------------
-- Plugin Manager: packer.nvim
-------------------------------------------------------------
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -----------------------------------------------------------
  -- Language Server Protocol (LSP) Support and Configuration
  -----------------------------------------------------------
  use 'neovim/nvim-lspconfig'
  use { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' }
  use 'GutenYe/fortran-lsp.nvim'  -- Additional Fortran support

  -----------------------------------------------------------
  -- Code Completion and Snippets
  -----------------------------------------------------------
  use 'hrsh7th/nvim-cmp'           -- Completion engine
  use 'hrsh7th/cmp-nvim-lsp'       -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer'         -- Buffer source for nvim-cmp
  use 'hrsh7th/cmp-path'           -- Path source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip'   -- Snippet completion
  use 'L3MON4D3/LuaSnip'           -- Snippet engine
  use 'rafamadriz/friendly-snippets' -- Common snippets

  -----------------------------------------------------------
  -- Syntax Highlighting
  -----------------------------------------------------------
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -----------------------------------------------------------
  -- File Explorer
  -----------------------------------------------------------
  use 'kyazdani42/nvim-tree.lua'

  -----------------------------------------------------------
  -- Fuzzy Finder
  -----------------------------------------------------------
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -----------------------------------------------------------
  -- Statusline and Tabline
  -----------------------------------------------------------
  use 'nvim-lualine/lualine.nvim'
  use 'romgrk/barbar.nvim'

  -----------------------------------------------------------
  -- Git Integration
  -----------------------------------------------------------
  use 'lewis6991/gitsigns.nvim'

  -----------------------------------------------------------
  -- Terminal Integration
  -----------------------------------------------------------
  use 'akinsho/toggleterm.nvim'

  -----------------------------------------------------------
  -- Debugger
  -----------------------------------------------------------
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  -----------------------------------------------------------
  -- Auto-pairs and Comments
  -----------------------------------------------------------
  use 'windwp/nvim-autopairs'
  use 'b3nj5m1n/kommentary'
end)

-------------------------------------------------------------
-- LSP Setup
-------------------------------------------------------------
-- Configure Mason for managing LSP installations
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'pyright', 'rust_analyzer', 'ccls', 'clangd' }
})

-- Load LSP configurations
local lspconfig = require('lspconfig')
lspconfig.pyright.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.ccls.setup{}
lspconfig.clangd.setup{}

-------------------------------------------------------------
-- Completion Configuration
-------------------------------------------------------------
local cmp = require('cmp')
vim.o.completeopt = 'menuone,noselect'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  })
})
