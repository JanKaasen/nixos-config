return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false,
            })
            vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
            vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
            vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>")
            vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>")
        end
    },
}
