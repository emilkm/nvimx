local M = {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        gopls = {},
        html = {
          filetypes = { "html", "templ" },
        },
        htmx = {
          filetypes = { "html", "templ" },
        },
        tailwindcss = {
          filetypes = { "templ", "astro", "javascript", "typescript", "react" },
          init_options = { userLanguages = { templ = "html" } },
        },
        templ = {},
      },
      setup = {
        templ = function(_, opts)
          -- Add templ filetype extension
          vim.filetype.add({ extension = { templ = "templ" } })
        end,
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
}

return M
