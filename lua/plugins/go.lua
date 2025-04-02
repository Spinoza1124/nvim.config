return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "mfussenegger/nvim-lint",
        },
        opts = {
            servers = {
                gopls = {
                    settings = {
                        gopls = {
                            gofumpt = true,
                            analyses = {
                                unusedparams = true,
                                shadow = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            codelenses = {
                                generate = true,
                                gc_details = true,
                                test = true,
                                tidy = true,
                            },
                            experimentalPostfixCompletions = true,
                            usePlaceholders = true,
                            completeUnimported = true,
                            staticcheck = true,
                            semanticTokens = true,
                        },
                    },
                    on_attach = function(client, bufnr)
                        -- 高级保存操作：格式化+整理
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false })
                                vim.cmd(
                                    "silent! lua vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })")
                            end,
                        })
                    end,
                }
            }
        }
    },

    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
        },
        opts = {
            -- 禁用内置格式化（使用conform.nvim）
            goimports = false,
            gofmt = false,
            lsp = {
                -- 继承主配置
                on_attach = require("lspconfig").gopls.on_attach
            },
            -- 增强开发体验配置
            trouble = true,
            test_runner = "gotest",
            dap_debug = true,
        },
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters = {
                gofumpt = {
                    command = "gofumpt",
                    args = { "-extra" }
                }
            },
            formatters_by_ft = {
                go = { "gofumpt", "goimports" }, -- 使用gofumpt代替goimports
            },
        }
    },

    -- 确保安装必要工具
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "gofumpt",
                "goimports",
                "golines",
                "gopls",
                "delve",
            }
        }
    }
}
