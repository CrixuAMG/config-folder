return {
  'mistweaverco/snap.nvim',
  opts = {
    timeout = 5000, -- Timeout for screenshot command in milliseconds
    templateFilepath = nil, -- Absolute path to a custom handlebars template file (optional)
    -- Additional data to pass to the your custom handlebars template (optional)
    additional_template_data = {
      author = "Your Name",
      website = "https://yourwebsite.com",
    },
    output_dir = "$HOME/Pictures/Screenshots", -- Directory to save screenshots
    filename_pattern = "snap.nvim_%t.png", -- e.g., "snap.nvim_%t.png" (supports %t for timestamp)
    font_settings = {
      size = 14,         -- Default font size for the screenshot
      line_height = 0.8, -- Default line height for the screenshot
      default = {
        name = "FiraCode Nerd Font", -- Default font name for the screenshot
        file = nil,         -- Absolute path to a custom font file (.ttf) (optional)
        -- Only needed if the font is not installed system-wide
        -- or if you want to export as HTML with the font embedded
        -- so you can view it correctly in E-mails or browsers
      },
      -- Optional font settings for different text styles (bold, italic, bold_italic)
      bold = {
        name = "FiraCode Nerd Font", -- Font name for bold text
        file = nil,         -- Absolute path to a custom font file (.ttf) (optional)
        -- Only needed if the font is not installed system-wide
        -- or if you want to export as HTML with the font embedded
        -- so you can view it correctly in E-mails or browsers
      },
      italic = {
        name = "FiraCode Nerd Font", -- Font name for italic text
        file = nil,         -- Absolute path to a custom font file (.ttf) (optional)
        -- Only needed if the font is not installed system-wide
        -- or if you want to export as HTML with the font embedded
        -- so you can view it correctly in E-mails or browsers
      },
      bold_italic = {
        name = "FiraCode Nerd Font", -- Font name for bold and italic text
        file = nil,         -- Absolute path to a custom font file (.ttf) (optional)
        -- Only needed if the font is not installed system-wide
        -- or if you want to export as HTML with the font embedded
        -- so you can view it correctly in E-mails or browsers
      },
    },
  },
  -- defaults to nil
  -- if set, no pre-compiled binaries will be downloaded
  -- and the plugin will attempt to run directly from source
  debug = {
    backend = "bun",         -- Debug backend to use (currently only "bun" is supported)
    log_level = "info",      -- Log level for debugging (e.g., "info", "debug", "error")
  },
  keys = {
    { "<leader>ss", "<cmd>Snap<cr>", desc = "Snap" },
  }
}
