return {
  -- 1. Setup nixd and disable nil_ls in lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {}, -- lspconfig knows what nixd is, so this works perfectly
        nil_ls = { enabled = false }, -- Stop LazyVim from looking for nil
      },
    },
  },

  -- 2. Clean up mason-lspconfig so it doesn't panic
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      -- Remove nil_ls from Mason's auto-install registry
      opts.ensure_installed = vim.tbl_filter(function(val)
        return val ~= "nil_ls" and val ~= "nixd"
      end, opts.ensure_installed)
    end,
  },

  -- -- 4. Register Statix Code Actions so <leader>ca works interactively
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = opts.sources or {}
  --     -- Append statix code actions to your existing none-ls sources
  --     table.insert(opts.sources, nls.builtins.code_actions.statix)
  --   end,
  -- },
  --
  -- -- 4. Create your manual, line-by-line Statix Fix trigger
  -- {
  --   "nvim-treesitter/nvim-treesitter", -- We can attach a basic keymap hook here
  --   init = function()
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = "nix",
  --       callback = function()
  --         -- Map Space + c + x to manually run statix fix on the current line
  --         vim.keymap.set("n", "<leader>cx", function()
  --           -- Get current line contents and line number
  --           local line_num = vim.api.nvim_win_get_cursor(0)[1]
  --           local current_line = vim.api.nvim_get_current_line()
  --
  --           -- Pipe the line into statix via a shell command
  --           local command = string.format("echo '%s' | statix fix --stdin", current_line:gsub("'", "'\\''"))
  --           local handle = io.popen(command)
  --           local result = handle:read("*a")
  --           handle:close()
  --
  --           -- If statix successfully fixed the line, swap it in
  --           if result and result ~= "" then
  --             -- Strip trailing newlines from command output
  --             result = result:gsub("\n$", "")
  --             vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { result })
  --             vim.notify("Statix: Line fixed!", vim.log.levels.INFO)
  --           else
  --             vim.notify("Statix: No fixes available for this line.", vim.log.levels.WARN)
  --           end
  --         end, { buffer = true, desc = "Manually fix Nix line with Statix" })
  --       end,
  --     })
  --   end,
  -- },
}
