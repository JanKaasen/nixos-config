return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim",
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-fzf-native.nvim'

    },

    config = function()
        require('telescope').setup({
            defaults = {
                layout_config = {
                    prompt_position = "top",
                },
                winblend = 0,
            }
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'find files' })
        vim.keymap.set('n', '<leader>pt', vim.cmd.TodoTelescope, { desc = 'find todo' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'git files' })
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = 'search word' })
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = 'search entire string' })
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = 'search with grep' })
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = 'search help' })
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
    end
}
