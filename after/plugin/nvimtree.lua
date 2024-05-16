local tree = require('nvim-tree')
local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  local keymap = vim.keymap
  keymap.set('n', '<leader>üü', api.tree.change_root_to_parent)
  keymap.set('n', '?', api.tree.toggle_help)
  keymap.set('n', '<leader>ee', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
  keymap.set('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' })
  keymap.set('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh file explorer'})

end
tree.setup({
  sort = {sorter = "case_sensitive"},
  view = {
    width = 35,
    relativenumber = true
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    group_empty = true
  },
  filters = { dotfiles = true },
  git = {
    ignore = false,
  },
  on_attach = on_attach,
})

