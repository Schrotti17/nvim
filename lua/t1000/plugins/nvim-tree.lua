return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local keymap = vim.keymap
        local api = require("nvim-tree.api")
        keymap.set('n', '?', api.tree.toggle_help)
        keymap.set('n', '<leader>t', '<cmd>NvimTreeFocus<CR>', { desc = 'Toggle file explorer' })

        require("nvim-tree").setup({
            sort = { sorter = "case_sensitive" },
            view = {
                width = 32,
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
        })
    end
}

