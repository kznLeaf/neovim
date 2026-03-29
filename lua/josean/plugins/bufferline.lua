return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	event = "VeryLazy",
	keys = {
		-- 按 <leader>b 直接弹出所有已打开 Buffer 的搜索列表
		{ "<leader>b", "<cmd>Telescope buffers previewer=false<cr>", desc = "Find Buffer" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		-- Close the sleceted tab
		{
			"<leader>x",
			function()
				local bufnr = vim.api.nvim_get_current_buf()
				-- 如果当前是在 NvimTree 窗口，不要关掉它，直接返回
				if vim.bo.filetype == "NvimTree" then
					return
				end

				-- 获取当前所有列出的 buffer
				local buffers = vim.fn.getbufinfo({ buflisted = 1 })

				if #buffers > 1 then
					-- 如果有多个 buffer，先跳到上一个，再删除之前的
					vim.cmd("BufferLineCyclePrev")
					vim.cmd("bdelete " .. bufnr)
				else
					-- 如果是最后一个 buffer，直接删除（会自动变成空 buffer，不会让 NvimTree 抢占全屏）
					vim.cmd("bdelete " .. bufnr)
				end
			end,
			desc = "Safe Close Buffer",
		},
	},
	opts = {
		options = {
			mode = "buffers",
			separator_style = "thin",
			always_show_bufferline = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			offsets = {
				{
					filetype = "NvimTree",
					text = "NvimTree",
					text_align = "center",
					separator = false,
				},
			},
		},
	},
}
