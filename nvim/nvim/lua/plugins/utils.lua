-- local function term_nav(dir)
--   return function(self)
--     return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
--       vim.cmd.wincmd(dir)
--     end)
--   end
-- end

return {
  {
    "folke/snacks.nvim",

    opts = function(_, opts)
      opts.indent.chunk = { enabled = true }
      opts.dashboard.preset.header = [[
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████]]

      opts.terminal.win.keys.nav_h = nil
      opts.terminal.win.keys.nav_l = nil
    end,
  },

  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
  },

  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
  },
}
