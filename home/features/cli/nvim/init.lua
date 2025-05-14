require('options.vim-options')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
  {
    { import = 'plugins' },
    { import = 'color' },
    { import = 'debuggers' },
    { import = 'formatters' },
    { import = 'lspconfig' },
  },
  {
    rocks = { enabled = false },
    lockfile = vim.fn.expand("~/personal/nix-config/home/features/cli/nvim/lazy-lock.json"),
    change_detection = {
      notify = false,
    },
  })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
