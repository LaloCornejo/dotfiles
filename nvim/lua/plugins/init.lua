return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

    {
    "github/copilot.vim",
      lazy = true,
      keys = { "<leader>ce" },
      config = function()
          vim.cmd("Copilot setup")  -- Initialize Copilot
          vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
              expr = true,
              replace_keycodes = false,
          })
          vim.keymap.set("n", "<leader>cd", ":Copilot disable <CR>", {})
          vim.keymap.set("n", "<leader>ce", ":Copilot enable <CR>", {})
      end,
    },

  {
    'wakatime/vim-wakatime', lazy = false
  },
}
