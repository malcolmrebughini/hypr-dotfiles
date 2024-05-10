return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignore = true,
                hide_by_name = {"node_modules"},
            }
      },
      window = {
        width = 50,
        position = "right",
        mappings = {
            n = "parent_or_close",
            i = "child_or_open",
            e = false,
            u = false,
        },
      },
    },
  }
