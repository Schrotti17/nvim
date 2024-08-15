return {
    'numToStr/Comment.nvim',
    config = function()
        		-- Set a vim motion to <Space> + / to comment the line under the cursor in normal mode
		vim.keymap.set("n", "<leader>#", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment Line" })
		-- Set a vim motion to <Space> + / to comment all the lines selected in visual mode
		vim.keymap.set("v", "<leader>#", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment Selected" })
        require('Comment').setup()
    end
}