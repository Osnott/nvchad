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
}

M.lsp = {
  signature = false,
}

return M
