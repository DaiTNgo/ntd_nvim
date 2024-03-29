local opts = { noremap = true, silent = false }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
-------------------------------------

-- TAB Complete
keymap("i", "<expr><TAB>", 'pumvisible() ? "\\<C-n>" : "\\<TAB>"', { noremap = true, silent = true })
keymap("n", "m", "%", { noremap = true, silent = true })
-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
--keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
--keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
keymap("n", "<C-c>", "<ESC>", opts)
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
keymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

keymap("t", "<C-\\>", "<cmd>ToggleTermToggleAll<cr>", opts)
keymap("n", "<C-\\>", "<cmd>ToggleTermToggleAll<cr>", opts)

-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
-- keymap(
-- 	"n",
-- 	"<leader>f",
-- 	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
-- 	opts
-- )
-- keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)
-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<S-f>", ":Format<cr>", opts)
--split
keymap("n", "<C-x>", ":vsplit<cr>", opts)
-- quit
keymap("n", "<leader>q", "<cmd>q<cr>", opts)
-- buffers
keymap("n", "<C-s>", "<cmd>w<cr>", opts)

keymap("n", "<C-q>", "<cmd>Bdelete!<cr>", opts)
keymap("n", "<leader>r", "<cmd>NvimTreeRefresh<cr>", opts)
