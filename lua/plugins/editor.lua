return {
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
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      smear_insert_mode = true,
      stiffness = 1.1,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.2,
      cursor_color = "#d3cdc3",
      legacy_computing_symbols_support = false,
      hide_target_hack = false,
      window_priority = 120,
    },
  },
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
          indent = { indent_size = 2, padding = 1 },
          modified = { symbol = "[+]", highlight = "NeoTreeModified" },
          git_status = {
            symbols = {
              added     = "",
              modified  = "",
              deleted   = "",
              renamed   = "",
              untracked = "",
              ignored   = "",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            },
          },
        },
        window = {
          position = "left",
          width = 30,
          mapping_options = { noremap = true, nowait = true },
          mappings = {
            ["E"] = "expand_all_nodes",
            ["W"] ="close_all_nodes",
            ["V"] = "open_vsplit",  
            ["X"] = "open_split",   
            ["<CR>"] = "open",          
          },
        },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = { ".git" },
            never_show = {},
          },
          follow_current_file = { enabled = true, leave_dirs_open = false },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          preview = { treesitter = false },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      })
      pcall(telescope.load_extension, "fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
}
