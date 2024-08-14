return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        -- Call the autopairs setup function to configure how we want autopairs to work
        require('nvim-autopairs').setup({})
    end
}