vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local function opts(desc)
	return { noremap = true, silent = true, desc = desc }
end

vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts("Save without triggering autocommands"))

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts("Delete character without copying into register"))

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts("Scroll down and center"))
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts("Scroll up and center"))

-- Find and center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts("Resize up"))
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts("Resize down"))
vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", opts("Resize left"))
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", opts("Resize right"))

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts("Next buffer"))
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts("Previous buffer"))
vim.keymap.set("n", "<leader>x", ":Bdelete!<CR>", opts("Close buffer"))
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts("New buffer"))

-- Increment/decrement number
vim.keymap.set("n", "<leader>+", "<C-a>", opts("Increment number"))
vim.keymap.set("n", "<leader>-", "<C-x>", opts("Decrement number"))

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts("Vertical split")) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts("Horizontal split")) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts("Equalize split width")) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts("Close split")) -- close current split window

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

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set("n", "<leader>do", function()
	diagnostics_active = not diagnostics_active

	if diagnostics_active then
		vim.diagnostic.enable(true)
	else
		vim.diagnostic.enable(false)
	end
end)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
