return {
	"jose-elias-alvarez/null-ls.nvim",
	-- "nvimtools/none-ls.nvim",
	-- dependencies = {
	-- 	"nvim-lua/plenary.nvim",
	-- 	"nvim-lua/popup.nvim",
	-- 	"nvim-lua/telescope.nvim",
	-- 	"nvimtools/none-ls-extras.nvim",
	-- },
	config = function()
		local null_ls = require("null-ls")

		local sources = {
			null_ls.builtins.diagnostics.flake8,

			null_ls.builtins.formatting.clang_format.with({
				extra_args = { "-style={BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4, UseTab: ForIndentation}" },
			}),

			null_ls.builtins.formatting.shfmt.with({
				extra_args = { "-i", "4", "-ci" },
			}),

			null_ls.builtins.formatting.prettier.with({
				filetypes = {
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					-- "json",
					"yaml",
					"markdown",
				},
			}),
			null_ls.builtins.formatting.jq,
			-- null_ls.builtins.formatting.black,
			-- null_ls.builtins.formatting.prettier.with({
			-- 	prefer_local = "node_modules/.bin",
			-- }),
			-- null_ls.builtins.formatting.eslint.with({
			-- 	prefer_local = "node_modules/.bin",
			-- }),
			-- null_ls.builtins.formatting.fish_indent,
			-- null_ls.builtins.formatting.taplo,
			-- null_ls.builtins.formatting.terraform_fmt,
			-- null_ls.builtins.formatting.trim_newlines,
			-- null_ls.builtins.formatting.trim_whitespace,
			-- null_ls.builtins.formatting.uncrustify,
			-- null_ls.builtins.diagnostics.eslint.with({
			-- 	prefer_local = "node_modules/.bin",
			-- }),
			-- null_ls.builtins.diagnostics.mypy.with({
			-- 	prefer_local = ".venv/bin",
			-- }),
			-- null_ls.builtins.diagnostics.shellcheck,
			-- null_ls.builtins.diagnostics.hadolint,
			-- null_ls.builtins.code_actions.eslint.with({
			-- 	prefer_local = "node_modules/.bin",
			-- }),
			-- null_ls.builtins.code_actions.gitsigns,
		}

		null_ls.setup({
			sources = sources,
		})
	end,
}
