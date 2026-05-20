return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        notifications = {
          layout = {
            layout = {
              box = "vertical",
              backdrop = false,
              width = 0.8,
              height = 0.9,
              { win = "input", height = 1, border = "rounded", title = "{title}" },
              { win = "list", border = "rounded" },
              { win = "preview", border = "rounded", height = 0.4 },
            },
          },
        },
      },
    },
  },
}
