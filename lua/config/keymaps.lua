local map = vim.keymap.set

map('n', '<leader>cm', ':%s/<C-v><CR>//g<CR>', { desc = 'Remove ^M characters' })
map('n', '<leader>o', 'o<Esc>', { desc = 'New line below' })
map('n', '<leader>O', 'O<Esc>', { desc = 'New line above' })
map('i', 'kj', '<Esc>')
map('t', 'kj', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
map('n', '<Esc>', ':noh<CR>', { desc = 'Clear search highlight' })
map('n', 'Y', 'y$')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')
map('v', '<', '<gv')
map('v', '>', '>gv')
map('v', 'J', ":m '>+1<CR>gv")
map('x', '<leader>p', '"_dP', { desc = 'Paste without losing register' })
map('n', '<leader>d', '"_d', { desc = 'Delete without yanking' })
map('x', '<leader>d', '"_d', { desc = 'Delete without yanking' })
map('n', '<leader>D', '"_D', { desc = 'Delete to end without yanking' })
map('n', '<leader>x', '"_x', { desc = 'Delete char without yanking' })
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
map('n', '<C-Up>', ':resize -2<CR>', { desc = 'Decrease height' })
map('n', '<C-Down>', ':resize +2<CR>', { desc = 'Increase height' })
map('n', '<C-Left>', ':vertical resize -6<CR>', { desc = 'Decrease width' })
map('n', '<C-Right>', ':vertical resize +6<CR>', { desc = 'Increase width' })
map('n', '<leader>rc', ':%s/\\/\\/.*\\|\\/\\*\\_.\\{-}\\*\\///ge<CR>:noh<CR>', { desc = 'Remove C++ comments' })
map('n', 'gp', '`[v`]', { desc = 'Reselect last pasted text', remap = true })
map('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle file explorer' })
map('n', '<leader>gl', vim.diagnostic.open_float, { desc = 'Show LSP diagnostics' })
map('n', '<leader>gy', function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diagnostics > 0 then
    vim.fn.setreg('+', diagnostics[1].message)
    print("Copied diagnostic to clipboard!")
  else
    print("No diagnostic on current line")
  end
end, { desc = 'Copy LSP diagnostic to clipboard' })

vim.api.nvim_create_user_command("CopyDiagnosticsAll", function()
  local diagnostics = vim.diagnostic.get(nil) -- get all workspace diagnostics
  if #diagnostics == 0 then
    print("No diagnostics found!")
    return
  end
  
  local lines = {}
  for _, diag in ipairs(diagnostics) do
    local severity = vim.diagnostic.severity[diag.severity] or "UNKNOWN"
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(diag.bufnr), ":t")
    local line = diag.lnum + 1
    table.insert(lines, string.format("[%s] %s:%d - %s", severity, filename, line, diag.message))
  end
  
  local text = table.concat(lines, "\n")
  vim.fn.setreg("+", text)
  print("Copied " .. #diagnostics .. " diagnostics to clipboard!")
end, { desc = "Copy all workspace diagnostics to clipboard" })
