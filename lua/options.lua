local g = vim.g
local opt = vim.opt
local hl = vim.api.nvim_set_hl

opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.showmode = false
opt.signcolumn = "yes"
opt.updatetime = 300
opt.shortmess:append "c"

opt.completeopt = "menuone,noinsert,noselect"

opt.smartindent = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

opt.hlsearch = false
g.netrw_banner = 0

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
    signs = true
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
opt.termguicolors = true

vim.api.nvim_create_autocmd("BufWritePre", { command = "lua require('go.format').gofmt()", pattern = "*.go" })
