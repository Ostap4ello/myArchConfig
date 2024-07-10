return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		-- "HiPhish/nvim-ts-rainbow2",
	},
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "bash", "python" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			modules = {},
			auto_install = false,
			ignore_install = {},
			-- rainbow = {
			-- 	enable = true,
			-- 	query = "rainbow-parens",
			-- 	strategy = require("ts-rainbow").strategy.global,
			-- },
		})
	end,
}
