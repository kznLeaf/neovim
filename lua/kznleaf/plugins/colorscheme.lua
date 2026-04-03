return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- 确保主题在其他插件之前加载
	config = function()
		require("onedarkpro").setup({
			options = {
				cursorline = true,
			},
			highlights = {
				-- 修改 NvimTree 的目录图标和名字颜色
				NvimTreeFolderIcon = { fg = "#7f94b4" },
				NvimTreeFolderName = { fg = "#7895ce" },
				NvimTreeOpenedFolderName = { fg = "#7895ce" }, -- 打开的文件夹改用红色并加粗
			},
		})
		vim.cmd("colorscheme onedark") -- 移动到这里
	end,
}
