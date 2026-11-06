local plugings = {
  -- LSP servers come from Nix (home/neovim.nix extraPackages), and Mason's
  -- prebuilt binaries need programs.nix-ld, which is off.
  { "mason-org/mason.nvim", enabled = false },
  {
    "nvim-tree.lua",
    opts = {
      view = {
        width = 40,
        relativenumber = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.hl",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mhartington/formatter.nvim",
        config = function()
          require "configs.formatter"
        end,
      },
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            local configs = require "nvchad.configs.lspconfig"
            configs.on_attach(client, bufnr)
          end,
        },
      }
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local config = require "nvchad.configs.telescope"
      local telescopeConfig = require "telescope.config"

      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      config.defaults.vimgrep_arguments = vimgrep_arguments
      config.pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      }

      return config
    end,
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {},
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
    lazy = false,
  },
}
return plugings
