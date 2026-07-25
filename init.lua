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
vim.opt.fileformats = "unix,dos"
vim.keymap.set('n', '<leader>cm', ':%s/<C-v><CR>//g<CR>', { desc = 'Remove ^M characters' })
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
vim.keymap.set('n', '<leader>o', 'o<Esc>', { desc = 'New line below' })
vim.keymap.set('n', '<leader>O', 'O<Esc>', { desc = 'New line above' })
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('t', 'kj', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
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
vim.keymap.set('n', '<C-Left>', ':vertical resize -6<CR>', { desc = 'Decrease width' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +6<CR>', { desc = 'Increase width' })
vim.keymap.set('n', '<leader>rc', ':%s/\\/\\/.*\\|\\/\\*\\_.\\{-}\\*\\///ge<CR>:noh<CR>', { desc = 'Remove C++ comments' })
vim.keymap.set('n', 'gp', '`[v`]', { desc = 'Reselect last pasted text', remap = true })
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle file explorer' })


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
        transparent = true,
        term_colors = true,
        ending_tildes = false,
        cmp_itemkind_reverse = false,
      })
      require("onedark").load()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Safely require the module
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return -- Exit silently if not installed yet
      end

      configs.setup({
        ensure_installed = { 
          "c", "cpp", "python", "lua", "vim", "vimdoc", "query",
          "markdown", "markdown_inline", "sql", "asm", "bash"
        },
        highlight = {
          enable = true,
        },
      })
    end,
  },

  { "lewis6991/gitsigns.nvim", config = true },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<C-t>]], -- Press Ctrl+t to toggle the terminal
      direction = "float",      -- "float" is great, or use "horizontal"
      float_opts = { border = "curved" },
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      -- Smear cursor when jumping between buffers or windows
      smear_between_buffers = true,
      -- Smear cursor when moving down to neighbor lines
      smear_between_neighbor_lines = true,
      -- Animate cursor trail inside insert mode
      smear_insert_mode = true,
    },
  },
  { "goerz/jupytext.vim" },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("neo-tree").setup({
          close_if_last_window = false,
          popup_border_style = "rounded",
          enable_git_status = true,
          enable_diagnostics = true,
          default_component_configs = {
            indent = {
              indent_size = 2,
              padding = 1,
            },
            modified = {
              symbol = "[+]",
              highlight = "NeoTreeModified",
            },
            git_status = {
              symbols = {
                -- Changed symbols to minimal or empty
                added     = "",    -- Remove the ✚ for added files
                modified  = "",    -- Remove the dot for modified files
                deleted   = "",    -- Remove the ✖ for deleted files
                renamed   = "",    -- Remove the arrow for renamed files
                untracked = "",    -- Remove the ? for untracked files
                ignored   = "",    -- Remove the square for ignored files
                unstaged  = "",    -- Remove the gear for unstaged
                staged    = "",    -- Remove the checkmark for staged
                conflict  = "",    -- Remove the thunderbolt for conflicts
              },
            },
          },
          window = {
            position = "left",
            width = 30,
            mapping_options = {
              noremap = true,
              nowait = true,
            },
            mappings = {
              ["E"] = "expand_all_nodes",
              ["W"] ="close_all_nodes"
            },
          },
          filesystem = {
            filtered_items = {
              visible = false,        -- This means hidden files ARE shown by default
              hide_dotfiles = false,
              hide_gitignored = false,
              hide_by_name = {
                ".git",
              },
              never_show = {},
            },
            follow_current_file = {
              enabled = true,
              leave_dirs_open = false,
            },
          },
        })
      end,
    },
},
{
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
