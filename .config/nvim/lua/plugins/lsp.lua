return {
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },

			-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			require("neodev").setup({
				library = {
					library = { plugins = { "nvim-dap-ui" }, types = true },
					vimruntime = true, -- runtime files
					plugins = true, -- installed plugins
					config = true, -- config files
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					vim.keymap.set("n", "<leader>cd", require("telescope.builtin").lsp_definitions, {desc="[C]ode Goto [d]efinition"})
					vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, {desc="[C]ode Goto [R]eferences"})
					vim.keymap.set("n", "<leader>cI", require("telescope.builtin").lsp_implementations, {desc="[C]ode Goto [I]mplementation"})
					vim.keymap.set("n", "<leader>cD", require("telescope.builtin").lsp_type_definitions, {desc = "[C]ode Goto Type [D]efinition"})
					vim.keymap.set("n", "<leader>cS", require("telescope.builtin").lsp_document_symbols, {desc="[C]ode Document [S]ymbols"})
					vim.keymap.set("n", "<leader>cs", require("telescope.builtin").lsp_dynamic_workspace_symbols, {desc="[C]ode Dynamic [s]ymbols"})
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {desc="[C]ode [R]ename Object"})
					-- Execute a code action, usually your cursor needs to be on top of an error or a suggestion from your LSP for this to activate.
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {desc="[C]ode [A]ction (hint)"})

					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, {desc="Hover Documentation"})

                    vim.keymap.set("n", 'L', function()
						vim.diagnostic.open_float()
                    end, {desc="Show Line Diagnostics"})

					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {desc="[G]oto [D]eclaration"})

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

                    -- NOTE:

					-- The following autocommand is used to enable inlay hints in your code, if the language server you are using supports them
					-- This may be unwanted, since they displace some of your code
					-- if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					-- 	map("<leader>th", function()
					-- 		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled)
					-- 	end, "[T]oggle Inlay [H]ints")
					-- end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities() -- Initialize with the capabilities that the NVIM is able to do
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				clangd = {
					cmd = {
						"clangd",
						"--offset-encoding=utf-16",
						"--header-insertion=never",
					},
					-- root_dir = require("lspconfig/util").root_pattern("compile_commands.json", ".git", ".clangd"),
					-- root_dir = require("lspconfig/util").root_pattern("compile_commands.json", ".git", "compile_flags.txt") or
                        -- vim.fn.getcwd(),
				},
				pyright = {},
				-- ... etc. See `:help lspconfig-all`

				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"css-lsp",
				"stylua", -- Used to format Lua code
				"clang-format", -- Used to format C/C++ code
				"bash-language-server",
				"shfmt", -- Used to format shell scripts
				"jq", -- Used to format JSON
				"flake8", -- Used to lint Python
				"asmfmt", -- Used to format Assembly
				"black", -- Used to format Python
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
