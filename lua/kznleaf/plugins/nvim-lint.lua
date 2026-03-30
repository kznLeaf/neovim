return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- 1. 定义不同文件类型的 Linter
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			-- typescript = { "eslint_d" },
			-- vue = { "eslint_d" },
			go = { "golangcilint" },
			python = { "ruff" },
		}

		-- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		--     group = lint_augroup,
		--     callback = function()
		--         lint.try_lint()
		--     end,
		-- })

		-- 2. 创建自动化组
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
			group = lint_augroup,
			callback = function()
				-- 核心逻辑：获取当前文件的类型
				local ft = vim.bo.filetype
				-- 仅当文件类型为 python 时，才在保存/进入时自动触发 lint
				if ft == "python" then
					lint.try_lint()
				end
			end,
		})

		-- 3. 自定义快捷键：手动触发 Lint
		vim.keymap.set("n", "<leader>li", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
