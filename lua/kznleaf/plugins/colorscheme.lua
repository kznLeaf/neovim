return {
	"navarasu/onedark.nvim",
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "darker", -- 可选: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
			-- transparent = true,
			-- 自定义高亮（如果需要手动微调颜色）
			highlights = {
				-- 例如：让缩进线颜色更深一点，适配 ibl
				-- ["IblIndent"] = { fg = "#3b4261" },
				["IblScope"] = { fg = "#565c64" },
			},
		})
		-- 必须在 setup 之后调用 load
		require("onedark").load()
	end,
}
