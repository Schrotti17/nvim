return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- ui plugins to make debugging simplier
        'mfussenegger/nvim-dap-python',
        "rcarriga/nvim-dap-ui",
        'theHamsta/nvim-dap-virtual-text',
        "nvim-neotest/nvim-nio",
    },
    config = function()
        -- gain access to the dap plugin and its functions
        local dap = require("dap")
        -- gain access to the dap ui plugin and its functions
        local dapui = require("dapui")

        -- Setup the dap ui with default configuration
        require("dapui").setup()
        require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
        require("nvim-dap-virtual-text").setup()

        -- set a vim motion for <Space> + d + t to toggle a breakpoint at the line where the cursor is currently on
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug Toggle [B]reakpoint" })

        -- set a vim motion for <Space> + d + s to start the debugger and launch the debugging ui
        vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })

        -- set a vim motion to close the debugging ui
        vim.keymap.set("n", "<leader>dc", dapui.close, {desc = "[D]ebug [C]lose"})

        vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

        -- Eval var under cursor
        vim.keymap.set("n", "<space>?", function()
            require("dapui").eval(nil, { enter = true })
        end)

        vim.keymap.set("n", "<F2>", dap.step_into)
        vim.keymap.set("n", "<F3>", dap.step_over)
        vim.keymap.set("n", "<F4>", dap.step_out)
        vim.keymap.set("n", "<F5>", dap.step_back)
        vim.keymap.set("n", "<F13>", dap.restart)

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end
}
