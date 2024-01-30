return {
    {
        dir = vim.env.VIMRUNTIME .. "/pack/dist/opt/nvim.undotree",
        name = "nvim.undotree",
        keys = {
            { "<leader>u", "<cmd>Undotree<cr>", desc = "Toggle undotree" },
        },
    },
}
