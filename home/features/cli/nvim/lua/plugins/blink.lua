return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets' },
	version = '1.*',
	opts = {
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
		},
		keymap = {
			preset = 'default',
			['<C-l>'] = { 'snippet_forward' },
			['<C-h>'] = { 'snippet_backward' },
		},
	},
	opts_extend = { "sources.default" }
}
