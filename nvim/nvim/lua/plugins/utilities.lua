local function term_nav(dir)
	---@param self snacks.terminal
	return function(self)
		return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
			vim.cmd.wincmd(dir)
		end)
	end
end

return {
	--==================
	--   plenary.nvim
	--==================
	{ "nvim-lua/plenary.nvim", lazy = true },

	--=================
	--   mini.icons
	--=================
	{
		"nvim-mini/mini.icons",
		lazy = true,
		opts = {},
		config = function(_, opts)
			local micons = require("mini.icons")
			micons.setup(opts)
			micons.mock_nvim_web_devicons()
		end,
	},

	--=================
	--   mini.ai
	--=================
	{
		"nvim-mini/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			}
		end,
	},

	--=================
	--   snacks.nvim
	--=================
	{
		"folke/snacks.nvim",

		priority = 1000,
		lazy = false,

		opts = {
			bigfile = { enabled = true },
			input = { enabled = true },
			bufdelete = { enabled = true },
			rename = { enabled = true },
			scratch = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			statuscolumn = { enabled = true },
			notifier = { enabled = true },

			dashboard = {
				enabled = true,

				preset = {
					header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████]],
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 2 },
					{ section = "startup" },
				},
			},

			terminal = {
				win = {
					keys = {},
				},
			},
		},

    -- stylua: ignore
		keys = {
      { "<leader>b", "", desc = "+buffers" },
			{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer", },
			{ "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffer", },

			{ "<c-/>", function() Snacks.terminal() end, desc = "Open Terminal", },
			{ "<c-_>", function() Snacks.terminal() end, desc = "Open Terminal", },
			{ "<c-/>", "<cmd>close<cr>", mode = "t", desc = "Close Terminal" },
			{ "<c-_>", "<cmd>close<cr>", mode = "t", desc = "Close Terminal" },

			{ "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer", },
			{ "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer", },
		},

		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "OilActionsPost",
				callback = function(event)
					if event.data.actions.type == "move" then
						Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
					end
				end,
			})
		end,
	},
}
