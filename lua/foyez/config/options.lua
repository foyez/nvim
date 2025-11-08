local opt = vim.opt

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- UI/Display
opt.relativenumber = true
opt.number = true
opt.title = true
opt.scrolloff = 10 -- Keep 10 lines visible above/below cursor
opt.virtualedit = "onemore"
opt.wrap = false
opt.mouse = "" -- Disable mouse support
opt.winminheight = 0
opt.winminwidth = 0
-- Hide trailing ~ lines (end-of-buffer) globally (also affects NvimTree)
-- This makes the empty area after the end of file appear blank
opt.fillchars = { eob = " " }

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = false -- Convert tabs to spaces
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.breakindent = true -- Wrapped lines keep indentation

-- Search
opt.hlsearch = true -- Highlight matches
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Allow backspace over indentation, end of line, and start of insert
opt.backspace = { "start", "eol", "indent" }

opt.clipboard:append("unnamedplus")

-- Split
opt.splitright = true -- Vertical splits open to the right
opt.splitbelow = true -- Horizontal splits open below
