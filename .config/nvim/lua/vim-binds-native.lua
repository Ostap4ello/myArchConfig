-- Binds-and-commands

-- Open NvimTree
vim.keymap.set("n", "<leader>b", ":NvimTreeToggle<CR>", {desc="Toggle Nvim Tree"})
-- Escape terminal mode bind
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- Save and quit ALL
vim.cmd("command! WQ wa | qa")

vim.api.nvim_create_user_command("Dterm", function()
	vim.cmd("vertical terminal")
	vim.cmd("wincmd J")
	vim.cmd("wincmd 99 -")
	vim.cmd("wincmd 7 +")
	vim.cmd("vertical terminal")
end, {})

-- vim.api.nvim_create_user_command("Tab", function()
-- 	vim.cmd("vertical new")
-- end, {})

-- themes
vim.api.nvim_create_user_command("ThemeWhite", function()
    vim.cmd("colorscheme shine")
    vim.cmd("colorscheme wildcharm")
end, {} )
vim.api.nvim_create_user_command("ThemeBlack", function()
    vim.cmd("colorscheme darkblue")
    vim.cmd("colorscheme oxocarbon")
end, {} )

--vim.keymap.set('i', '<C-Tab>', '<Plug>(copilot-accept-word)')
vim.keymap.set("t", "<c-w>", "<c-\\><c-n><c-w>")

--Alt + T to open terminal in a new tab
vim.keymap.set({ "n", "v" }, "<leader>T", ":tabnew<CR>:terminal<CR>")
-- Alt + t to move to the next tab
vim.keymap.set({ "n", "v" }, "<A-t>", "<c-w>T")
vim.keymap.set("t", "<A-t>", "<c-\\><c-n><c-w>T")
-- Alt + Arrows to move focus between windows in normal, terminal and visual mode
vim.keymap.set({ "n", "v" }, "<A-down>", "<c-w><down>")
vim.keymap.set({ "n", "v" }, "<A-left>", "<c-w><left>")
vim.keymap.set({ "n", "v" }, "<A-right>", "<c-w><right>")
vim.keymap.set({ "n", "v" }, "<A-up>", "<c-w><up>")

vim.keymap.set("t", "<A-down>", "<c-\\><c-n><c-w><down>")
vim.keymap.set("t", "<A-left>", "<c-\\><c-n><c-w><left>")
vim.keymap.set("t", "<A-right>", "<c-\\><c-n><c-w><right>")
vim.keymap.set("t", "<A-up>", "<c-\\><c-n><c-w><up>")

-- Alt + Ctrl + Arrows to resize windows in normal, terminal and visual mode
vim.keymap.set({ "n", "v" }, "<A-C-down>", ":resize -10<CR>")
vim.keymap.set({ "n", "v" }, "<A-C-left>", ":vertical resize -16<CR>")
vim.keymap.set({ "n", "v" }, "<A-C-right>", ":vertical resize +16<CR>")
vim.keymap.set({ "n", "v" }, "<A-C-up>", ":resize +10<CR>")

vim.keymap.set("t", "<A-C-down>", "<c-\\><c-n> :resize -10<CR>")
vim.keymap.set("t", "<A-C-left>", "<c-\\><c-n><c-w><left> :vertical resize -16<CR>")
vim.keymap.set("t", "<A-C-right>", "<c-\\><c-n><c-w><right> :vertical resize +16<CR>")
vim.keymap.set("t", "<A-C-up>", "<c-\\><c-n><c-w><up> :resize +10<CR>")

