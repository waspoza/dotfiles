if true then
  return {}
end
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- We load the nordic theme so we can tweak it
    local nordic = require("lualine.themes.nordic")

    -- Modify the Normal Mode 'A' section (the mode pill)
    -- Using the hex code for blue2 from your palette
    nordic.normal.a = {
      bg = "#88C0D0", -- blue2
      fg = "#2E3440", -- gray1 (darker background for contrast)
      gui = "bold",
    }

    -- Set the theme in lualine options
    opts.options = opts.options or {}
    opts.options.theme = nordic
  end,
}
