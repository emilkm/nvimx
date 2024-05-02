return {
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Continue", },
      { "<F7>", function() require("dap").step_into() end, desc = "Step Into", },
      { "<F6>", function() require("dap").step_out() end, desc = "Step Out", },
      { "<F8>", function() require("dap").step_over() end, desc = "Step Over", },
      { "<leader>dv", ":DapVirualTextToggle", "DAP Virtual text toggle" },
    },
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        keys = {
          {
            "<leader>du",
            function()
              vim.cmd.Neotree("close")
              require("dapui").toggle({})
            end,
            desc = "Dap UI",
          },
          { "<leader>dur", function() require("dapui").open({ reset = true }) end, desc = "Dap UI Reset", },
        },
        config = function(_, opts)
          print("dapui my config function")
          -- setup dap config by VsCode launch.json file
          -- require("dap.ext.vscode").load_launchjs()
          local dap = require("dap")
          local dapui = require("dapui")
          local neotreecmd = require("neo-tree.command")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            neotreecmd.execute({ action = "close" })
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            neotreecmd.execute({ action = "close" })
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            neotreecmd.execute({ action = "close" })
            dapui.close({})
          end
        end,
      },

      -- virtual test for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          virt_text_pos = "eol", -- default is inline
        },
      },
    },
  },
}
