-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- 设置 leader 键为空格
vim.g.mapleader = " "

-- 修改退出键
map("i", "jj", "<Esc>", { desc = "退出插入模式" })

-- 更好的窗口导航
map("n", "<C-h>", "<C-w>h", { desc = "跳转到左窗口" })
map("n", "<C-j>", "<C-w>j", { desc = "跳转到下窗口" })
map("n", "<C-k>", "<C-w>k", { desc = "跳转到上窗口" })
map("n", "<C-l>", "<C-w>l", { desc = "跳转到右窗口" })

-- 窗口管理
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "垂直分割" })
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "水平分割" })
map("n", "<leader>wq", "<cmd>close<cr>", { desc = "关闭窗口" })
map("n", "<leader>wo", "<cmd>only<cr>", { desc = "关闭其他窗口" })

-- 调整窗口大小
map("n", "<A-h>", "<cmd>vertical resize -2<cr>", { desc = "减小窗口宽度" })
map("n", "<A-j>", "<cmd>resize +2<cr>", { desc = "增加窗口高度" })
map("n", "<A-k>", "<cmd>resize -2<cr>", { desc = "减小窗口高度" })
map("n", "<A-l>", "<cmd>vertical resize +2<cr>", { desc = "增加窗口宽度" })

-- 缓冲区操作
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "前一个缓冲区" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "下一个缓冲区" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "删除缓冲区" })
map("n", "<leader>bD", "<cmd>bufdo bdelete<cr>", { desc = "删除所有缓冲区" })

-- 更好的上下翻页 (保持光标居中)
map("n", "<C-d>", "<C-d>zz", { desc = "向下翻页并居中" })
map("n", "<C-u>", "<C-u>zz", { desc = "向上翻页并居中" })

-- 搜索结果居中显示
map("n", "n", "nzzzv", { desc = "下一个搜索结果并居中" })
map("n", "N", "Nzzzv", { desc = "上一个搜索结果并居中" })

-- 移动选中文本
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "向下移动行" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "向上移动行" })

-- 保持选区在缩进时
map("v", "<", "<gv", { desc = "向左缩进" })
map("v", ">", ">gv", { desc = "向右缩进" })

-- 粘贴时不复制被替换文本
map("x", "p", [["_dP]], { desc = "粘贴但不复制被替换内容" })

-- 清除搜索高亮
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "清除搜索高亮" })

-- 快速保存和退出
map("n", "<leader>w", "<cmd>w<cr>", { desc = "保存" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "退出" })
map("n", "<leader>Q", "<cmd>q!<cr>", { desc = "强制退出" })
map("n", "<leader>wq", "<cmd>wq<cr>", { desc = "保存并退出" })

-- 终端相关
map("t", "<Esc>", "<C-\\><C-n>", { desc = "退出终端模式" })
map("n", "<leader>t", "<cmd>terminal<cr>", { desc = "打开终端" })

-- 更好的行首/行尾跳转
map("n", "H", "^", { desc = "跳转到行首" })
map("n", "L", "$", { desc = "跳转到行尾" })
map("v", "H", "^", { desc = "跳转到行首" })
map("v", "L", "$", { desc = "跳转到行尾" })

-- 快速插入常用文本
map("n", "<leader>d", "o<Esc>", { desc = "在下方插入空行" })
map("n", "<leader>D", "O<Esc>", { desc = "在上方插入空行" })

-- 在浮动终端中启动GUI程序
vim.keymap.set("n", "<leader>gg", function()
    require("toggleterm").exec(
        "go run mian.go &", -- 示例：替换为 go run main.go &
        1,                  -- 窗口大小比例
        20,                 -- 窗口高度
        nil,                -- 窗口名称
        "float"             -- 窗口类型
    )
end, { desc = "运行GUI程序" })
