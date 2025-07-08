vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local function opts(desc)
	return { noremap = true, silent = true, desc = desc }
end

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts("Delete character without copying into register"))

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts("Scroll down and center"))
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts("Scroll up and center"))

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts("Resize up"))
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts("Resize down"))
vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", opts("Resize left"))
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", opts("Resize right"))

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts("Next buffer"))
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts("Previous buffer"))
vim.keymap.set("n", "<leader>bx", ":bdelete!<CR>", opts("Close current buffer"))
vim.keymap.set("n", "<leader>bo", "<cmd> enew <CR>", opts("New buffer"))

-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", opts("Vertical window split")) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", opts("Horizontal window split")) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts("Equalize window split width")) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", ":close<CR>", opts("Close current window")) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts("Switch split above"))
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts("Switch to split below"))
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts("Switch to left split"))
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts("Switch to right split"))

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts("Open new tab")) -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts("Close current tab")) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts("Next tab")) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts("Previous tab")) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts("Toggle line wrapping"))

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts("Indent right"))
vim.keymap.set("v", ">", ">gv", opts("Indent left"))

-- Move selected text up
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", opts("Move selection up"))

-- Move selected text down
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", opts("Move selection down"))

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts("Paste (keep last yanked value)"))

-- Replace word under cursor
vim.keymap.set("n", "<leader>j", "*``cgn", opts("Replace word under cursor"))

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts("Yank selected to system clipboard"))
vim.keymap.set("n", "<leader>Y", [["+Y]], opts("Yank entire line to system clipboard"))

-- Configuration file
vim.keymap.set("n", "<leader>cc", ":edit ~/.config/nvim<CR>", { desc = "Open configuration folder for NVIM" })
