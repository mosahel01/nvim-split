return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
        -- "pmizio/typescript-tools.nvim", -- Better TS/React support
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local keymap = vim.keymap

        -- Enhanced capabilities for React
        local capabilities = vim.tbl_deep_extend("force", cmp_nvim_lsp.default_capabilities(), {
            textDocument = {
                completion = {
                    completionItem = {
                        snippetSupport = true,
                        resolveSupport = {
                            properties = { "documentation", "detail", "additionalTextEdits" },
                        },
                    },
                },
            },
        })

        -- Keymaps (improved for JSX/TSX workflow)
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("ReactLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                -- Enhanced keymaps for React development
                opts.desc = "Show component references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Go to component definition"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "Find component implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "React prop actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "Rename component"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Show component docs"
                keymap.set("n", "K", vim.lsp.buf.hover, opts)

                -- JSX/TSX specific
                opts.desc = "Organize imports"
                keymap.set("n", "<leader>oi", "<cmd>TSToolsOrganizeImports<CR>", opts)

                opts.desc = "Remove unused imports"
                keymap.set("n", "<leader>ru", "<cmd>TSToolsRemoveUnused<CR>", opts)
            end,
        })

        -- Diagnostic symbols
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        mason_lspconfig.setup_handlers({
            -- Default handler
            function(server_name)
                lspconfig[server_name].setup({ capabilities = capabilities })
            end,

            -- -- TypeScript/React specific
            -- ["ts_ls"] = function()
            --     lspconfig.ts_ls.setup({
            --         capabilities = capabilities,
            --         init_options = {
            --             preferences = {
            --                 includeInlayParameterNameHints = "all",
            --                 includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            --                 includeInlayFunctionParameterTypeHints = true,
            --                 includeInlayVariableTypeHints = true,
            --                 includeInlayPropertyDeclarationTypeHints = true,
            --                 includeInlayFunctionLikeReturnTypeHints = true,
            --                 includeInlayEnumMemberValueHints = true,
            --             },
            --         },
            --         filetypes = { "html", "css", "typescript", "javascript", "typescriptreact", "javascriptreact" },
            --     })
            -- end,

            -- Better alternative for React (optional)
            -- ["typescript-tools"] = function()
            --     require("typescript-tools").setup({
            --         capabilities = capabilities,
            --         on_attach = function(client, bufnr)
            --             -- Additional TS-specific attach logic
            --         end,
            --         settings = {
            --             ts_ls_file_preferences = {
            --                 includeInlayParameterNameHints = "all",
            --                 includeCompletionsForModuleExports = true,
            --             },
            --             ts_ls_format_options = {
            --                 insertSpaceAfterCommaDelimiter = true,
            --                 insertSpaceAfterConstructor = false,
            --                 semicolons = "insert",
            --             },
            --         },
            --     })
            -- end,

            -- CSS/SCSS for styled-components support
            ["cssls"] = function()
                lspconfig.cssls.setup({
                    capabilities = capabilities,
                    filetypes = { "css", "scss", "sass", "less", "javascriptreact", "typescriptreact" },
                })
            end,

            -- Tailwind CSS
            ["tailwindcss"] = function()
                lspconfig.tailwindcss.setup({
                    capabilities = capabilities,
                    filetypes = { "html", "javascriptreact", "typescriptreact", "svelte", "vue" },
                    init_options = {
                        userLanguages = {
                            javascriptreact = "javascript",
                            typescriptreact = "typescript",
                        },
                    },
                    settings = {
                        tailwindCSS = {
                            experimental = {
                                classRegex = {
                                    "tw`([^`]*)",
                                    'tw="([^"]*)',
                                    'tw={"([^"}]*)',
                                    "tw\\.\\w+`([^`]*)",
                                    "tw\\(.*?\\)`([^`]*)",
                                },
                            },
                        },
                    },
                })
            end,

            -- Emmet for JSX
            ["emmet_ls"] = function()
                lspconfig.emmet_ls.setup({
                    capabilities = capabilities,
                    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
                    init_options = {
                        jsx = {
                            options = {
                                ["markup.attributes"] = {
                                    ["className"] = "class",
                                },
                            },
                        },
                    },
                })
            end,

            -- Lua remains the same
            ["lua_ls"] = function()
                lspconfig.lua_ls.setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            completion = { callSnippet = "Replace" },
                        },
                    },
                })
            end,
        })
    end,
}
