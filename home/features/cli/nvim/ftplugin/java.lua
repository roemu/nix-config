local jdtls = require('jdtls');
local jdtls_dap = require('jdtls.dap');

local jdtls_install = vim.fn.expand("$MASON/packages/jdtls")
local lombok_path = jdtls_install .. "/lombok.jar"

local function jdtls_on_attach(_, _)
	vim.keymap.set('n', '<leader>tc', ':lua require("jdtls").test_class()<CR>', { desc = '[T]est: [C]lass' })
	vim.keymap.set('n', '<leader>tm', ':lua require("jdtls").test_nearest_method()<CR>',
		{ desc = '[T]est: [M]ethod' })
	vim.keymap.set('n', '<leader>tl', ':DapToggleRepl<CR>', { desc = "[T]oggle test result [L]ist" })

	jdtls.setup_dap({ hotcodereplace = "auto" })
	jdtls_dap.setup_dap_main_class_configs()
end

local function get_platform_config()
	if vim.fn.has("mac") == 1 then
		return jdtls_install .. "/config_mac"
	elseif vim.fn.has("unix") == 1 then
		return jdtls_install .. "/config_linux"
	elseif vim.fn.has("win32") == 1 then
		return jdtls_install .. "/config_win"
	end
end

local function get_data_dir()
	local jdtls_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls"
	local data_dir = jdtls_dir .. "/" .. string.gsub(vim.fn.getcwd(), "/", "_")
	return data_dir
end

local function getDebugAndTestBundles()
	local java_debug_path = vim.fn.expand("$MASON/packages/java-debug-adapter")
	local java_test_path = vim.fn.expand("$MASON/packages/java-test")
	local bundles = {
		vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
	}
	vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", true), "\n"))
	return bundles
end

local config = {
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	on_attach = jdtls_on_attach,
	capabilities = require('blink.cmp').get_lsp_capabilities({
		textDocument = { completion = { completionItem = { snippetSupport = true } } },
	}),

	cmd = {
		'java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		"-javaagent:" .. lombok_path,
		"-Xmx12G",
		'--add-modules=ALL-SYSTEM',
		'--add-opens',
		'java.base/java.util=ALL-UNNAMED',
		'--add-opens',
		'java.base/java.lang=ALL-UNNAMED',

		"-jar",
		vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar"),

		'-configuration',
		get_platform_config(),

		'-data',
		get_data_dir(),
	},

	root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	settings = {
		java = {
			autobuild = {
				enabled = false
			},
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "disabled",
			},
			maven = {
				downloadSources = true,
			},
			format = {
				enabled = true,
				settings = {
					url = vim.fn.expand("~/.config/nvim/lua/lspconfig/intellij-java-google-style.xml"),
					profile = "GoogleStyle",
				},
			},
			maxConcurrentBuilds = 2,
			jdt = {
				ls = {
					javac = {
						enabled = "false"
					}
				}
			},
			signatureHelp = {
				enabled = true,
			},
			edit = {
				smartSemicolonDetection = {
					enabled = true,
				}
			},
			saveActions = {
				cleanup = false
			},
			completion = {
				maxResults = 20,
				engine = "dom",
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
				matchCase = "off",
				guessMethodArguments = "insertBestGuessedArguments",
			},
			contentProvider = {
				preferred = "fernflower",
			},
			referencesCodeLens = {
				enabled = true,
			},
			implementationsCodeLens = {
				enabled = true
			}
		}
	},

	init_options = {
		bundles = getDebugAndTestBundles(),
	},
}
require('jdtls').start_or_attach(config)
