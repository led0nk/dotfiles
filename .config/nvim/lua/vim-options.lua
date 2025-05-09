-- Set leaderkey
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.opt.conceallevel = 1

-- Set tabs to 2 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Enable auto indenting and set it to spaces
vim.opt.smartindent = true
vim.opt.shiftwidth = 2

-- Enable smart indenting
vim.opt.breakindent = true

-- Better splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable sign column
vim.opt.signcolumn = "yes"

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Enable access to system clipboard
vim.opt.clipboard = "unnamed,unnamedplus"

-- Enable cursor line highlight
vim.opt.cursorline = false
vim.opt.termguicolors = true

-- Set scrolling offset
vim.opt.scrolloff = 10

-- Set a column line
vim.opt.colorcolumn = "80"

-- Save Files
vim.keymap.set("n", "<C-s>", ":update<CR>")
vim.keymap.set("i", "<C-s>", "<ESC>:update<CR>")
vim.keymap.set("v", "<C-s>", ":update<CR>")

-- Resize
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- General Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

--Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- Window Split
vim.keymap.set("n", "<leader>wv", ":vsp<CR>", { desc = "vertical split" })
vim.keymap.set("n", "<leader>wh", ":sp<CR>", { desc = "horizontal split" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "close window" })

-- Navigate Buffers
vim.keymap.set("n", "<A-l>", ":bnext<CR>", { desc = "next buffer" })
vim.keymap.set("n", "<A-h>", ":bprevious<CR>", { desc = "previous buffer" })
vim.keymap.set("n", "<leader>bk", ":bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "kill buffer" })

-- Open Terminal in Vsplit
vim.keymap.set("n", "<leader>tv", ":vsp | terminal<CR>i", { desc = "Open terminal in vertical split" })
vim.keymap.set("n", "<leader>th", ":sp | terminal<CR>i", { desc = "Open terminal in horizontal split" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })

-- Insert New Line without entering insert Mode
vim.keymap.set("n", "<leader>o", "o<ESC>")

-- Diagnostic keymap
vim.keymap.set("n", "<leader>fd", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<C-n>", ":cnext<CR>zz", { desc = "next quickfix" })
vim.keymap.set("n", "<C-p>", ":cprev<CR>zz", { desc = "previous quickfix" })

-- INSERT MODE

-- Insert to Normal Mode
vim.keymap.set("i", "jk", "<ESC>")

-- VISUAL MODE

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move text up and Down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "p", '"_dP')

-- some additional stuff
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "<ESC>", ":noh<CR>")

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25
vim.g.netrw_banner = 0
