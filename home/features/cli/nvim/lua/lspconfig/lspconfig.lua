vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		}
	}
}

vim.lsp.config.helm_ls = {
	filetypes = { 'helm', 'helmfile' },
}

vim.lsp.config.ts_ls = {
	filetypes = { 'htmlangular', 'ts', 'typescript' },
}
vim.lsp.config.clangd = {
	filetypes = { 'arduino', 'c', 'cpp' },
}

vim.lsp.config('*', {
	root_markers = { '.git' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
})
vim.lsp.enable({ 'emmet_ls', 'bashls', 'gopls', 'openscad_lsp', 'yamlls', 'helm_ls', 'clangd', 'nil_ls', 'lua_ls',
	'ts_ls', 'angularls', 'rust_analyzer', 'vacuum' })

return {
	'mason-org/mason-lspconfig.nvim',
	opts = {
		ensure_installed = {
			jdtls = { filetypes = { 'java' } }
		},
		automatic_enable = false,
	},
	dependencies = {
		{ 'mason-org/mason.nvim', opts = {} },
		{
			'neovim/nvim-lspconfig',
		},
		{ 'j-hui/fidget.nvim',    lazy = true, opts = {} },
	},
}
