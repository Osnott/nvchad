return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "nvim-java/nvim-java",
    ft = { "java" },
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
    config = function()
      require("java").setup {
        jdk = {
          auto_install = false,
          version = "17.0.2",
        },
      }
      require("lspconfig").jdtls.setup {
        on_attach = function(client, bufnr)
          vim.keymap.set(
            { "n", "v" },
            "<leader>ca",
            "<cmd>lua require('fastaction').code_action()<CR>)",
            { buffer = bufnr, desc = "LSP Code Action" }
          )
          require("nvchad.configs.lspconfig").on_attach()
        end,
        capabilities = require("nvchad.configs.lspconfig").capabilities,
        filetypes = { "java" },

        handlers = {
          ["$/progress"] = function(_, result, ctx) end,
        },
      }
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
          automatic_installation = true,

          handlers = {},
        },
      },
      "mfussenegger/nvim-dap",
    },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
    },
    opts = {},
    config = function(_, opts)
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close {}
      end
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "nix",
        "java",
        "python",
      },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
      require("trouble").setup()
    end,
  },

  {
    "Chaitanyabsprip/fastaction.nvim",
    event = { "User FilePost" },
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "User FilePost" },
    config = function()
      require("todo-comments").setup()
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          -- override the default lsp markdown formatter with Noice
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          -- override the lsp markdown formatter with Noice
          ["vim.lsp.util.stylize_markdown"] = false,
          -- override cmp documentation with Noice (needs the other options to work)
          ["cmp.entry.get_documentation"] = false,
        },
        hover = {
          enabled = true,
        },
      },
      routes = {
        {
          filter = {
            event = "notify",
            find = "No signature help available",
          },
          opts = { skip = true },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  {
    "kosayoda/nvim-lightbulb",
    event = "User FilePost",
    config = function()
      require("nvim-lightbulb").setup {
        autocmd = { enabled = true },
      }
    end,
  },
  -- {
  --   "kdheepak/lazygit.nvim",
  --   cmd = {
  --     "LazyGit",
  --     "LazyGitConfig",
  --     "LazyGitCurrentFile",
  --     "LazyGitFilter",
  --     "LazyGitFilterCurrentFile",
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   keys = {
  --     { "<leader>lg", "<cmd>LazyGit<cr>", desc = "open LazyGit" },
  --   },
  -- },
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      scratch = { enabled = true },
      scroll = { enabled = true },
      lazygit = { enabled = true },
    },
    keys = {
      {
        "<leader>.",
        function()
          require("snacks").scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          require("snacks").scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader>lg",
        function()
          require("snacks").lazygit.open()
        end,
        desc = "Open lazygit",
      },
    },
  },

  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    dependencies_bin = {
      ["tinymist"] = nil,
      ["websocat"] = nil,
    },
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
}
