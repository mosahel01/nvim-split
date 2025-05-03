-- return {
--     "nvim-neo-tree/neo-tree.nvim",
--     branch = "v3.x",
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--         "nvim-tree/nvim-web-devicons",
--         "MunifTanjim/nui.nvim",
--     },
--     cmd = "Neotree",
--     keys = {
--         { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
--     },
--     config = function()
--         require("neo-tree").setup({
--             close_if_last_window = true,
--             enable_git_status = true,
--             enable_diagnostics = true,
--             filesystem = {
--                 follow_current_file = { enabled = true },
--                 hijack_netrw_behavior = "open_current",
--                 use_libuv_file_watcher = true,
--             },
--             window = {
--                 width = 40,
--                 mappings = {
--                     ["l"] = "open",
--                     ["h"] = "close_node",
--                 },
--             },
--         })
--     end,
-- }

return {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    },
    config = function()
        require("nvim-tree").setup({
            actions = {
              open_file = {
                quit_on_open = false,
              },
            },
            renderer = {
                indent_markers = { enable = false },
                icons = { show = {
                  file = true,
                  folder = true,
                  git = true,
                } },
            },
        })
    end,
}
