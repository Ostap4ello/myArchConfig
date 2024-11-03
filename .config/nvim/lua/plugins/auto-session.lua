return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			-- log_level = "info", -- Optional: Log verbosity (e.g., 'error', 'info')
			-- auto_session_enable_last_session = true, -- Enable restoring the last session
			-- auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/", -- Session file storage
			-- auto_session_enabled = true, -- Enable session management
			-- auto_save_enabled = true, -- Automatically save sessions when leaving Neovim
			-- auto_restore_enabled = true, -- Automatically restore sessions when starting Neovim
			auto_session_suppress_dirs = { "~/", "/" }, -- Directories to suppress auto-session
		})
	end,
}
