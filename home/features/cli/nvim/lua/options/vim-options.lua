vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.swapfile = false

vim.opt.clipboard = "unnamedplus"

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', 'n', '    nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-t>', '<Nop>')
vim.keymap.set({ 'n', 't', 'v' }, 's', '<Nop>')
vim.keymap.set({ 'n', 't', 'v' }, 'S', '<Nop>')

vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end,
	{ desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '[c', '<cmd>cprev<CR>', { desc = 'Go to previous quickfix item' })
vim.keymap.set('n', ']c', '<cmd>cnext<CR>', { desc = 'Go to next quickfix item' })
vim.keymap.set('n', '<leader>el', vim.diagnostic.setloclist, { desc = '[E]rror [L]ist' })
vim.api.nvim_set_keymap("n", "gx", [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]], {})

vim.filetype.add({
	extension = {
		['http'] = 'http',
		['bru'] = 'bru',
	}
})
vim.cmd(':au BufRead,BufEnter *.component.html set filetype=htmlangular')

vim.diagnostic.config({ virtual_lines = { current_line = true } })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<C-w>v', ":belowright vsplit<CR>")
vim.keymap.set('n', '<C-w>n', ":belowright split<CR>")

vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.wo.signcolumn = 'yes'

vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.termguicolors = true

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

-- requires telescope
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'TelescopeResults',
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd('TelescopeParent', '\t\t.*$')
			vim.api.nvim_set_hl(0, 'TelescopeParent', { link = 'Comment' })
		end)
	end,
})
-- end telescope requirement
