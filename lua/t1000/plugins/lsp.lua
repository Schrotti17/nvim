return {
    {
        "williamboman/mason.nvim",
        config = function()
            -- setup mason with default properties
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },

    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
            require('mason-tool-installer').setup({
                ensure_installed = {
                    -- LSP
                    "pyright", "jdtls", "tsserver",
                    "html", "emmet_ls", "cssls",
                    "lua_ls", "clangd",

                    -- Debugger
                    "java-debug-adapter", "java-test", "debugpy",

                    -- Linter
                    "ruff",

                    -- Formatter
                    "isort", "clang-format"
                }
            })
        end
    },

    -- mason lsp config utilizes mason to automatically ensure lsp servers you want installed are installed
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({})
        end
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/nvim-cmp',
            'saadparwaiz1/cmp_luasnip',
        },

        config = function()
            local cmp = require('cmp')
            local lspconfig = require("lspconfig")
            local cmp_lsp = require("cmp_nvim_lsp")
            --require("luasnip.loaders.from_vscode").lazy_load()
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())
            cmp.setup({
                sources = cmp.config.sources {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip', keyword_length = 2 },
                    { name = 'buffer',  keyword_length = 3 },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
            })

            -- setup python3 language server
            local util = require("lspconfig/util")
            local path = util.path
            lspconfig.pyright.setup {
                capabilities = capabilities,
                before_init = function(_, config)
                    local cwd = vim.fn.getcwd()
                    local default_venv_path = path.join(cwd, "env/bin/python3")
                    config.settings.python.pythonPath = default_venv_path
                end,
            }

            -- setup the c++ language server
            lspconfig.clangd.setup {}

            -- setup the lua language server
            lspconfig.lua_ls.setup {}


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

            -- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
            vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
            -- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
            -- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
            -- Set vim motion for <Space> + c + r to display references to the code under the cursor
            vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references,
                { desc = "[C]ode Goto [R]eferences" })
            -- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
            vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations,
                { desc = "[C]ode Goto [I]mplementations" })
            -- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
            vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
            -- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
            vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
        end
    },
}
