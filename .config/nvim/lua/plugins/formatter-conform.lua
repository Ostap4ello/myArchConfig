return { -- Autoformat
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			c = { "clang_format_new" },
			-- sh = { "beautysh" },
			-- zsh = { "beautysh" },
			-- csh = { "beautysh" },
			-- ksh = { "beautysh" },
			bash = { "shfmt" },
			assembly = { "asmfmt" },
			-- c = { "clang-format" },
			-- cpp = { "clang-format" },
			-- c = { "clang_format_new" },
			-- cpp = { "clang_format_new" },
			-- Conform can also run multiple formatters sequentially
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
			-- javascript = { { "prettierd", "prettier" } },
		},
		formatters = {
			clang_format_new = {
				command = "clang-format",
				args = {
					"-style={BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4, UseTab: ForIndentation, ColumnLimit: 100}",
				},
				stdin = true,
			},
		},
	},
}
