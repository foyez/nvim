local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- ========================================================================
-- 🏠 General
-- ========================================================================

-- Delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "Delete character (no yank)" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- ========================================================================
-- 🔢 Numbers
-- ========================================================================

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })


-- ========================================================================
-- 🪟 Window Management
-- ========================================================================

-- Split windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize split sizes" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

-- Toggle maximize (plugin handled in lazy spec for vim-maximizer)
-- keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Maximize split" })


-- ========================================================================
-- 🗂 Tabs
-- ========================================================================

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })


-- ========================================================================
-- 🌳 File Explorer (nvim-tree)
-- ========================================================================

keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Find file in explorer" })
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })


-- ========================================================================
-- 🔍 Telescope
-- ========================================================================

local builtin = require("telescope.builtin")

keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Search in files" })
keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Search word under cursor" })


-- ========================================================================
-- 🖥 Terminal
-- ========================================================================

-- Exit terminal mode with <Esc>
keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
