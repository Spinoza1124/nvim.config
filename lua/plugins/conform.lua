return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- 添加延迟加载以提高启动速度
  cmd = { "ConformInfo" },
  opts = {
    -- 根据文件类型设置格式化工具
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" }, -- 先运行 isort 后运行 black
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      markdown = { "prettier" },
      yaml = { "prettier" },
      sh = { "shfmt" },
    },
    formatters = {
      isort = {
        command = "isort",
        args = { "--profile", "black", "--stdout", "-" },
      },
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
      shfmt = {
        prepend_args = { "-i", "2", "-ci" }, -- 2空格缩进，缩进case
      },
    },
    -- 在写入文件时自动格式化
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    format_after_save = {
      lsp_fallback = true,
    },
  },
  init = function()
    -- 添加便捷键映射
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "格式化代码" })
  end,
}