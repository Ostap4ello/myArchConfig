return {
	-- { "sindrets/diffview.nvim" },
	{
		"tanvirtin/vgit.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
		-- Lazy loading on 'VimEnter' event is necessary.
		event = "VimEnter",
		config = function()
			local vgit = require("vgit")
			vgit.toggle_diff_preference()
			vgit.toggle_live_blame()
			vgit.toggle_live_gutter() -- disables gutter as it is quite unstable

			vim.keymap.set("n", "<leader>gd", function()
				vgit.buffer_diff_preview()
			end, { desc = "[G]it show [d]iff" })
			vim.keymap.set("n", "<leader>gD", function()
				vgit.toggle_diff_preference()
			end, { desc = "[G]it toggle [D]iff inline/split view" })
			vim.keymap.set("n", "<leader>gb", function()
				vgit.buffer_blame_preview()
			end, { desc = "[G]it show [b]lame" })
			vim.keymap.set("n", "<leader>gB", function()
				vgit.buffer_blame_preview()
			end, { desc = "[G]it toggle live [B]lame" })
			vgit.setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim", -- better gutter
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
}
