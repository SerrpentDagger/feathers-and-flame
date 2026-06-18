-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set('n', '<leader>mx', function()
	vim.cmd('delmarks!')
end, { desc = 'Clear marks' })

vim.keymap.set('n', '<leader>mX', function()
	vim.cmd('delmarks!')
	vim.cmd('delmarks A-Z')
end, { desc = 'Clear Marks' })

vim.keymap.set('n', 'gh', function()
	vim.lsp.buf.typehierarchy('subtypes')
end, { desc = 'Type Hierarchy Subtypes' })

vim.keymap.set('n', 'gH', function()
	vim.lsp.buf.typehierarchy('supertypes')
end, { desc = 'Type Hierarchy Supertypes' })
