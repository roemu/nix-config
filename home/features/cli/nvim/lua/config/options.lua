vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.breakindent = true
vim.o.hlsearch = false
vim.o.mouse = 'a'
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 4
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.wo.number = true
vim.wo.signcolumn = 'yes'

vim.filetype.add({
	extension = {
		['bru'] = 'bru',
	}
})

vim.diagnostic.config({
	-- virtual_lines = { current_line = true }
	virtual_text = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
