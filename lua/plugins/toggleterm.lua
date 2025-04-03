return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<leader>t]], -- 默认快捷键为 <leader>t
                direction = "horizontal",     -- 终端方向，可以是 "horizontal"、"vertical" 或 "float"
                float_opts = {
                    border = "single",        -- 浮动窗口的边框样式
                },
            })
        end,
    },
}
