-- set leader key to space
vim.g.mapleader = " "

-- 按下两次 <Esc> 清除搜索高亮
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- only close current split window, Keep the original window

local function search_in_visible_lines()
	local scrolloff = vim.o.scrolloff
	vim.o.scrolloff = 0
	vim.cmd.norm(vim.api.nvim_replace_termcodes("VHoL<Esc>", true, true, true))
	vim.o.scrolloff = scrolloff
	vim.cmd.norm("``")
	vim.fn.feedkeys("/\\%V")
end

vim.keymap.set("n", "z/", search_in_visible_lines)
