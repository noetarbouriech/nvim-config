require('nvim-treesitter.configs').setup({
	highlight = { enable = true, additional_vim_regex_highlighting = false},
  -- We must manually specify which parsers to install
	ensure_installed = {
    "bash",
    "c",
		"json",
    "go",
    "rust",
		"lua",
    "python",
    "yaml",
    "html",
    "css",
    "svelte",
    "nix",
    "scss",
    "typescript",
    "javascript"
	},
})
