-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",

  hl_override = {
    ["@comment"] = { italic = true },
    Comment = { italic = true },
    Type = { italic = true },
    Function = { italic = true },
    Keyword = { italic = true },
  },

  integrations = { "trouble" },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
  },

  cmp = {
    style = "atom",
  },

  statusline = {
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "wc", "diagnostics", "lsp", "cwd", "cursor" },
    -- TODO: Make this toggleale?
    modules = {
      wc = function()
        if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "" then
          return vim.fn.wordcount().visual_words
        else
          return vim.fn.wordcount().words
        end
      end,
    },
  },
}

M.lsp = {
  signature = false,
}

M.term = {
  float = {
    row = 0.08,
    col = 0.04,
    width = 0.9,
    height = 0.8,
  },
}

return M
