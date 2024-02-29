local keymap = vim.keymap

local opts = { noremap = true, silent = true }

-- Directory navigation
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Pane navigation
keymap.set("n", "<C-h>", "<C-w>h", opts) -- Navigate left
keymap.set("n", "<C-j>", "<C-w>j", opts) -- Navigate down
keymap.set("n", "<C-k>", "<C-w>k", opts) -- Navigate up
keymap.set("n", "<C-l>", "<C-w>l", opts) -- Navigate right

-- Window management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split vertically
keymap.set("n", "<leader>sh", ":split<CR>", opts) -- Split horizontally
keymap.set("n", "<leader>se", "<C-w>=", opts) -- Make windows equal size
keymap.set("n", "<leader>sx", ":close<CR>", opts) -- Close current window
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Toggle minimize

-- Indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")
