return {
	"akinsho/toggleterm.nvim",
	version = "*",
	-- 不要用 config = true，要写具体的 setup 逻辑
	opts = {
		open_mapping = [[<C-t>]],
		direction = "float",
		float_opts = {
			border = "curved", -- 关键美化：使用圆角边框 (还有 'shadow', 'double', 'single')
			winblend = 3, -- 稍微带一点点透明度，透出后面的代码
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	},
}
