return {
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "snacks.nvim",

    opts = {
      picker = {
        enabled = true,
        exclude = {
          ".git",
          "node_modules",
          "Library",
          "Applications",
        },
        sources = {
          explorer = {
            hidden = true,
            auto_close = true,
            layout = {
              layout = {
                position = "right",
              },
            },
          },
        },
      },
      explorer = { enabled = true },
    },
  },
  {
    "stevearc/oil.nvim",

    dependencies = { "mini.icons", "malewicz1337/oil-git.nvim" },

    opts = {
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
        ["<esc>"] = { "actions.close", mode = "n" },
      },
    },

    --stylua: ignore
    keys = {
      { "-", "<cmd>Oil<cr>",                                 desc = "Open Parent Directory in Oil" },
      { "_", function() vim.cmd("Oil " .. vim.uv.cwd()) end, desc = "Open CWD in Oil" },
    },
  },
  {
    "stevearc/quicker.nvim",

    ft = "qf",
    opts = {},

    config = function(_, opts)
      local quicker = require("quicker")

      quicker.setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("quicker-augroup", { clear = true }),
        pattern = "qf",
        callback = function(args)
          vim.keymap.set("n", ">", function()
            quicker.expand({ before = 2, after = 2, add_to_existing = true })
          end, { buffer = args.buf })

          vim.keymap.set("n", "<", function()
            quicker.collapse()
          end, { buffer = args.buf })
        end,
      })
    end,
  },
}
