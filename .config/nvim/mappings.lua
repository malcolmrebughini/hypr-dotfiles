-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    ["<leader>n"] = { desc = "File/Notifications" },
    ["<leader>nn"] = { "<cmd>enew<cr>", desc = "New File" },
    ["<leader>nd"] = { "<cmd>NoiceDismiss<CR>", desc = "Dismiss Notifications"},
    ["<leader>h"] = { desc = "Harpoon" },
    ["<leader>hh"] = { function() require('harpoon.ui').toggle_quick_menu() end, desc = "Quick Menu" },
    ["<leader>ha"] = { function() require('harpoon.mark').add_file() end, desc = "Add file" },
    ["<C-n>"] = { function() require("harpoon.ui").nav_file(1) end },
    ["<C-e>"] = { function() require("harpoon.ui").nav_file(2) end },
    ["<C-i>"] = { function() require("harpoon.ui").nav_file(3) end },
    ["<C-o>"] = { function() require("harpoon.ui").nav_file(4) end },
    ["u"] = {"<up>"},
    ["i"] = {"<right>"},
    ["e"] = {"<down>"},
    ["n"] = {"<left>"},
    ["k"] = {"i"},
    ["<C-d>"] = {"<C-d>zz"},
    ["<C-h>"] = {"<C-u>zz"},
    ["<S-Left>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    ["<S-Down>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
    ["<S-Up>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
    ["<S-Right>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
    ["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    ["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    ["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    ["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    --["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    --["<leader>bD"] = {
    --  function()
    --    require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
    --  end,
    --  desc = "Pick to close",
    --},
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    --["<leader>b"] = { name = "Buffers" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  i = {
    ["<S-Enter>"] = { 
      function()
        local copilot = require "copilot.suggestion"

        if copilot.is_visible() then
          copilot.accept()
        end
      end,
      desc = "Accept copilot suggestion"
    },
    ["<C-n>"] = { function() require("harpoon.ui").nav_file(1) end },
    ["<C-e>"] = { function() require("harpoon.ui").nav_file(2) end },
    ["<C-i>"] = { function() require("harpoon.ui").nav_file(3) end },
    ["<C-o>"] = { function() require("harpoon.ui").nav_file(4) end },
    ["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" },
  },
  v = {
    ["u"] = {"<up>"},
    ["i"] = {"<right>"},
    ["e"] = {"<down>"},
    ["n"] = {"<left>"},
  },
}
