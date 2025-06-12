return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownStartPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"jghauser/auto-pandoc.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "markdown",

		config = function()
			local id = nil
			local startPandocPreview = function()
				id = vim.api.nvim_create_autocmd("BufWritePost", {
					buffer = 0,
					callback = function()
						require("auto-pandoc").run_pandoc()
					end,
				})
			end

			local stopPandocPreview = function()
				if id ~= nil then
					vim.api.nvim_del_autocmd(id)
				end
			end

			local insertHeaders = function()
				local headers = {
					"---",
					"pandoc_:",
					" - output: .pdf",
					" - template: codedoc.tex",
					" - pdf-engine: xelatex",
					"output:",
					"  pdf_document:",
					"    latex_engine: xelatex",
					"    fig_caption: true",
					"---",
				}
				vim.api.nvim_buf_set_lines(0, 0, 1, false, headers)
			end

			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "*.md",
				callback = function()
					vim.api.nvim_buf_create_user_command(0, "PandocStartPreview", startPandocPreview, {})
					vim.api.nvim_buf_create_user_command(0, "PandocStopPreview", stopPandocPreview, {})
					vim.api.nvim_buf_create_user_command(0, "PandocInsertHeaders", insertHeaders, {})
				end,
				group = vim.api.nvim_create_augroup("PandocPreviewerGroup", {}),
				desc = "Set keymap for auto-pandoc",
			})
		end,
	},
}
