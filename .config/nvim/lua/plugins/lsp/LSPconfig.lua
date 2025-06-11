return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{ "j-hui/fidget.nvim", opts = {} }, -- Useful status updates for LSP.
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({
				library = {
					library = { plugins = { "nvim-dap-ui" }, types = true },
					vimruntime = true, -- runtime files
					plugins = true, -- installed plugins
					config = true, -- config files
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- require("java").setup()

			local capabilities = vim.lsp.protocol.make_client_capabilities() -- Initialize with the capabilities that the NVIM is able to do
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" }, -- Recognize the global variable 'vim'
							},
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true), -- Add runtime files to the workspace
								checkThirdParty = false,
							},
							telemetry = { enable = false }, -- Disable telemetry
						},
					},
				},
				stylua = {},

				jdtls = { -- defined in ftplugin
					settings = {
						java = {
							configuration = {
								-- These are potential runtimes that the project can use. I believe for these to be used, the maven or
								-- gradle config files need to specify that a specific runtime should be used, or you can set it with
								-- :JdtSetRuntime.
								runtimes = {
									{
										name = "JavaSE-1.8",
										path = "/usr/lib/jvm/java-8-openjdk/",
									},
									{
										name = "JavaSE-11",
										path = "/usr/lib/jvm/java-11-openjdk/",
									},
									{
										name = "JavaSE-17",
										path = "/usr/lib/jvm/java-17-openjdk/",
										default = true,
									},
									{
										name = "JavaSE-21",
										path = "/usr/lib/jvm/java-21-openjdk/",
									},
									{
										name = "JavaSE-24",
										path = "/usr/lib/jvm/java-24-openjdk/",
									},
								},
							},
						},
					},
				},

				["bash-language-server"] = {},
				shfmt = {},

				clangd = {
					cmd = {
						"clangd --header-insertion=never",
						-- "--background-index",
						-- "--clang-tidy",
						-- "--log=verbose",
						-- "--header-insertion=never",
						-- "-Wall",
						-- "-Wextra",
						-- "-Werror",
					},
					init_options = {
						fallbackFlags = { "-std=c++17" }, -- Adjust as needed for your project
					},
				},
				["clang-format"] = {},

				pyright = {},
				flake8 = {},

				-- texlab = {},
				jq = {},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			-- vim.list_extend(ensure_installed, {
			-- "black", -- Used to format Python
			-- })

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
				ensure_installed = {},
				automatic_installation = true,
			})

			-- Keymaps for LSP
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					vim.keymap.set("n", "<leader>cd", function()
						require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
					end, { desc = "[C]ode Goto [d]efinition" })
					vim.keymap.set(
						"n",
						"<leader>cr",
						require("telescope.builtin").lsp_references,
						{ desc = "[C]ode Goto [r]eferences" }
					)
					vim.keymap.set(
						"n",
						"<leader>cI",
						require("telescope.builtin").lsp_implementations,
						{ desc = "[C]ode Goto [I]mplementation" }
					)
					vim.keymap.set(
						"n",
						"<leader>cD",
						require("telescope.builtin").lsp_type_definitions,
						{ desc = "[C]ode Goto Type [D]efinition" }
					)
					vim.keymap.set(
						"n",
						"<leader>cS",
						require("telescope.builtin").lsp_document_symbols,
						{ desc = "[C]ode Document [S]ymbols" }
					)
					vim.keymap.set(
						"n",
						"<leader>cs",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						{ desc = "[C]ode Dynamic [s]ymbols" }
					)
					vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename Object" })
					-- Execute a code action, usually your cursor needs to be on top of an error or a suggestion from your LSP for this to activate.
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction (hint)" })

					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, { desc = "Hover Documentation" })

					vim.keymap.set("n", "L", function()
						vim.diagnostic.open_float()
					end, { desc = "Show Line Diagnostics" })

					-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })

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
		end,
	},
}
