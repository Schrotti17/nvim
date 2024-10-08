local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec="t1000.plugins",
  change_detection = { notify = false },
  checker = {
		-- Automatically check for package updates
		enabled = true,
		-- Don't spam us with notification every time there is an update available
		notify = false,
	},
})