return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		"zbirenbaum/copilot-cmp"
	},
	build = function()
		vim.cmd("Copilot auth")
	end,
	opts = {
		filetypes = {
			["*"] = true
		}
	},
	config = function(_, opts)
		require("copilot").setup(opts)
		require("copilot_cmp").setup()
	end
}
