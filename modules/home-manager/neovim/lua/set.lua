local nnoremap = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, { noremap = true })
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"
vim.cmd.colorscheme "catppuccin-mocha"

vim.keymap.set('n', '<C-h>', '<C-w>h', {})
vim.keymap.set('n', '<C-j>', '<C-w>j', {})
vim.keymap.set('n', '<C-k>', '<C-w>k', {})
vim.keymap.set('n', '<C-l>', '<C-w>l', {})

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.termguicolors = true

nnoremap("<C-d", "<C-d>zz")
nnoremap("<C-u", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
