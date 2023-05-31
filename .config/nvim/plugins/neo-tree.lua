return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 30,
        mappings = {
            n = "parent_or_close",
            i = "child_or_open",
            e = false,
            u = false,
        },
      },
    },
  }
