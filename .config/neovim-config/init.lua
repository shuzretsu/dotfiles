- Set Python Interpreter for Neovim
vim.g.python3_host_prog = '~/.venvs/neovim/bin/python'
-------------------------------------------------------------
-- Plugin Manager: packer.nvim
-------------------------------------------------------------
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)

  -- packer
  use 'nvim-neotest/nvim-nio'
  use 'kyazdani42/nvim-web-devicons'
  

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Language Server Protocol (LSP) Support
  use 'neovim/nvim-lspconfig'
  use { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' }

  -- Code Completion and Snippets
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- Syntax Highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- File Explorer
  use 'kyazdani42/nvim-tree.lua'

  -- Fuzzy Finder
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Statusline and Tabline
  use 'nvim-lualine/lualine.nvim'
  use 'romgrk/barbar.nvim'

  -- Git Integration
  use 'lewis6991/gitsigns.nvim'

  -- Terminal Integration
  use 'akinsho/toggleterm.nvim'

  -- Debugger
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  -- Auto-pairs and Comments
  use 'windwp/nvim-autopairs'
  use 'b3nj5m1n/kommentary'
end)

-------------------------------------------------------------
-- LSP Setup
-------------------------------------------------------------
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'pyright', 'rust_analyzer', 'ccls', 'clangd', 'fortls' }
})

-- Load LSP configurations
local lspconfig = require('lspconfig')
lspconfig.pyright.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.ccls.setup{}
lspconfig.clangd.setup{}
lspconfig.fortls.setup{}


-------------------------------------------------------------
-- Completion and Language Server Configuration
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
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' }
  })
})

-------------------------------------------------------------
-- File Explorer Configuration
-------------------------------------------------------------
require('nvim-tree').setup()
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-------------------------------------------------------------
-- Telescope Fuzzy Finder Configuration
-------------------------------------------------------------
require('telescope').setup{
  defaults = {
    file_ignore_patterns = { "node_modules", ".git" },
  }
}
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true })

-------------------------------------------------------------
-- Git Configuration
-------------------------------------------------------------
require('gitsigns').setup()

-------------------------------------------------------------
-- Terminal Integration Configuration
-------------------------------------------------------------
require("toggleterm").setup{
  open_mapping = [[<C-\>]],
  direction = 'float',
}

-------------------------------------------------------------
-- Debugger (DAP) Configuration
-------------------------------------------------------------
local dap = require('dap')
local dapui = require('dapui')

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })

-------------------------------------------------------------
-- UI and Keybindings Configuration
-------------------------------------------------------------
require('lualine').setup { options = { theme = 'gruvbox' } }
require('bufferline').setup{}

-- Auto-pairs and Comments
require('nvim-autopairs').setup{}
require('kommentary.config').use_extended_mappings()

-------------------------------------------------------------
-- Treesitter for Syntax Highlighting
-------------------------------------------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = { "python", "rust", "c", "cpp", "cuda", "fortran" },
  highlight = { enable = true },
  indent = { enable = true },
  playground = { enable = true },
}

-------------------------------------------------------------
-- Telescope Keybindings
-------------------------------------------------------------
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })

--congigure
vim.g.barbar_icons_filetype_enabled = false

