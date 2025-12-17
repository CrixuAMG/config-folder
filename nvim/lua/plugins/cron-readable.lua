return {
  "crixuamg/cron-readable.nvim",
  config = function()
    require("cron-readable").setup({
        pattern = { "*.yaml", "*.yml" }, -- File patterns to match
        filename = nil, -- Optional: specific filename to match
    })
  end,
}
