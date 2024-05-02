local kmap = vim.keymap
local kmaps = kmap.set
local skmap = vim.api.nvim_set_keymap

local M = {}

M.vkmap = function(mode, keys, func, desc, bufn)
  if bufn then
    kmaps(mode, keys, func, { desc = desc, buffer = bufn })
  else
    kmaps(mode, keys, func, { desc = desc })
  end
end

return M
