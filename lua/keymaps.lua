local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true, expr = false }

-- Leader key
vim.g.mapleader = " "
map("n", "<Space>", "", {})

-- Telescope
map("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
map("n", "<C-p>", '<cmd>lua require("telescope.builtin").git_files()<cr>', opts)
map(
	"n",
	"<leader>fF",
	'<cmd>lua require("telescope.builtin").find_files({ hidden = true, no_ignore = true })<cr>',
	opts
)
map("n", "<leader>ft", '<cmd>lua require("telescope.builtin").treesitter()<cr>', opts)
map("n", "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
map("n", "<leader>fb", '<cmd>lua require "telescope".extensions.file_browser.file_browser()<cr>', opts)
map("n", "<leader>fB", '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)

map("n", "<silent>[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
map("n", "<silent>]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)

-- buffer
map("n", "<leader>w", ":bd<cr>", opts)
map("n", "<leader>t", ":enew<cr>", opts)
map("n", "<leader>h", ":bp<cr>", opts)
map("n", "<leader>l", ":bn<cr>", opts)

-- Display errors with lsp_lines
map("n", "<leader>z", '<cmd>lua require("lsp_lines").toggle()<cr>', opts)

-- Float Term
map("n", "<C-t>", '<cmd>lua require("FTerm").toggle()<cr>', opts)
map("t", "<C-t>", '<cmd>lua require("FTerm").toggle()<cr>', opts)

-- doc on K
map("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)

map("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
-- preview def
map("n", "gp", "<cmd>Lspsaga preview_definition<cr>", opts)
-- rename
map("n", "gr", "<cmd>Lspsaga rename<cr>", opts)
-- code action
map("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts)
map("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<cr>", opts)
-- scroll in doc or scroll in definition preview
map("n", "<C-f>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<cr>', opts)
map("n", "<C-b>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<cr>', opts)

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<A-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<A-u>", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<A-i>", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<A-o>", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<A-p>", function()
	ui.nav_file(4)
end)
