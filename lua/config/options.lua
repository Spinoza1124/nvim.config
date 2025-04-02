-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 显示设置
vim.opt.termguicolors = true  -- 使用终端真彩色
vim.opt.number = true         -- 显示行号
vim.opt.relativenumber = true -- 相对行号
vim.opt.cursorline = true     -- 高亮当前行
vim.opt.showmode = false      -- 不显示模式（由状态栏插件替代）
vim.opt.signcolumn = "yes"    -- 始终显示标志列
vim.opt.cmdheight = 1         -- 命令行高度
vim.opt.scrolloff = 8         -- 上下至少保留8行
vim.opt.sidescrolloff = 8     -- 左右至少保留8列
vim.opt.conceallevel = 0      -- 显示所有字符（如markdown链接）

-- 编辑行为
vim.opt.expandtab = true   -- 使用空格而非tab
vim.opt.shiftwidth = 4     -- 缩进宽度为2
vim.opt.tabstop = 4        -- tab宽度为2
vim.opt.softtabstop = 4    -- 软tab宽度为2
vim.opt.smartindent = true -- 智能缩进
vim.opt.wrap = false       -- 不自动换行
vim.opt.linebreak = true   -- 仅在合适的地方换行
vim.opt.breakindent = true -- 换行后保持缩进

-- 搜索设置
vim.opt.hlsearch = true   -- 高亮搜索结果
vim.opt.ignorecase = true -- 搜索忽略大小写
vim.opt.smartcase = true  -- 智能大小写（如果有大写就区分）

-- 文件处理
vim.opt.backup = false                                 -- 禁用备份文件
vim.opt.swapfile = false                               -- 禁用交换文件
vim.opt.undofile = true                                -- 启用持久撤销
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- 撤销文件位置
vim.opt.fileencoding = "utf-8"                         -- 使用UTF-8编码
vim.opt.hidden = true                                  -- 允许切换buffer时不保存

-- 性能相关
vim.opt.updatetime = 100 -- 更新时间（ms）
vim.opt.timeout = true   -- 启用键映射超时
vim.opt.timeoutlen = 300 -- 按键序列超时时间（ms）

-- 剪贴板集成
vim.opt.clipboard = "unnamedplus" -- 使用系统剪贴板

-- 分割窗口行为
vim.opt.splitbelow = true -- 水平分割在下方
vim.opt.splitright = true -- 垂直分割在右侧

-- 鼠标支持
vim.opt.mouse = "a" -- 所有模式下启用鼠标

-- 补全设置
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- 补全选项

-- 确保终端继承所有环境变量
vim.g.terminal_env = "env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY"
