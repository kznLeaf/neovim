return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- 确保主题在其他插件之前加载
	config = function()
		require("onedarkpro").setup({})
		vim.cmd("colorscheme onedark") -- 移动到这里
	end,
}
