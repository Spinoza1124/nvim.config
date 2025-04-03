local M = {}

-- 常用 LSP 服务器配置
M.servers = {
    -- Python
    pyright = {
        settings = {
            python = {
                analysis = {
                    diagnosticMode = "openFilesOnly",
                    typeCheckingMode = "basic", -- 可选：basic|strict|off
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticSeverityOverrides = {
                        -- 调整特定消息级别
                        reportUnusedImport = "warning",
                        reportUnusedClass = "warning",
                        reportUnusedFunction = "warning",
                        reportUnusedVariable = "warning",
                    },
                },
            },
        },
    },

    -- Lua
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }, -- 识别vim全局变量
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
    },

    -- TypeScript/JavaScript
    tsserver = {
        settings = {
            typescript = {
                inlayHints = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
            javascript = {
                inlayHints = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
        },
    },

    -- JSON
    jsonls = {
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            }
        }
    },

    -- YAML
    yamlls = {
        settings = {
            yaml = {
                schemaStore = {
                    enable = true,
                    url = "https://www.schemastore.org/api/json/catalog.json",
                },
            },
        },
    },

    -- 其他语言服务器可以根据需要添加
}

-- 全局 LSP 设置
M.setup = function(server, opts)
    -- 自定义 on_attach 回调
    local on_attach = function(client, bufnr)
        -- 禁用特定服务器的格式化（如果使用专用格式化工具）
        if client.name == "tsserver" or client.name == "jsonls" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end

        -- 设置 LSP 相关快捷键
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "转到声明" }))
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "转到定义" }))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "显示文档" }))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", bufopts, { desc = "转到实现" }))
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", bufopts, { desc = "显示签名" }))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "重命名" }))
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", bufopts, { desc = "代码操作" }))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "查找引用" }))
    end

    -- 合并默认选项和自定义选项
    opts = vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = on_attach,
    }, opts or {})

    -- 应用服务器特定配置
    if M.servers[server] then
        opts = vim.tbl_deep_extend("force", opts, M.servers[server] or {})
    end

    -- 调用 lspconfig 进行设置
    require("lspconfig")[server].setup(opts)

    return true
end

return M
