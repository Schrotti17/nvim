local tree = require('nvim-tree')
local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<leader>üü', api.tree.change_root_to_parent)
  vim.keymap.set('n', '?', api.tree.toggle_help)
end
tree.setup({
  sort = {sorter = "case_sensitive"},
  view = { width = 25 },
  renderer = { group_empty = true },
  filters = { dotfiles = true },
  on_attach = on_attach,
})

