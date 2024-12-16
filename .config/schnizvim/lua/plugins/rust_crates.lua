return {
	'saecki/crates.nvim',
	event = { "BufRead Cargo.toml" },
	dependencies = { 'nvim-lua/plenary.nvim' },
	main = 'crates',
	opts = {
		null_ls = {
			enabled = true,
			name = 'crates.nvim'
		}
	}
}
