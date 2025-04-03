return {
    {
        "folke/tokyonight.nvim",
        lazy = false,                                                      -- 立即加载
        priority = 1000,                                                   -- 高优先级
        opts = {
            style = "night",                                               -- 可选：night/moon/day/storm
            transparent = false,                                           -- 启用全局透明背景
            terminal_colors = false,                                       -- 设置终端颜色
            styles = {
                comments = { italic = true },                              -- 斜体注释
                keywords = { italic = true },                              -- 斜体关键字
                functions = { bold = true },                               -- 粗体函数名
                variables = {},
                sidebars = "transparent",                                  -- 侧边栏透明
                floats = "transparent",                                    -- 浮动窗口透明
            },
            sidebars = { "qf", "help", "terminal", "packer", "neo-tree" }, -- 需要特殊样式的侧边栏
            day_brightness = 0.3,                                          -- light 样式亮度调整
            hide_inactive_statusline = true,                               -- 隐藏非活动状态栏
            dim_inactive = true,                                           -- 非活动窗口变暗
            lualine_bold = true,                                           -- lualine 区段使用粗体
            on_colors = function(colors)
                -- 增强一些颜色以提高对比度
                colors.blue = "#7aa2f7"
                colors.purple = "#bb9af7"
            end,
            on_highlights = function(highlights, colors)
                -- 自定义高亮组
                highlights.Comment = { fg = colors.green, bold = true }
                highlights.LineNr = { fg = colors.gray }
                highlights.CursorLineNr = { fg = colors.orange, bold = true }
                highlights.Search = { bg = colors.blue, fg = colors.black }
                highlights.IncSearch = { bg = colors.orange, fg = colors.black }
                highlights.DiagnosticError = { fg = colors.red, bold = true }
                highlights.DiagnosticWarn = { fg = colors.yellow, bold = true }
                highlights.DiagnosticHint = { fg = colors.teal, bold = true }
            end,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight") -- 应用主题
        end,
    }
}
