return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	-- 使用 opts，lazy.nvim 会自动调用 setup
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
				go = { "goimports", "gofmt", stop_after_first = true },
				json = { "biome", "prettier", stop_after_first = true },
				javascript = { "biome", "prettier", stop_after_first = true },
				css = { "prettier" },
				toml = { "taplo" },
				html = { "prettier" },
			},
			formatters = {
				biome = { require_cwd = true }, -- Only run this formatter if it's configured in the project root.
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = function(bufnr)
				local ignore_filetypes = { "sql", "yaml", "yml" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/node_modules/") then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
		})

		-- 自定义命令：禁用/启用格式化
		vim.api.nvim_create_user_command("FormatDisable", function(opts)
			if opts.bang then
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
			vim.notify("Autoformat disabled" .. (opts.bang and " (buffer)" or " (global)"), vim.log.levels.WARN)
		end, { desc = "Disable autoformat-on-save", bang = true })

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
			vim.notify("Autoformat enabled", vim.log.levels.INFO)
		end, { desc = "Re-enable autoformat-on-save" })

		-- 快捷键绑定
		local keymap = vim.keymap
		local auto_format = true

		-- 开关自动格式化
		keymap.set("n", "<leader>uf", function()
			auto_format = not auto_format
			if auto_format then
				vim.cmd("FormatEnable")
			else
				vim.cmd("FormatDisable")
			end
		end, { desc = "Toggle Autoformat" })

		-- 查看当前格式化器信息
		keymap.set({ "n", "v" }, "<leader>cn", "<cmd>ConformInfo<cr>", { desc = "Conform Info" })

		-- 手动调用格式化
		keymap.set({ "n", "v" }, "<leader>cd", function()
			conform.format({ async = true, lsp_fallback = true }, function(err, did_edit)
				if not err and did_edit then
					vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
				end
			end)
		end, { desc = "Format buffer" })

		-- 格式化注入的代码（如 Markdown 里的 Go 代码块）
		keymap.set({ "n", "v" }, "<leader>cF", function()
			conform.format({ formatters = { "injected" }, timeout_ms = 3000 })
		end, { desc = "Format Injected Langs" })
	end,
}
