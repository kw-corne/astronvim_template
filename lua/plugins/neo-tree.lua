return {
  "nvim-neo-tree/neo-tree.nvim",
  ---@type AstroCoreOpts
  opts = {
    source_selector = {
      winbar = true,
      statusline = false,
      sources = {
        { source = "filesystem" },
      },
    },
  },
}
