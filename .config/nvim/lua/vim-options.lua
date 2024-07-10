-- Global opts
vim.opt.clipboard = "unnamedplus"

vim.opt.mouse = "a"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Save undo history
vim.opt.undofile = true

-- TODO: wtf is that
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Keep signcolumn on by default (col with errs at left)
vim.opt.signcolumn = "yes"

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Set updatetime (cursorhold, hints, etc)
vim.opt.updatetime = 100

-- Show matching paterns as you type
vim.opt.inccommand = "split"

-- UI : Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.opt.number = true
vim.opt.fillchars = { eob = " " }

-- Code formatting and tab
vim.opt.expandtab = true -- TODO: <-
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
--vim.opt.formatoptions = "" TODO: <-

vim.opt.wrap = false

-- Shortcuts-opts
vim.keymap.set("n", "<leader>b", ":NvimTreeToggle<CR>", {}) --TODO: <-
-- vim.keymap.set("n", "<leader>b", ":Neotree", {})

-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.cmd("command! WQ wa | qa")

vim.api.nvim_create_user_command("Dterm", function()
	vim.cmd("vertical terminal")
	vim.cmd("wincmd J")
	vim.cmd("wincmd 99 -")
	vim.cmd("wincmd 7 +")
	vim.cmd("vertical terminal")
end, {})

vim.api.nvim_create_user_command("Tab", function()
	vim.cmd("vertical new")
end, {})

--vim.keymap.set('i', '<C-Tab>', '<Plug>(copilot-accept-word)')
vim.keymap.set("t", "<c-w>", "<c-\\><c-n><c-w>")
