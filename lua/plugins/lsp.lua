return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ts_ls",
        "lua_ls",
        "bashls",
        "clangd",
        "jsonls",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
        "ruff",
        "clang-format",
        "shfmt",
        "shellcheck",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Global default capabilities for all LSP servers
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Pyright: use custom venv if present, otherwise rely on active environment
      local venv_python = vim.fn.expand("~/ml/venv/bin/python")
      local pyright_settings = {}
      if vim.fn.filereadable(venv_python) == 1 then
        pyright_settings = {
          python = {
            pythonPath = venv_python,
          },
        }
      end
      vim.lsp.config("pyright", {
        settings = pyright_settings,
      })

      -- Lua language server: recognize global 'vim'
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Enable all servers
      local servers = { "pyright", "ts_ls", "lua_ls", "bashls", "clangd", "jsonls" }
      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end
    end,
  },
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = "rafamadriz/friendly-snippets",
    opts = {
      keymap = {
        preset = "default",
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
