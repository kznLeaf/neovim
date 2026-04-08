vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- 针对 Markdown 的局部自动换行逻辑 (使用 Autocmd)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		-- 局部生效，不影响 Go 代码
		vim.opt_local.wrap = true -- 开启软换行
		vim.opt_local.linebreak = true -- 单词边界折行
		-- vim.opt_local.breakindent = true -- 折行后保持缩进
		-- vim.opt_local.textwidth = 0 -- 禁用硬换行插入 \n

		-- 视觉行移动映射：让光标在折行后的长句中按“行”移动
		local bopts = { buffer = true, silent = true }
		vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, replace_keycodes = false, unpack(bopts) })
		vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, replace_keycodes = false, unpack(bopts) })
	end,
})
