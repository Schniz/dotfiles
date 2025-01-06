return {
	"RRethy/nvim-base16",
	init = function()
		vim.cmd.colorscheme("base16-eighties")
		vim.cmd [[highlight NonText guifg=#444444]]
		vim.cmd [[highlight Normal guibg=None]]
		-- vim.cmd [[highlight LineNr guibg=None]]
		-- vim.cmd [[highlight SignColumn guibg=None]]
	end
}
