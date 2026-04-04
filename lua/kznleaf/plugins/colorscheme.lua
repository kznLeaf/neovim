-- return {
-- 	"olimorris/onedarkpro.nvim",
-- 	priority = 1000, -- 确保主题在其他插件之前加载
-- 	config = function()
-- 		require("onedarkpro").setup({
-- 			options = {
-- 				cursorline = true,
-- 			},
-- 			highlights = {
-- 				-- 修改 NvimTree 的目录图标和名字颜色
-- 				NvimTreeFolderIcon = { fg = "#7f94b4" },
-- 				NvimTreeFolderName = { fg = "#7895ce" },
-- 				NvimTreeOpenedFolderName = { fg = "#7895ce" }, -- 打开的文件夹改用红色并加粗
-- 			},
-- 		})
-- 		vim.cmd("colorscheme onedark") -- 移动到这里
-- 	end,
-- }
return {

	"rebelot/kanagawa.nvim",

	priority = 1000,

	config = function()
		require("kanagawa").setup({

			theme = "wave",

			-- transparent = true,
			overrides = function(colors)
				local theme = colors.theme
				return {
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
				}
			end,
		})

		-- 必须在 setup 之后调用 load

		require("kanagawa").load("wave")
	end,
}
