return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    specs = {
      {
        "akinsho/bufferline.nvim",
        init = function()
          local bufline = require("catppuccin.groups.integrations.bufferline")
          function bufline.get()
            return bufline.get_theme()
          end
        end,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
