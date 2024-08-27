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
                    "lua_ls",

                    -- DAP
                    "debugpy",

                    -- Linter
                    "ruff",

                    -- Formatter
                    "isort",
                }
            })
        end
    },

    -- mason lsp config utilizes mason to automatically ensure lsp servers you want installed are installed
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            -- ensure that we have lua language server, typescript launguage server, java language server, and java test language server are installed
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- "lua_ls",
                    -- "pyright",
                    -- "tsserver",
                    -- "jdtls",
                    -- "html",
                    -- "emmet_ls",
                    -- "cssls"
                    -- "debugpy",
                    -- "java-test",
                    -- "java-debug-adapter",
                    -- "google-java-format",
                    -- "black",
                    -- "isort"
                    -- "mypy",
                },
            })
        end
    },

    -- {
    --     "rshkarin/mason-nvim-lint",
    --     dependencies = {
    --         "mfussenegger/nvim-lint"
    --     },
    --     config = function()
    --         require('mason-nvim-lint').setup({
    --             ensure_installed = {
    --                 "ruff"
    --             },
    --             automatic_installation = false
    --         })
    --     end
    -- },

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
            -- setup the python language server
            lspconfig.pyright.setup({
                filetypes = { "python" },
                on_init = function(client)
                    local cwd = vim.fn.getcwd()
                    local venv_path = find_venv(cwd)
                    if venv_path then
                        print("Venv folder found: " .. venv_path)
                        vim.env.VIRTUAL_ENV = venv_path
                        vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH

                        -- Set the flag to true
                        pyright_restarted = true

                        vim.schedule(function()
                            vim.cmd('LspRestart pyright')
                            print("Pyright restarted with new venv settings")
                        end)
                    else
                        print("No venv folder found in or one level below current directory: " .. cwd)
                    end
                end
            })

            vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
                pattern = { "*.py" },
                callback = function()
                    vim.cmd('silent !black --quiet %')
                end,
            })
            -- setup the lua language server
            lspconfig.lua_ls.setup({
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
    -- mason nvim dap utilizes mason to automatically ensure debug adapters you want installed are installed, mason-lspconfig will not automatically install debug adapters for us
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            -- ensure the java debug adapter is installed
            require("mason-nvim-dap").setup({
                ensure_installed = { "java-debug-adapter", "java-test" }
            })
        end
    },
    -- utility plugin for configuring the java language server for us
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "mfussenegger/nvim-dap",
        }
    },
}
