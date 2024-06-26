local lsp = require("lsp-zero")

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  },
  ensure_installed = {
    'pyright',
 --   'debugpy',
  --  'black',
    'ruff',
    'lua_ls',
--    'mypy',
  },
 })
require("mason-tool-installer").setup {
  ensure_installer = {

  },
  auto_update = false,
  run_on_start = true,
  -- Disable integration with other Mason plugins. This removes
  -- the ability to to use the alternative names of packages provided
  -- by these plugins but disables them from immediately becoming loaded
  integrations = {
    ["mason-lspconfig"] = true,
    ["mason-null-ls"] = true,
    --["mason-nvim-dap"] = true,
  }
}

local cmp = require('cmp')
require("luasnip.loaders.from_vscode").lazy_load()
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
  sources = cmp.config.sources{
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  formatting = lsp.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)


local config = require("lsp-zero")
local lspconfig = require("lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})

vim.diagnostic.config({
    virtual_text = true
})
