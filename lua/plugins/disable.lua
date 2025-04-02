return {
  { "nvim-tree/nvim-tree.lua", enabled = false }, -- 禁用默认文件树
  -- 添加替代插件（neo-tree）并增强配置
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { 
      "nvim-lua/plenary.nvim", 
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons" -- 确保有图标支持
    },
    opts = {
      close_if_last_window = true, -- 当是最后一个窗口时自动关闭
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        filtered_items = {
          visible = false, -- 默认不显示隐藏文件
          hide_dotfiles = false, -- 不隐藏点文件
          hide_gitignored = true, -- 隐藏 gitignored 文件
        },
        follow_current_file = {
          enabled = true, -- 自动跟随当前文件
        },
        group_empty_dirs = true, -- 将空目录分组显示
        use_libuv_file_watcher = true, -- 使用高效的文件监视器
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "toggle_node",
          ["<cr>"] = "open",
          ["P"] = { "toggle_preview", config = { use_float = true } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- 使用展开器 (类似 VS Code)
        },
      },
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "切换资源管理器" },
      { "<leader>o", "<cmd>Neotree focus<cr>", desc = "焦点到资源管理器" },
    },
  }
}