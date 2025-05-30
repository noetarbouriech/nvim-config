-- Lazy plugin loader
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"rebelot/kanagawa.nvim", -- Colorscheme

	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"kyazdani42/nvim-web-devicons", -- Nerd fonts support
	"numToStr/FTerm.nvim", -- Floating terminal
	-- "github/copilot.vim", -- GitHub Copilot
	"theprimeagen/harpoon", -- Prime's harpoon
	"arjunmahishi/flow.nvim", -- Run code snippets
	"folke/zen-mode.nvim", -- Zen mode

	"nvim-treesitter/nvim-treesitter",

	require("plugins.lsp"), -- LSP
	require("plugins.telescope"), -- LSP
	require("plugins.obsidian"), -- Obsidian
	require("plugins.markview"), -- Markview

	{ -- Comments
		"numToStr/Comment.nvim",
		opts = {},
	},

	{ -- Go support
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},

	{ -- Improve LSP UI
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},

	{ -- Indent guides
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	{ -- Adds git signs
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{ -- Show LSP diagnostics using virtual lines
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	},

	{ -- Statusline
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				tabline = {
					lualine_a = { "buffers" },
				},
				options = {
					extensions = { "fzf", "quickfix" },
					theme = "kanagawa",
					component_separators = "|",
					section_separators = "",
				},
			})
		end,
	},

	{ -- Highlight TODO, FIXME, etc.
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	{ -- Mini plugins
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Align text
			require("mini.align").setup()
		end,
	},

	-- { -- Image support in markdown
	-- 	"3rd/image.nvim",
	-- 	config = function()
	-- 		-- ...
	-- 	end,
	-- },

	{ -- Markdown preview
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},

	{ -- Show keybindings
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			})
		end,
	},

	{ -- Tmux navigation
		"alexghergh/nvim-tmux-navigation",
		config = function()
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = true, -- defaults to false
				keybindings = {
					left = "<C-h>",
					down = "<C-j>",
					up = "<C-k>",
					right = "<C-l>",
					last_active = "<C-\\>",
					next = "<C-Space>",
				},
			})
		end,
	},

	{ -- UI
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				cmdline = {
					enabled = true,
					format = {
						input = { view = "cmdline_input", icon = "󱞩" }, -- Used by input()
					},
				},
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"allaman/emoji.nvim",
		version = "1.0.0", -- optionally pin to a tag
		ft = "markdown", -- adjust to your needs
		dependencies = {
			-- optional for nvim-cmp integration
			"hrsh7th/nvim-cmp",
			-- optional for telescope integration
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			-- default is false
			enable_cmp_integration = true,
		},
		config = function(_, opts)
			require("emoji").setup(opts)
			-- optional for telescope integration
			require("telescope").load_extension("emoji")
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false, -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	-- {
	-- 	"3rd/image.nvim",
	-- 	dependencies = {
	-- 		"leafo/magick",
	-- 		{
	-- 			"vhyrro/luarocks.nvim",
	-- 			opts = {
	-- 				rocks = {
	-- 					hererocks = true,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		-- image.nvim config
	-- 	},
	-- },
})
