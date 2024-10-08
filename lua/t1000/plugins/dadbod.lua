return {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod',                     lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    config = function()
        vim.keymap.set('n', '<C-d>', ":DBUI<cr>")
        vim.keymap.set('n', '<C-a>', ":DBUIAddConnection<cr>")
    end
}