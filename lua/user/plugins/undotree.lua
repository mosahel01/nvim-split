return {
  "mbbill/undotree",
  config = function()
    key = {
      vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
    }
  end
}
