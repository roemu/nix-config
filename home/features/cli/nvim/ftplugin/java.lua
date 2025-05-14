local jdtls = require("jdtls")
local jdtls_dap = require("jdtls.dap")
local jdtls_setup = require("jdtls.setup")
local home = os.getenv("HOME")

vim.opt.tabstop = 4;
vim.opt.shiftwidth = 4;
vim.opt.expandtab = true;

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers)

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name
local lsp = require("vim.lsp")

function mk_config()
	local capabilities = lsp.protocol.make_client_capabilities()
	capabilities.workspace.configuration = true
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	return {
		flags = {
			allow_incremental_sync = true,
		},
		handlers = {},
		capabilities = capabilities,
		init_options = {},
		settings = {},
	}
end

function archConfigName()
	local jit = require("jit")

	if jit.os == 'OSX' and (jit.arch == 'arm64' or jit.arch == 'arm' ) then
		return "config_mac_arm"
	elseif jit.os == 'Linux' then
		return "config_linux"
	elseif jit.os == 'Windows' then
		return "config_win"
	end
end

local config = mk_config();
config.settings = {
	java = {
		references = {
			includeDecompiledSources = true,
		},
		format = {
			enabled = true,
			settings = {
				url = home .. "/.config/nvim/lua/lspconfig/intellij-java-google-style.xml",
				profile = "GoogleStyle",
			},
		},
		eclipse = {
			downloadSources = true,
		},
		maven = {
			downloadSources = true,
		},
		signatureHelp = { enabled = true },
		contentProvider = { preferred = "fernflower" },
		completion = {
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
			importOrder = {
				"com",
				"org",
				"java",
				"javax",
				"\\#",
			},
		},
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
		configuration = {
			runtimes = {
				{
					name = "JavaSE-21",
					path = vim.fn.getenv("JAVA_HOME")
				}
			}
		},
		home = vim.fn.getenv("JAVA_HOME")
	},
}

config.cmd = {
	"java",

	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-Xmx1g",
	"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
	"--add-modules=ALL-SYSTEM",
	"--add-opens", "java.base/java.util=ALL-UNNAMED",
	"--add-opens", "java.base/java.lang=ALL-UNNAMED",

	"-jar", vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
	"-configuration", home .. "/.local/share/nvim/mason/packages/jdtls/" .. archConfigName(),
	"-data", workspace_dir,
}

config.on_attach = function(_, _)
	---@diagnostic disable-next-line: missing-fields
	jdtls.setup_dap({ hotcodereplace = "auto" })
	jdtls_dap.setup_dap_main_class_configs()

	vim.keymap.set('n', '<leader>tc', ':lua require("jdtls").test_class()<CR>', { desc = '[T]est: [C]lass' })
	vim.keymap.set('n', '<leader>tm', ':lua require("jdtls").test_nearest_method()<CR>',
		{ desc = '[T]est: [M]ethod' })
	vim.keymap.set('n', '<leader>tl', ':DapToggleRepl<CR>', { desc = "[T]oggle test result [L]ist" })
end

config.on_init = function(client, _)
	if client.config.settings then
		client:notify('workspace/didChangeConfiguration', { settings = client.config.settings })
	end
end

local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {
	vim.fn.glob(home .. "/.local/share/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/.local/share/java/vscode-java-test/server/*.jar'), "\n"))
bundles = vim.tbl_filter(function (bundle)
	return bundle ~= "com.microsoft.java.test.runner-jar-with-dependencies.jar" and bundle ~= "jacocoagent.jar"
end, bundles)

config.init_options = {
	bundles = bundles,
	extendedClientCapabilities = extendedClientCapabilities,
}

config.filetypes = {
	"java"
}

-- Start Server
require('jdtls').start_or_attach(config)
