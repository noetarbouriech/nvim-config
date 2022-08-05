local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true, expr = false }

-- Leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

-- Telescope
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
map('n', '<leader>fF', '<cmd>lua require("telescope.builtin").find_files({ hidden = true, no_ignore = true })<cr>', opts)
map('n', '<leader>ft', '<cmd>lua require("telescope.builtin").treesitter()<cr>', opts)
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)

map('n', '<silent>[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
map('n', '<silent>]g', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)

-- change buffer
map('n', '<leader>h', ':bp<cr>', opts)
map('n', '<leader>l', ':bn<cr>', opts)

-- Display errors with lsp_lines
map('n', '<leader>z', '<cmd>lua require("lsp_lines").toggle()<cr>', opts)

-- Float Term
map('n', '<C-t>', '<cmd>lua require("FTerm").toggle()<cr>', opts)
map('t', '<C-t>', '<cmd>lua require("FTerm").toggle()<cr>', opts)

-- doc on K
map("n", "K", '<cmd>lua require("lspsaga.hover").render_hover_doc()<cr>', opts)
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
