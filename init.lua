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
-- Basic settings
vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('v', 'kj', '<Esc>')
vim.keymap.set('c', 'kj', '<Esc>')
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.ignorecase = true 
vim.opt.smartcase = true
vim.opt.termguicolors = true   
vim.opt.cursorline = true     
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', ':noh<CR>', { desc = 'Clear search highlight' })
-- Keep cursor centered while searching
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- Move lines up/down in visual mode
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
-- Window management keymaps
vim.keymap.set('n', 'J', 'mzJ`z')
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without yanking' })
vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set('x', '<leader>d', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set('n', '<leader>D', '"_D', { desc = 'Delete to end without yanking' })
vim.keymap.set('n', '<leader>x', '"_x', { desc = 'Delete char without yanking' })
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', {desc = 'Decrease height'})
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', {desc = 'Increase height'})
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', {desc = 'Decrease width'})
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', {desc = 'Increase width'})
vim.keymap.set('n', '<C-S-Up>', ':resize -10<CR>', {desc = 'Decrease height by 10'})
vim.keymap.set('n', '<C-S-Down>', ':resize +10<CR>', {desc = 'Increase height by 10'})
vim.keymap.set('n', '<C-S-Left>', ':vertical resize -10<CR>', {desc = 'Decrease width by 10'})
vim.keymap.set('n', '<C-S-Right>', ':vertical resize +10<CR>', {desc = 'Increase width by 10'})
vim.keymap.set('n', '<C-h>', '<C-w>h', {desc = 'Move to left window'})
vim.keymap.set('n', '<C-j>', '<C-w>j', {desc = 'Move to window below'})
vim.keymap.set('n', '<C-k>', '<C-w>k', {desc = 'Move to window above'})
vim.keymap.set('n', '<C-l>', '<C-w>l', {desc = 'Move to right window'})

vim.opt.splitbelow = true
vim.opt.splitright = true


-- ============================================
-- LAZY.NVIM PLUGINS
-- ============================================
require("lazy").setup({
  -- One Dark colorscheme with toggle support
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "deep",  -- Default style
        toggle_style_key = "<leader>ts",  -- Press Space+ts to toggle styles
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer" },
        transparent = false,
        term_colors = true,
        ending_tildes = false,
        cmp_itemkind_reverse = false,
      })
      require("onedark").load()
    end,
  },
  
}, {
  -- Lazy.nvim configuration
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


