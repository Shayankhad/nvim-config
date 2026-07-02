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

vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('v', 'kj', '<Esc>')
vim.keymap.set('c', 'kj', '<Esc>')
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<Esc>', ':noh<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv")
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without losing register' })
vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set('x', '<leader>d', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set('n', '<leader>D', '"_D', { desc = 'Delete to end without yanking' })
vim.keymap.set('n', '<leader>x', '"_x', { desc = 'Delete char without yanking' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { desc = 'Decrease height' })
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { desc = 'Increase height' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease width' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase width' })
vim.keymap.set('t', 'kj', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

require("lazy").setup({

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

  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup()
    end,
  },

  { "lewis6991/gitsigns.nvim", config = true },

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
