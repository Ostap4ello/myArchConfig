return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			--vim.keymap.set('n', '<left>',	api.tree.change_root_to_parent,											opts('Up'))
			--vim.keymap.set('n', '<right>',  api.tree.change_root_to_node,					opts('CD'))
			--vim.keymap.set('n', '<left>',	api.tree.change_root_to_parent,        opts('Up'))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))

			-- Override color groups
			vim.cmd(":hi NvimTreeGitNew guifg=#88c0d0")
			vim.cmd(":hi NvimTreeGitDeleted guifg=#88c0d0")
			vim.cmd(":hi NvimTreeGitDirty guifg=#88c0d0")
			vim.cmd(":hi NvimTreeGitStaged guifg=#88c0d0")
		end

		require("nvim-tree").setup({
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},
			hijack_cursor = true,
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 30,
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
			on_attach = my_on_attach,
			auto_reload_on_write = true,
			modified = {
				enable = true,
			},
			renderer = {
				group_empty = true,
				highlight_opened_files = "name", -- "none" (default), "icon", "name" or "all"
				highlight_modified = "all",
				highlight_git = "none",
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
				icons = {
					git_placement = "after",
					modified_placement = "before",
					diagnostics_placement = "signcolumn",
					bookmarks_placement = "signcolumn",
				},
			},
		})
	end,
}
