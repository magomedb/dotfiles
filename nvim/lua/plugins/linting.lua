return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- Define linters for specific file types
		lint.linters_by_ft = {
			rust = { "clippy" }, -- Add Clippy as the linter for Rust files
		}

		-- Create a dedicated autogroup for linting
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		-- Trigger linting only on save (BufWritePost)
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Optional: Keymap for manual linting
		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
