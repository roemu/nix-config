vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', 'n', '    nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-t>', '<Nop>')
vim.keymap.set('i', '<M-u>','<C-v>u0308<Esc>a')
vim.keymap.set({ 'n', 't', 'v' }, 's', '<Nop>')
vim.keymap.set({ 'n', 't', 'v' }, 'S', '<Nop>')

vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end,
	{ desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '[c', '<cmd>cprev<CR>', { desc = 'Go to previous quickfix item' })
vim.keymap.set('n', ']c', '<cmd>cnext<CR>', { desc = 'Go to next quickfix item' })
vim.keymap.set('n', '<leader>el', vim.diagnostic.setloclist, { desc = '[E]rror [L]ist' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<C-w>v', ":belowright vsplit<CR>")
vim.keymap.set('n', '<C-w>n', ":belowright split<CR>")
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
