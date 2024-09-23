return {
	-- {
	-- 	"folke/lsp-colors.nvim",
	-- 	-- config = function()
	-- 	-- 	require("zenbones").setup()
	-- 	-- end,
	-- },
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").setup({
				override = {
					-- Normal = {
					-- 	bg = "#1d1f21",
					-- },
					-- ColorColumn = {
					-- 	bg = "#363a41",
					-- },
					-- LspReferenceText = { bg = "#3b4252" }, -- values and text
					LspReferenceRead = { bg = "#3b4252" }, -- calls etc
					LspReferenceWrite = { bg = "#3b4252" }, -- declarations etc
					MatchParen = {
						bg = "#3b4252",
					},
				},
			})
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		-- Add in any other configuration;
		--   event = foo,
		--   config = bar
		--   end,
	},
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	config = function()
	-- 		-- Default options:
	-- 		require("kanagawa").setup({
	-- 			compile = false, -- enable compiling the colorscheme
	-- 			undercurl = true, -- enable undercurls
	-- 			commentStyle = { italic = true },
	-- 			functionStyle = {},
	-- 			keywordStyle = { italic = true },
	-- 			statementStyle = { bold = true },
	-- 			typeStyle = {},
	-- 			transparent = false, -- do not set background color
	-- 			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	-- 			terminalColors = true, -- define vim.g.terminal_color_{0,17}
	-- 			colors = { -- add/modify theme and palette colors
	-- 				palette = {},
	-- 				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	-- 			},
	-- 			overrides = function(colors) -- add/modify highlights
	-- 				return {}
	-- 			end,
	-- 			theme = "dragon", -- Load "wave" theme when 'background' option is not set
	-- 			background = { -- map the value of 'background' option to a theme
	-- 				dark = "wave", -- try "dragon" !
	-- 				light = "lotus",
	-- 			},
	-- 		})
	-- 		-- require('kanagawa').load()
	-- 	end,
	-- },
	-- {
	-- 	"bluz71/vim-moonfly-colors",
	-- 	name = "moonfly",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- },
	-- {
	--     "catppuccin/nvim",
	--     name = "catppuccin",
	--     config = function()
	--         require("catppuccin").setup({
	--             flavour = "mocha", -- latte, frappe, macchiato, mocha
	--             term_colors = true,
	--             transparent_background = false,
	--             no_italic = false,
	--             no_bold = false,
	--             styles = {
	--                 comments = {},
	--                 conditionals = {},
	--                 loops = {},
	--                 functions = {},
	--                 keywords = {},
	--                 strings = {},
	--                 variables = {},
	--                 numbers = {},
	--                 booleans = {},
	--                 properties = {},
	--                 types = {},
	--             },
	--             color_overrides = {
	--                 -- mocha = {
	--                 -- 	base = "#000000",
	--                 -- 	mantle = "#000000",
	--                 -- 	crust = "#000000",
	--                 -- },
	--                 -- all = {
	--                 -- 	-- nordic colors
	--                 -- 	base = "#2e3440",
	--                 -- 	mantle = "#3b4252",
	--                 -- 	crust = "#434c5e",
	--                 -- },
	--             },
	--             -- highlight_overrides = {
	--             -- 	mocha = function(C)
	--             -- 		return {
	--             -- 			TabLineSel = { bg = C.pink },
	--             -- 			CmpBorder = { fg = C.surface2 },
	--             -- 			Pmenu = { bg = C.none },
	--             -- 			TelescopeBorder = { link = "FloatBorder" },
	--             -- 		}
	--             -- 	end,
	--             -- },
	--         })
	--
	--         -- vim.cmd.colorscheme("catppuccin")
	--     end,
	-- },
	{
		"navarasu/onedark.nvim",
		config = function()
			-- Lua
			require("onedark").setup({
				-- Main options --
				style = "light", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
				transparent = false, -- Show/hide background
				term_colors = true, -- Change terminal color as per the selected theme style
				ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
				cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

				-- toggle theme style
				toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
				toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

				-- Change code style ---
				-- Options are italic, bold, underline, none
				-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
				code_style = {
					comments = "italic",
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},

				-- Lualine options --
				lualine = {
					transparent = false, -- lualine center bar transparency
				},

				-- Custom Highlights --
				colors = {}, -- Override default colors
				highlights = {}, -- Override highlight groups

				-- Plugins Config --
				diagnostics = {
					darker = true, -- darker colors for diagnostic
					undercurl = true, -- use undercurl instead of underline for diagnostics
					background = true, -- use background color for virtual text
				},
			})
		end,
	},
}
