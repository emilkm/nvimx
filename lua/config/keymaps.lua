-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local kmap = vim.keymap
local kmaps = kmap.set
local kmapd = kmap.del
local skmap = vim.api.nvim_set_keymap
local dopts = { noremap = true, silent = true }
local util = require("lazyvim.util")
--local vkmap = require("common.keymap-util").vkmap

kmaps("n", "<leader>x", function()
  vim.cmd("bd")
end, { desc = "Close buffer" })

kmaps("n", "di", "<cmd>lua vim.diagnostic.open_float()<cr>")
kmaps("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
kmaps("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

kmaps("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
kmaps("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
kmaps("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
kmaps("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
kmaps("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
kmaps("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true })

-- Bordered terminal
kmaps("n", "<C-/>", function()
  util.terminal(nil, { border = "none" })
end, { desc = "Term with border" })

-- Moving lines with S-j and S-k when in visual mode
kmaps("v", "J", ":m '>+1<CR>gv=gv")
kmaps("v", "K", ":m '<-2<CR>gv=gv")

kmapd({ "n", "i", "v" }, "<A-j>")
kmapd({ "n", "i", "v" }, "<A-k>")
kmapd("n", "<C-Left>")
kmapd("n", "<C-Down>")
kmapd("n", "<C-Up>")
kmapd("n", "<C-Right>")

kmaps("n", "<M-h>", '<Cmd>lua require("tmux").resize_left()<CR>', { silent = true })
kmaps("n", "<M-j>", '<Cmd>lua require("tmux").resize_bottom()<CR>', { silent = true })
kmaps("n", "<M-k>", '<Cmd>lua require("tmux").resize_top()<CR>', { silent = true })
kmaps("n", "<M-l>", '<Cmd>lua require("tmux").resize_right()<CR>', { silent = true })

-- Split windows
kmaps("n", "ss", ":split<Return>", dopts)
kmaps("n", "sv", ":vsplit<Return>", dopts)

-- Tabs
kmaps("n", "te", ":tabedit", dopts)
kmaps("n", "<tab>", ":tabnext<Return>", dopts)
kmaps("n", "<s-tab>", ":tabprev<Return>", dopts)

-- package-info keymaps
skmap(
  "n",
  "<leader>cpt",
  "<cmd>lua require('package-info').toggle()<cr>",
  { silent = true, noremap = true, desc = "Toggle" }
)
skmap(
  "n",
  "<leader>cpd",
  "<cmd>lua require('package-info').delete()<cr>",
  { silent = true, noremap = true, desc = "Delete package" }
)
skmap(
  "n",
  "<leader>cpu",
  "<cmd>lua require('package-info').update()<cr>",
  { silent = true, noremap = true, desc = "Update package" }
)
skmap(
  "n",
  "<leader>cpi",
  "<cmd>lua require('package-info').install()<cr>",
  { silent = true, noremap = true, desc = "Install package" }
)
skmap(
  "n",
  "<leader>cpc",
  "<cmd>lua require('package-info').change_version()<cr>",
  { silent = true, noremap = true, desc = "Change package version" }
)
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local bufmap = function(mode, lhs, rhs, desc)
      local opts = { desc = desc, buffer = event.buf }
      kmaps(mode, lhs, rhs, opts)
    end

    -- You can find details of these function in the help page
    -- see for example, :help vim.lsp.buf.hover()

    -- Trigger code completion
    bufmap("i", "<C-Space>", "<C-x><C-o>", "LSP Code completion")

    -- Display documentation of the symbol under the cursor
    bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "LSP Symbol documentation")

    -- Jump to the definition
    --bufmap("n", "gd", "<cmd>:split | lua vim.lsp.buf.definition()<cr>", "LSP Go to definition")
    bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "LSP Go to definition")

    -- Jump to declaration
    bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "LSP Go to declaration")

    -- Lists all the implementations for the symbol under the cursor
    bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "LSP List implementations")

    -- Jumps to the definition of the type symbol
    bufmap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "LSP Go to type definition")

    -- Lists all the references
    bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", "LSP Go to references")

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP Specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "LSP Rename")

    -- Format current file
    bufmap("n", "<F3>", "<cmd>lua vim.lsp.buf.format()<cr>", "LSP Format")

    -- Selects a code action available at the current cursor position
    bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", "LSP Code action")
  end,
})
