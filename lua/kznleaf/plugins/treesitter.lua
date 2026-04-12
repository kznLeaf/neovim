return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local ts = require("nvim-treesitter")

		ts.install({
			"go",
			"gomod",
			"gosum",
			"rust",
			"python",
			"proto",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"c",
			"markdown",
			"markdown_inline",
			"json",
			"yaml",
			"bash",
			"dockerfile",
			"gitignore",
		})

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
			callback = function()
				local bufnr = vim.api.nvim_get_current_buf()
				pcall(vim.treesitter.start, bufnr)
			end,
		})

		require("nvim-ts-autotag").setup()
	end,
}
