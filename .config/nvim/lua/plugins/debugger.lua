return {
  -- Debugger configuration
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      -- DAP UI integration
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- Keymaps for DAP
      vim.keymap.set("n", "<leader>nb", dap.toggle_breakpoint, { silent = true, desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>nc", dap.continue, { silent = true, desc = "Start/continue debugging" })
      vim.keymap.set("n", "<leader>no", dap.step_over, { silent = true, desc = "Step over" })
      vim.keymap.set("n", "<leader>ni", dap.step_into, { silent = true, desc = "Step into" })
      vim.keymap.set("n", "<leader>nx", dap.step_out, { silent = true, desc = "Step out" })
    end,
  },
}
