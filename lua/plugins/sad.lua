return {
  "ray-x/sad.nvim",
  dependencies = {
    {
      "ray-x/guihua.lua",
    },
  },
  config = function()
    require("sad").setup()
  end,
}
