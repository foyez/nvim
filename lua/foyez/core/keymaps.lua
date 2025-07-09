vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set('i', 'jk', '<Esc>')
keymap.set('i', '<C-u>', '<Esc>viwUea')

keymap.set('n', '<leader>nh', ':nohl<CR>')

keymap.set('n', 'x', '"_x')

keymap.set('n', '<leader>+', '<C-a>')
keymap.set('n', '<leader>-', '<C-x>')

keymap.set('n', '<leader>sv', '<C-w>v')
keymap.set('n', '<leader>sh', '<C-w>s')
keymap.set('n', '<leader>se', '<C-w>=')
keymap.set('n', '<leader>sx', ':close<CR>')

keymap.set('n', '<leader>to', ':tabnew<CR>')
keymap.set('n', '<leader>tx', ':tabclose<CR>')
keymap.set('n', '<leader>tn', ':tabn<CR>')
keymap.set('n', '<leader>tp', ':tabp<CR>')

keymap.set('n', '<leader>sm', ':MaximizerToggle<CR>')

keymap.set('n', '<leader>ee', '<cmd>NvimTreeToggle<CR>')
keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>')
keymap.set('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>')
keymap.set('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>')

-- Exit terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fr', builtin.oldfiles)
vim.keymap.set('n', '<leader>fs', builtin.live_grep)
vim.keymap.set('n', '<leader>fc', builtin.grep_string)
