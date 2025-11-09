local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local inlay = require("foyez.utils.inlay_hints")
local tabufline = require("foyez.utils.tabufline")

-- ========================================================================
-- 🏠 General
-- ========================================================================

map({ "n", "v" }, "x", '"_x', { desc = "Delete a character (no yank)" })
map("v", "p", '"_dP', { desc = "Paste without overwriting register (visual mode)" })
-- map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
-- map({ "n", "v" }, "<leader>c", '"_c', { desc = "Change without yanking" })
-- map({ "n", "v" }, "<leader>x", '"_x', { desc = "Delete character without yanking" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-a>", "gg<S-v>G", { desc = "select entire file"})
map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })

-- Toggle wrap line
map("n", "<leader>w", ":set wrap!<CR>", { noremap = true, silent = true })

-- Toggle inlay hints
map("n", "<leader>h", inlay.toggle, { desc = "Toggle Inlay Hints" })

-- ========================================================================
-- 🔢 Numbers
-- ========================================================================

-- Increment/decrement numbers
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })


-- ========================================================================
-- 🪟 Window Management
-- ========================================================================

-- Split windows
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize split sizes" })
map("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

-- Move splits with Alt + hjkl
map("n", "<M-h>", "<C-w>H", { desc = "Move split far left" })
map("n", "<M-l>", "<C-w>L", { desc = "Move split far right" })
map("n", "<M-k>", "<C-w>K", { desc = "Move split to top" })
map("n", "<M-j>", "<C-w>J", { desc = "Move split to bottom" })


-- ========================================================================
-- 🗂 Tabs
-- ========================================================================

map("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
map("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })


-- ========================================================================
-- 🌳 File Explorer (nvim-tree)
-- ========================================================================

map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
-- map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Find file in explorer" })
map("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
map("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })


-- ========================================================================
-- 🖥 Terminal
-- ========================================================================

-- Exit terminal mode with <Esc>
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- tabufline
map("n", "<TAB>", tabufline.next, { desc = "Next buffer" })
map("n", "<S-TAB>", tabufline.prev, { desc = "Prev buffer" })
map("n", "<leader>x", tabufline.close_buffer, { desc = "Close buffer" })
map("n", "<leader>kw", tabufline.close_all, { desc = "Close all buffers" })
map("n", "<leader>ko", tabufline.close_others, { desc = "Close other buffers" })