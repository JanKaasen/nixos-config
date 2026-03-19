return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "rcasia/neotest-java",
    },
    keys = {
        { "<leader>tt", function() require("neotest").run.run() end,                     desc = "Run nearest test" },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand('%')) end,   desc = "Run file" },
        { "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end,      desc = "Run all" },
        { "<leader>ts", function() require("neotest").summary.toggle() end,              desc = "Toggle summary" },
        { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show output" },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-java")({
                    ignore_wrapper = false,
                }),
            },
        })
    end,
}
