return {
    "nvim-neorg/neorg",
    run = ":Neorg sync-parsers", -- This is the important bit!
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {}
            }
        }
    end,
}
