return {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  keys = {
    { "<Leader>ce", ":Crates show_features_popup<CR>", desc = "Show Crate Features" },
  },
}
