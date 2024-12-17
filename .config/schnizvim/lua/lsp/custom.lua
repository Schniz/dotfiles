---@type table<string,lspconfig.Config>
return {
	sourcekit_lsp = {
		filetypes = { "swift" },
		cmd = { "xcrun", "sourcekit-lsp" }
	},

	-- git_lsp = {
	--   command = { "/Users/schniz/Code/git_lsp/target/debug/git_lsp" },
	-- }
}
