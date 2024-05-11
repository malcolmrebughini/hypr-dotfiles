local function copy_to_clipboard(text) vim.fn.setreg("+", text) end

local function open_url_in_browser(url)
  local command = string.format("xdg-open %s", url) --Linux command (using xdg-open)

  vim.fn.jobstart(command, {
    detach = true,
    cwd = vim.fn.getcwd(),
  })
end

local function get_remote_url()
  local remote_url = vim.fn.trim(vim.fn.system "git config --get remote.origin.url")

  if remote_url:match "^ssh://" then
    local domain = remote_url:match "ssh://([^/]+)"

    local gitconfig_url = vim.fn.trim(vim.fn.system("git config --get-urlmatch url.insteadof ssh://" .. domain))

    if gitconfig_url ~= "" then
      local repo_path = remote_url:match(domain .. "/(.+)%.git$")
      if repo_path then return gitconfig_url:gsub("%.git$", "") .. repo_path end
    end
  end

  local https_url =
    remote_url:gsub("git@([^:]+):", "https://%1/"):gsub("ssh://git@([^:/]+)/", "https://%1/"):gsub("%.git$", "")

  return https_url
end

local function get_current_line_url()
  local git_root = vim.fn.trim(vim.fn.system "git rev-parse --show-toplevel")
  local filename = vim.fn.expand("%:p"):gsub("^" .. git_root .. "/", "")
  local linenr = vim.api.nvim_win_get_cursor(0)[1]

  local relative_filename = vim.fn.trim(vim.fn.system("git ls-files --full-name " .. filename))
  local remote_url = get_remote_url()

  if remote_url then return string.format("%s/blob/master/%s#L%d", remote_url, relative_filename, linenr) end
end

local function copy_line_url()
  local remote_url = get_current_line_url()
  if remote_url then copy_to_clipboard(remote_url) end
end

local function open_line_url()
  local remote_url = get_current_line_url()
  if remote_url then open_url_in_browser(remote_url) end
end

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<C-d>"] = { "<C-d>zz" },
        ["<C-h>"] = { "<C-u>zz" },
        ["<Leader>b"] = { desc = "Buffers" },
        ["<Leader>n"] = { desc = "File/Notifications" },
        ["<Leader>nn"] = { "<cmd>enew<cr>", desc = "New File" },
        ["<Leader>nd"] = { "<cmd>NoiceDismiss<CR>", desc = "Dismiss Notifications" },
        ["<Leader>h"] = { desc = "Harpoon" },
        ["<Leader>hh"] = { function() require("harpoon.ui").toggle_quick_menu() end, desc = "Quick Menu" },
        ["<Leader>ha"] = { function() require("harpoon.mark").add_file() end, desc = "Add file" },
        ["<C-n>"] = { function() require("harpoon.ui").nav_file(1) end },
        ["<C-e>"] = { function() require("harpoon.ui").nav_file(2) end },
        ["<C-i>"] = { function() require("harpoon.ui").nav_file(3) end },
        ["<C-o>"] = { function() require("harpoon.ui").nav_file(4) end },
        ["u"] = { "<up>" },
        ["i"] = { "<right>" },
        ["e"] = { "<down>" },
        ["n"] = { "<left>" },
        ["k"] = { "i" },
        ["<S-Left>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
        ["<S-Down>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
        ["<S-Up>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
        ["<S-Right>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
        ["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
        ["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
        ["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
        ["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
        ["<leader>gm"] = { copy_line_url, desc = "Copy remote link" },
        ["<leader>go"] = { open_line_url, desc = "Open remote link" },
        -- Copilot
        ["<leader>c"] = { desc = "Copilot" },
        ["<leader>cc"] = { desc = "Chat" },
        ["<leader>ccq"] = {
          function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
              require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
            end
          end,
          desc = "CopilotChat - Quick chat",
        },
        ["<leader>cch"] = {
          function()
            local actions = require("CopilotChat.actions")
            require("CopilotChat.integrations.telescope").pick(actions.help_actions())
          end,
          desc = "CopilotChat - Help actions",
        },
        -- Show prompts actions with telescope
        ["<leader>ccp"] = {
          function()
            local actions = require("CopilotChat.actions")
            require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
          end,
          desc = "CopilotChat - Prompt actions",
        },
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

            if copilot.is_visible() then copilot.accept() end
          end,
          desc = "Accept copilot suggestion",
        },
        ["<C-n>"] = { function() require("harpoon.ui").nav_file(1) end },
        ["<C-e>"] = { function() require("harpoon.ui").nav_file(2) end },
        ["<C-i>"] = { function() require("harpoon.ui").nav_file(3) end },
        ["<C-o>"] = { function() require("harpoon.ui").nav_file(4) end },
        ["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" },
      },
      v = {
        ["u"] = { "<up>" },
        ["i"] = { "<right>" },
        ["e"] = { "<down>" },
        ["n"] = { "<left>" },
        ["<leader>sc"] = { ":Silicon<cr>", desc = "Snapshot code" },
        ["<leader>cch"] = {
          function()
            local actions = require("CopilotChat.actions")
            require("CopilotChat.integrations.telescope").pick(actions.help_actions())
          end,
          desc = "CopilotChat - Help actions",
        },
        -- Show prompts actions with telescope
        ["<leader>ccp"] = {
          function()
            local actions = require("CopilotChat.actions")
            require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
          end,
          desc = "CopilotChat - Prompt actions",
        },
      },
    },
  },
}
