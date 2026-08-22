-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Autoformat setting
local set_autoformat = function(pattern, bool_val)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = pattern,
    callback = function()
      vim.b.autoformat = bool_val
    end,
  })
end

set_autoformat({ "cpp" }, false)
set_autoformat({ "java" }, false)
set_autoformat({ "json" }, false)
set_autoformat({ "fish" }, false)
set_autoformat({ "lua" }, false)
set_autoformat({ "perl" }, false)
set_autoformat({ "yaml" }, false)
set_autoformat({ "py" }, false)

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*",
	callback = function()
		vim.opt.expandtab = false -- Stupid Spaces!!!! >:(
	end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "java",
	callback = function()
		vim.bo.indentkeys = vim.bo.indentkeys:gsub(",?0{,?", "")
	end
})
