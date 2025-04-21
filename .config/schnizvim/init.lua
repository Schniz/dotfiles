-- set the leader to ,
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.g.lumen_light_colorscheme = "base16-github"
vim.g.lumen_dark_colorscheme = "base16-eighties"

local previous_print = print
PRINT_TRACE = function(v)
  -- get traceback
  local traceback = debug.traceback()
  previous_print(vim.inspect(v) .. "\n" .. traceback)
end

require("basic_keymaps")
require("global_settings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
