vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.lsp.config.ts_ls = {
	cmd = { 'typescript-language-server', '--stdio' },
	root_markers = { 'package.json' },
	filetypes = { 'ts', 'typescript' },
}

vim.lsp.config.angular_ls = {
	cmd = { 'ngserver', '--stdio' },
	root_markers = { 'angular.json' },
	filetypes = { 'ts', 'typescript', 'html', 'angular' },
}

vim.lsp.config.lua_ls = {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = {
		'.luarc.json',
		'.luarc.jsonc',
		'.luacheckrc',
		'.stylua.toml',
		'stylua.toml',
		'selene.toml',
		'selene.yml',
	},
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

vim.lsp.config.clangd_ls = {
	cmd = { 'clangd', '--background-index' },
	root_markers = { 'compile_commands.json', 'compile_flags.txt' },
	filetypes = { 'c', 'cpp' },
}

vim.lsp.config.nil_ls = {
	cmd = { 'nil' },
	filetypes = { 'nix' },
}

vim.lsp.config.helm_ls = {
	cmd = { 'helm_ls', 'serve' },
	filetypes = { 'helm', 'helmfile' },
	root_markers = { 'Chart.yaml' },
	settings = {
		['helm-ls'] = {
			yamlls = {
				path = 'yaml-language-server'
			}
		}
	},
}

vim.lsp.config.yaml_ls = {
	cmd = { 'yaml-language-server', '--stdio' },
	filetypes = { 'yaml', 'yml' },
}

vim.lsp.config.openscad_ls = {
	cmd = { 'openscad-lsp', '--stdio' },
	filetypes = { 'scad', 'openscad' },
}

vim.lsp.config.gopls = {
	cmd = { 'gopls' },
	filetypes = { 'go' },
}

vim.lsp.config.bash_ls = {
	cmd = { 'bash-language-server', 'start' },
	filetypes = { 'bash', 'sh' },
}
vim.lsp.config.emmet_ls = {
	cmd = { 'emmet-ls', '--stdio' },
	filetypes = { 'html', 'angular', 'scss', 'css' },
}

vim.lsp.config('*', {
	root_markers = { '.git' },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
})
vim.lsp.enable({ 'emmet_ls', 'bash_ls', 'gopls', 'openscad_ls', 'yaml_ls', 'helm_ls', 'clangd_ls', 'nil_ls', 'lua_ls',
	'ts_ls', 'angular_ls' })

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
			-- opts = {
			-- 	inlay_hints = { enabled = true }
			-- },
		},
		{ 'j-hui/fidget.nvim', lazy = true, opts = {} },
	},
}
