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
vim.opt.fileformat = "unix"
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
vim.keymap.set('n', '<C-S-Up>',    ':resize -10<CR>',         { desc = 'Decrease height by 10' })
vim.keymap.set('n', '<C-S-Down>',  ':resize +10<CR>',         { desc = 'Increase height by 10' })
vim.keymap.set('n', '<C-S-Left>',  ':vertical resize -10<CR>', { desc = 'Decrease width by 10' })
vim.keymap.set('n', '<C-S-Right>', ':vertical resize +10<CR>', { desc = 'Increase width by 10' })

vim.keymap.set('t', 'kj', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
-- ============================================
-- PLUGINS (lazy.nvim)
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

  -- LSP Core & Installer
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" }, -- Required for bridging mason & native LSP config

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip", version = "v2.*" },
  { "saadparwaiz1/cmp_luasnip" },

-- Treesitter (Advanced Highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- The old require("nvim-treesitter.configs").setup() is gone.
      -- We just call the main module setup function directly:
      require("nvim-treesitter").setup({
        ensure_installed = { "c", "cpp", "python", "lua", "vim", "vimdoc" },
        highlight = { enabled = true },
        indent = { enabled = true },
      })
    end,
  },
  -- Telescope (Fuzzy Finder)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
    end
  },

  -- Commenting tool (gcc to comment line, gc in visual mode)
  { "numToStr/Comment.nvim", config = true },

  -- Git integration gutter indicators
  { "lewis6991/gitsigns.nvim", config = true },

  -- Jupyter notebooks
  { "goerz/jupytext.vim" },

}, {
  install = { colorscheme = { "onedark" } },
  checker = { enabled = false, notify = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})

-- ============================================
-- LSP SETUP
-- ============================================

-- Setup mason utilities
require("mason").setup()

-- Link cmp capabilities to LSP configs so autocomplete actually gets suggestions
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require("lspconfig")

require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "pyright" },
  handlers = {
    -- Default handler sets up servers automatically with cmp capabilities
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
      })
    end,
    
    -- Dedicated override for Pyright (adds your custom settings)
    ["pyright"] = function()
      lspconfig.pyright.setup({
        capabilities = capabilities,
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
    end,
  }
})

-- LSP global keymaps trigger only when server attaches to buffer
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
    ['='] = nil,  -- Prevents = from triggering snippets
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
