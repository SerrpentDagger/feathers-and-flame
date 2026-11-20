-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.expandtab = false -- Stupid spaces
opt.formatoptions:remove({ "o", "r" }) -- No auto comment-continuation.

vim.filetype.add({ extension = { scajl = "scajl" } })
