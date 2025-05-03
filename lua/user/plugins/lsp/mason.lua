return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- Enhanced Mason UI configuration
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
                border = "rounded",
                width = 0.8,
                height = 0.8,
            },
            pip = {
                upgrade_pip = true,
            },
            max_concurrent_installers = 4,
        })

        -- Optimized LSP servers for React/TypeScript development
        mason_lspconfig.setup({
            ensure_installed = {
                -- TypeScript/JavaScript
                -- "ts_ls", -- Official TypeScript server (remove ts_ls as it's deprecated)

                -- Web Development
                "html", -- HTML
                "cssls", -- CSS
                "tailwindcss", -- Tailwind CSS
                "emmet_ls", -- Emmet support

                -- React Specific
                "eslint", -- ESLint (for both JS and TS)

                -- Other Languages
                "lua_ls", -- Lua
                "graphql", -- GraphQL
                "prismals", -- Prisma
                "pyright", -- Python

                -- Optional but recommended
                "jsonls", -- JSON
                "yamlls", -- YAML
            },
            automatic_installation = true, -- Automatically install missing servers
        })

        -- Enhanced tool installer with version pinning and auto-update
        mason_tool_installer.setup({
            ensure_installed = {
                -- Formatters
                "prettier", -- JavaScript/TypeScript/CSS/HTML formatter
                "prettierd", -- Faster Prettier daemon
                "stylua", -- Lua formatter
                "black", -- Python formatter
                "isort", -- Python import sorter

                -- Linters
                "eslint_d", -- Fast ESLint daemon
                "stylelint", -- CSS/SCSS linter

                -- Debuggers
                "js-debug-adapter", -- JavaScript debugger

                -- Utilities
                "cspell", -- Spell checker
                "markdownlint", -- Markdown linter
            },
            auto_update = true,
            run_on_start = true,
            start_delay = 3000, -- Delay before first install (ms)
        })
    end,
}
