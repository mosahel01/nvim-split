return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { {
    "echasnovski/mini.icons",
    opts = {},
  } },
  lazy = false,
  keys = {
    vim.keymap.set("n", "-", "<CMD>Oil<CR>"),
    vim.keymap.set("n", "<space>-", "<cmd>lua require('oil').toggle_float('.')<cr>")
  },
}
