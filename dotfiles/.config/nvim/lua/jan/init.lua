require("jan.set")
require("jan.remap")
require("jan.lazy_init")

local augroup = vim.api.nvim_create_augroup
local jan = augroup('jan', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    group = jan,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Goto definition" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "LSP: hover" })
        vim.keymap.set("n", "<leader>cw", function() vim.lsp.buf.workspace_symbol() end, { desc = "LSP: Show workspace symbols" })
        vim.keymap.set("n", "<leader>cd", function() vim.diagnostic.open_float() end,
            { desc = "LSP: Open diagnostic float" })
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "LSP: Code Action" })
        vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, { desc = "LSP: Show references" })
        vim.keymap.set("n", "<leader>cn", function() vim.lsp.buf.rename() end, { desc = "LSP: Rename" })
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, { desc = "LSP: Show signature help" })
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, { desc = "Goto next error" })
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, { desc = "Goto prev error" })
    end
})
