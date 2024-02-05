return {
        "lukas-reineke/indent-blankline.nvim",
        main = 'ibl',
        enabled = false,
        config = function ()
                require("ibl").setup({
                        exclude = {
                                filetypes = {
                                        "dashboard"
                                },
                                buftypes = {
                                        "terminal",
                                }
                        }
                })
        end
}
