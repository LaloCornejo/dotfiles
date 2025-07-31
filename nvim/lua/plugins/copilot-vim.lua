-- NOTE: Only enable either copilot-vim or codeium-vim at the same time
return {
  -- Use native snippets from Neovim v0.10
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- Disable ghost text for nvim-cmp, use copilot suggestion instead
      opts.experimental.ghost_text = false
    end,
    keys = function() return {} end,
  },
  -- Setup copilot.vim
  {
    "github/copilot.vim",
    version = "v1.42.0",
    event = "VeryLazy",
    config = function()
      -- For copilot.vim
      -- enable copilot for specific filetypes
      vim.g.copilot_filetypes = {
        ["TelescopePrompt"] = true,
      }

      -- Set to true to assume that copilot is already mapped
      vim.g.copilot_assume_mapped = true
      -- Set workspace folders
      vim.g.copilot_workspace_folders = "~/Projects"

      -- Setup keymaps
      local keymap = vim.keymap.set
      local opts = { silent = true }

      -- Set <C-y> to accept copilot suggestion
      keymap("i", "<tab>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })

      -- Set <C-i> to accept line
      keymap("i", "<C-i>", "<Plug>(copilot-accept-line)", opts)

      -- Set <C-j> to next suggestion, <C-k> to previous suggestion, <C-l> to suggest
      keymap("i", "<C-j>", "<Plug>(copilot-next)", opts)
      keymap("i", "<C-k>", "<Plug>(copilot-previous)", opts)
      keymap("i", "<C-l>", "<Plug>(copilot-suggest)", opts)

      -- Set <C-d> to dismiss suggestion
      keymap("i", "<C-d>", "<Plug>(copilot-dismiss)", opts)
    end,
  },
  -- Add status line icon for copilot
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      -- Ensure sections table exists
      if not opts.sections then return opts end
      opts.sections.lualine_x = opts.sections.lualine_x or {}
      
      table.insert(opts.sections.lualine_x, {
        function()
          return ""  -- Copilot icon
        end,
        cond = function()
          if vim.g.loaded_copilot then
            local copilot_status = vim.fn["copilot#Enabled"]()
            return copilot_status == 1
          end
          return false
        end,
        color = function() 
          return { fg = "#6CC644" }  -- Green color for active
        end,
      })
      return opts
    end,
  },
}
