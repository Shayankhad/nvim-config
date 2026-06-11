-- ~/.config/nvim/init.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================
-- BASIC SETTINGS
-- ============================================
vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- ============================================
-- KEYMAPS
-- ============================================

-- Escape
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('v', 'kj', '<Esc>')
vim.keymap.set('c', 'kj', '<Esc>')

-- General
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<Esc>', ':noh<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', 'Y', 'y$')

-- Search (keep cursor centered)
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Better J (keep cursor in place)
vim.keymap.set('n', 'J', 'mzJ`z')

-- Indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Move lines up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Black hole register
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without losing register' })
vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set('x', '<leader>d', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set('n', '<leader>D', '"_D', { desc = 'Delete to end without yanking' })
vim.keymap.set('n', '<leader>x', '"_x', { desc = 'Delete char without yanking' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Equalize all windows' })

-- Window resizing
vim.keymap.set('n', '<C-Up>',      ':resize -2<CR>',          { desc = 'Decrease height' })
vim.keymap.set('n', '<C-Down>',    ':resize +2<CR>',          { desc = 'Increase height' })
vim.keymap.set('n', '<C-Left>',    ':vertical resize -2<CR>', { desc = 'Decrease width' })
vim.keymap.set('n', '<C-Right>',   ':vertical resize +2<CR>', { desc = 'Increase width' })
vim.keymap.set('n', '<C-S-Up>',    ':resize -10<CR>',          { desc = 'Decrease height by 10' })
vim.keymap.set('n', '<C-S-Down>',  ':resize +10<CR>',          { desc = 'Increase height by 10' })
vim.keymap.set('n', '<C-S-Left>',  ':vertical resize -10<CR>', { desc = 'Decrease width by 10' })
vim.keymap.set('n', '<C-S-Right>', ':vertical resize +10<CR>', { desc = 'Increase width by 10' })

-- ============================================
-- PLUGINS
-- ============================================
require("lazy").setup({

  -- Colorscheme
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "deep",
        toggle_style_key = "<leader>ts",
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer" },
        transparent = false,
        term_colors = true,
        ending_tildes = false,
        cmp_itemkind_reverse = false,
      })
      require("onedark").load()
    end,
  },

  -- Mason (LSP installer)
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim" },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip", version = "v2.*" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Jupyter notebooks
  { "goerz/jupytext.vim" },

}, {
  install = {
    colorscheme = { "onedark" },
  },
  checker = {
    enabled = false,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- ============================================
-- LSP SETUP
-- ============================================

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",   -- C and C++
    "pyright",  -- Python + Jupyter
  },
})

-- C / C++
vim.lsp.config('clangd', {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
})

-- Python / Jupyter
vim.lsp.config('pyright', {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      }
    }
  }
})

vim.lsp.enable({ 'clangd', 'pyright' })

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,    opts)
    vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,   opts)
    vim.keymap.set('n', 'gr',         vim.lsp.buf.references,    opts)
    vim.keymap.set('n', 'K',          vim.lsp.buf.hover,         opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,        opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,   opts)
    vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,  opts)
    vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,  opts)
    vim.keymap.set('n', '<leader>e',  vim.diagnostic.open_float, opts)
  end
})
-- ============================================
-- AUTOCOMPLETE SETUP
-- ============================================

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
    ['<CR>']      = cmp.mapping.confirm({ select = true }),
    ['<Tab>']     = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>']   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})
