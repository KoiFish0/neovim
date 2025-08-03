return {
  "jiaoshijie/undotree",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("undotree").setup({
      float_diff = true,  -- Show diff in a floating window
      layout = "right_bottom",  -- Window layout style
      ignore_filetype = { "undotree", "undotreeDiff" },  -- Filetypes to ignore
      window = {
        winblend = 30,  -- Transparency for the window
      },
      keymaps = {
        ["j"] = "move_next",
        ["k"] = "move_prev",
        ["J"] = "move_change_next",
        ["K"] = "move_change_prev",
        ["<cr>"] = "action_enter",
        ["p"] = "enter_diffbuf",
        ["q"] = "quit",
      },
    })
    vim.keymap.set("n", "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", { desc = "Toggle Undotree" })
  end,
  keys = {
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undotree" },
  },
}
