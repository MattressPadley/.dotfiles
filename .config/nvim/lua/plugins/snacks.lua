return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      git_untracked = true,
      ignored = true,
      hidden = true,
      sources = {
        files = {
          hidden = true,
        },
        explorer = {
          layout = { layout = { position = "right" } },
        },
      },
    },
  },
}
