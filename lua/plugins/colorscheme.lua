local themehub = "ribru17/bamboo.nvim"
local scheme = "bamboo"
-- local themehub = "deparr/tairiki.nvim"
-- local scheme = "tairiki"

return {
  {
    themehub,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme " .. scheme)

      local theme = require(scheme)
    end,
  },

  -- modicator (auto color line number based on vim mode)
  {
    "mawkler/modicator.nvim",
    dependencies = themehub,
    init = function()
      -- These are required for Modicator to work
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {},
  },
}
