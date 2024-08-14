return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
        'saadparwaiz1/cmp_luasnip'
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        --require("luasnip.loaders.from_vscode").lazy_load()
        local cmp_select = {behavior = cmp.SelectBehavior.Select}

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { 
                "lua_ls", 
                "pyright", 
                "ruff"
                --"black",
                --"mypy",
                --""debugpy
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
            }
        })

        cmp.setup({
            sources = cmp.config.sources{
              {name = 'path'},
              {name = 'nvim_lsp'},
              {name = 'nvim_lua'},
              {name = 'luasnip', keyword_length = 2},
              {name = 'buffer', keyword_length = 3},
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
              ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
              ['<Enter>'] = cmp.mapping.confirm({ select = true }),
              ['<C-Space>'] = cmp.mapping.complete(),
            }),
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}