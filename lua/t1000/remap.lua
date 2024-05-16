vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
--vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeToggle)

-- nvim-tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")


-- Python debugpy
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>")
vim.keymap.set('n', '<leader>xr', function() require("dap").repl.toggle() end, { desc = "REPL" })
vim.keymap.set('n', '<leader>xs', function() require("dapui").float_element "scopes" end, { desc = "Scopes" })
vim.keymap.set('n', '<leader>xt', function() require("dapui").float_element "stacks" end, { desc = "Threads" })
vim.keymap.set('n', '<leader>xu', function() require("dapui").toggle() end, { desc = "Toggle Debugger UI" })
vim.keymap.set('n', '<leader>xw', function() require("dapui").float_element "watches" end, { desc = "Watches" })
vim.keymap.set('n', '<leader>xx', function() require("dap.ui.widgets").hover() end, { desc = "Inspect" })
