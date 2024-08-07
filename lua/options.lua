vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")
vim.opt.clipboard = "unnamedplus"

vim.opt.completeopt = "menuone,noinsert,noselect"

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.hlsearch = false
vim.g.netrw_banner = 0

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = true,
	signs = true,
})

-- relative on normal mode only
vim.api.nvim_create_autocmd("InsertEnter", { command = "set norelativenumber", pattern = "*" })
vim.api.nvim_create_autocmd("InsertLeave", { command = "set relativenumber", pattern = "*" })

-- Diagnostics symbols
vim.cmd("sign define DiagnosticSignError text= texthl=DiagnosticSignError")
vim.cmd("sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn")
vim.cmd("sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo")
vim.cmd("sign define DiagnosticSignHint text= texthl=DiagnosticSignHint")

-- Colorscheme
vim.cmd("colorscheme kanagawa")
vim.opt.termguicolors = true

vim.api.nvim_create_autocmd("BufWritePre", { command = "lua require('go.format').gofmt()", pattern = "*.go" })
