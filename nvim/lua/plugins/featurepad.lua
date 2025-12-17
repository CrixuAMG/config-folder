return {
    "crixuamg/featurepad.nvim",
    config = function()
        require("featurepad").setup({
            base_dir = "~/features",
        })
    end
}
