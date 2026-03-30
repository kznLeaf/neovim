-- set leader key to space
vim.g.mapleader = " "

-- 按下两次 <Esc> 清除搜索高亮
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<leader>cl", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
