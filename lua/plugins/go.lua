-- ~/.config/nvim/lua/plugins/go.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mfussenegger/nvim-lint",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      -- 覆盖 Go 语言服务器的默认配置
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = { unusedparams = true },
              staticcheck = true,
              gofumpt = true,                                  -- 使用更严格的代码格式化
              -- 指定使用 goimports 作为格式化工具
              ["local"] = "github.com/Spinoza1124/calculator", -- 替换为你的模块路径
              codelenses = {
                generate = true,
                gc_details = true,
                test = true,
              },
            },
          },
          -- 在初始化时加载 goimports
          on_attach = function(client, bufnr)
            -- 保存时自动格式化
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports" }, -- 指定 Go 文件使用 goimports 格式化
      },
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    config = function()
      require("go").setup({
        -- 禁用旧版 goimport
        goimports = "goimports",
        -- 启用更现代化的开发功能
        lsp_inlay_hints = {
          enable = true,
        },
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
  },
}
