local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local inlay = require("foyez.utils.inlay_hints")

-- ========================================================================
-- 🏠 General
-- ========================================================================

-- Delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "Delete character (no yank)" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Toggle wrap line
keymap.set("n", "<leader>w", ":set wrap!<CR>", { noremap = true, silent = true })

-- Toggle inlay hints
keymap.set("n", "<leader>h", inlay.toggle, { desc = "Toggle Inlay Hints" })

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

-- Move splits with Alt + hjkl
keymap.set("n", "<M-h>", "<C-w>H", { desc = "Move split far left" })
keymap.set("n", "<M-l>", "<C-w>L", { desc = "Move split far right" })
keymap.set("n", "<M-k>", "<C-w>K", { desc = "Move split to top" })
keymap.set("n", "<M-j>", "<C-w>J", { desc = "Move split to bottom" })


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
-- 🖥 Terminal
-- ========================================================================

-- Exit terminal mode with <Esc>
keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
