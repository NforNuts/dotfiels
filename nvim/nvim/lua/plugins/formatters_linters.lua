return {
	{
		"stevearc/conform.nvim",

		event = { "BufWritePre" },
		dependencies = { "mason.nvim" },
		cmd = "ConformInfo",
		lazy = true,

		opts = {
			formatters_by_ft = {
				go = { "goimports", "gofumpt" },
				lua = { "stylua" },
				-- python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},

			formatters = {
				["clang-format"] = {
					prepend_args = { "--style=file", "--fallback-style=LLVM" },
				},
			},

			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},

	{
		"mfussenegger/nvim-lint",

		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},

		config = function(_, opts)
			local lint = require("lint")
			lint.linters_by_ft = {
				python = { "ruff" },
			}

			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
