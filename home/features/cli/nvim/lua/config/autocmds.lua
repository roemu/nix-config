vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	pattern = '*',
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'TelescopeResults',
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd('TelescopeParent', '\t\t.*$')
			vim.api.nvim_set_hl(0, 'TelescopeParent', { link = 'Comment' })
		end)
	end,
})

vim.cmd(':au BufRead,BufEnter *.component.html set filetype=htmlangular')
