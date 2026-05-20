-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "snacks_picker_preview",
--   callback = function()
--     -- 1. Force line numbers to be visible
--     vim.wo.number = true
--     vim.wo.relativenumber = false
--
--     -- 2. Map the specific colors for this window only
--     -- This ensures the gutter matches our Nordic palette
--     vim.api.nvim_set_hl(0, "LineNr", { fg = "#4C566A" }) -- gray4 for standard numbers
--
--     -- Force the 'Diff' line numbers to pop
--     -- These hex codes match the Nordic palette you provided
--     vim.api.nvim_set_hl(0, "LineNrAdd", { fg = "#A3BE8C", bg = "#222630" }) -- green.base on black2
--     vim.api.nvim_set_hl(0, "LineNrDelete", { fg = "#BF616A", bg = "#222630" }) -- red.base on black2
--
--     -- 3. Optional: Disable syntax if text is still hard to read
--     -- vim.treesitter.stop()
--     vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
--   end,
-- })
-- return {
--   {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {
--       style = "moon",
--       transparent = true,
--       styles = {
--         keywords = { bold = false }, -- Bold "return", "if", etc.
--         functions = { bold = false }, -- Bold function names?
--         variables = { bold = true },
--       },
--     },
--   },
--   { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
-- }
-- return {
--   {
--     "catppuccin/nvim",
--     lazy = false,
--     priority = 1000,
--     name = "catppuccin",
--     config = function()
--       local cp = require("catppuccin")
--
--       cp.setup({
--         flavour = "macchiato",
--         transparent_background = true,
--       })
--
--       -- The "Nuclear" Option:
--       -- Manually clear the backgrounds after the theme loads
--       vim.api.nvim_create_autocmd("ColorScheme", {
--         pattern = "catppuccin*",
--         callback = function()
--           local groups = {
--             "Normal",
--             "NormalNC",
--             "LineNr",
--             "Folded",
--             "SignColumn",
--             "StatusLine",
--             "StatusLineNC",
--             "EndOfBuffer",
--             "MsgArea",
--             -- "NormalFloat",
--             -- "FloatBorder",
--           }
--           for _, group in ipairs(groups) do
--             vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
--           end
--         end,
--       })
--
--       -- Load the colorscheme
--       vim.cmd.colorscheme("catppuccin")
--     end,
--   },
--   { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
-- }
return {
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Set your options directly
      vim.g.nord_disable_background = true
      vim.g.nord_italic = false
      vim.g.nord_bold = true
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "nord",
        callback = function()
          vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#616e88", italic = true })
        end,
      })
      -- Apply the colorscheme
      vim.cmd.colorscheme("nord")
    end,
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "nord" } },
}
-- return {
--   {
--     "AlexvZyl/nordic.nvim",
--     name = "nordic",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       require("nordic").setup({
--         transparent = {
--           bg = true, -- Makes the main background transparent
--           float = false, -- Makes floating windows transparent as well
--         },
--         bright_border = true, -- Enable brighter float border
--         bold_keywords = false,
--         reduced_blue = false,
--         on_highlight = function(highlights, palette)
--           highlights["Variable"] = { bold = true }
--           highlights["Keyword"] = { fg = palette.blue0 }
--           highlights["Macro"] = { fg = palette.blue2 }
--           highlights["Namespace"] = { fg = palette.white0 }
--           highlights["lualine_a_normal"] = { fg = palette.blue2 }
--           --
--           --   -- 2. Git Diff Blocks
--           local dark_text = palette.black2 or "#222630"
--           highlights.DiffAdd = { bg = palette.green.dim, fg = dark_text }
--           highlights.DiffDelete = { bg = palette.red.dim, fg = dark_text }
--           highlights.SnacksDiffAdd = { bg = palette.green.dim, fg = dark_text }
--           highlights.SnacksDiffDelete = { bg = palette.red.dim, fg = dark_text }
--           highlights.SnacksDiffAddLineNr = { bg = palette.green.base, fg = dark_text }
--           highlights.SnacksDiffDeleteLineNr = { bg = palette.red.base, fg = dark_text }
--           highlights.SnacksDiffChangeLineNr = { bg = palette.orange.base, fg = dark_text }
--         end,
--       })
--       vim.cmd("colorscheme nordic")
--     end,
--   },
--   { "LazyVim/LazyVim", opts = { colorscheme = "nordic" } },
-- }
-- return {
--   -- Add the Gruvbox plugin
--   { "ellisonleao/gruvbox.nvim" },
--
--   -- Configure LazyVim to use Gruvbox
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "gruvbox",
--     },
--   },
-- }
