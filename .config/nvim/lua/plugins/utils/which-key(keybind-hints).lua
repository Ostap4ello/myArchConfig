return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- DocumencopeFuzzyCommandSearch) existing key chains
		require("which-key").add({
			{ "<leader><leader>", group = "View changed files" },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>d", group = "[D]ebug" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>t", group = "[T]oggle" },
			-- { "<leader>r", group = "[R]ename" },
			-- { "<leader>h", group = "Git [H]unk" },
			-- { "<leader>t", group = "Focus next [T]ab" },
		})
	end,
}
