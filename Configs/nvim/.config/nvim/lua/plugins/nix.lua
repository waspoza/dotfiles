local has_nix = vim.fn.executable("nix") == 1

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if not has_nix then
        opts.servers.nil_ls = { enabled = false }
      end
    end,
  },
}
