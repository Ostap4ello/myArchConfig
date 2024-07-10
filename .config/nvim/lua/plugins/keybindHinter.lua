return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- DocumencopeFuzzyCommandSearch) existing key chains
		require("which-key").register({
			["<leader><leader>"] = { name = "View changed files", _ = "which_key_ignore" },
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ebug", _ = "which_key_ignore" },
			--	["<leader>r"] = { name = "[R]ename", _ = "whichekey_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
			--	["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
			-- ["<leader>t"] = { name = "Focus next [T]ab", _ = "which_key_ignore" },
		})
		-- visual mode
		-- require("which-key").register({
		-- 	["<leader>h"] = { "Git [H]unk" },
		-- }, { mode = "v" })
	end,
}
