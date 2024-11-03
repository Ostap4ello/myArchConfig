-- lazy plugins section
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("vim-binds-native")
require("lazy").setup("plugins")

-- commands to run for user
vim.cmd.colorscheme("oxocarbon")

-- open nvim-tree on startup if no file is provided
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			require("nvim-tree.api").tree.open()
		end
	end,
})
-- instead of: require("nvim-tree.api").tree.open()
