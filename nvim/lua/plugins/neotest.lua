return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "olimorris/neotest-phpunit",
        },
        keys = {
            { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
            { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
            { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
            { "<leader>to", function() require("neotest").output.open() end, desc = "Open test output" },
            { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
            { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop test" },
            { "[t", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Jump to previous failed test" },
            { "]t", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Jump to next failed test" },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-phpunit")({
                        phpunit_cmd = function()
                            -- Determine the project root directory
                            local project_root = vim.fn.getcwd()

                            if string.find(project_root, "/var/www/html/brand-websites") then
                                return "bin/phpunit-all"
                            else
                                return "bin/phpunit"
                            end
                        end,
                        filter_dirs = { "vendor" }
                    })
                }
            })
        end
    }
}
