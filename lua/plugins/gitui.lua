return {
  "williamboman/mason.nvim",
  keys = {
    {
      "<leader>gu",
      function()
        LazyVim.terminal.open({ "gitui" }, { cwd = vim.uv.cwd(), esc_esc = false, ctrl_hjkl = false })
      end,
      desc = "GitUi (cwd)",
    },
    {
      "<leader>gU",
      function()
        LazyVim.terminal.open({ "gitui" }, { cwd = LazyVim.root.get(), esc_esc = false, ctrl_hjkl = false })
      end,
      desc = "GitUi (Root Dir)",
    },
  },
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, { "gitui" })
  end,
}
