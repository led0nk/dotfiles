vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set splitright")
vim.cmd("set splitbelow")
vim.cmd("set relativenumber")
vim.g.mapleader = " "

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

--Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- Window Split
vim.keymap.set("n", "<leader>wv", ":vsp<CR>")
vim.keymap.set("n", "<leader>wh", ":sp<CR>")
vim.keymap.set("n", "<leader>wq", "<C-w>q")

-- Navigate Buffers
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")

-- Insert New Line without entering insert Mode
vim.keymap.set("n", "<leader>o", "o<ESC>")

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
