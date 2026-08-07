return {
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
}
