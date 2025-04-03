return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" }, -- 添加必要的 nvim-nio 依赖
                config = function()
                    require("dapui").setup()
                end,
            },
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text", -- 添加虚拟文本支持
            "nvim-telescope/telescope-dap.nvim", -- 添加 telescope 集成
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Python 调试设置
            require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

            -- 虚拟文本
            require("nvim-dap-virtual-text").setup({
                enabled = true,
                enabled_commands = true,
                highlight_changed_variables = true,
                highlight_new_as_changed = false,
                all_frames = true,
            })

            -- DAP UI 配置
            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "→" },
                controls = {
                    icons = {
                        pause = "⏸",
                        play = "▶",
                        step_into = "⏎",
                        step_over = "⏭",
                        step_out = "⏮",
                        step_back = "↩",
                        terminate = "□",
                        disconnect = "⏏",
                    },
                },
            })
            -- 自动打开/关闭 DAP UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
            -- 键盘映射
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "切换断点" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("条件断点: "))
            end, { desc = "设置条件断点" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "继续" })
            vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "单步跳过" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "单步进入" })
            vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "单步跳出" })
            vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "终止" })
            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "切换 UI" })
        end,
        keys = {
            { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "添加断点" },
            { "<leader>dc", "<cmd>DapContinue<CR>", desc = "继续执行" },
            { "<leader>di", "<cmd>DapStepInto<CR>", desc = "单步进入" },
            { "<leader>do", "<cmd>DapStepOver<CR>", desc = "单步跳过" },
            { "<leader>dO", "<cmd>DapStepOut<CR>", desc = "单步退出" },
            { "<leader>dr", "<cmd>DapToggleRepl<CR>", desc = "切换 REPL" },
            { "<leader>dl", "<cmd>DapLoadLaunchJSON<CR>", desc = "加载启动配置" },
            { "<leader>dt", "<cmd>DapTerminate<CR>", desc = "终止调试" },
            { "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", desc = "切换 DAP UI" },
        }
    }
}

