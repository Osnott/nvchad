-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "nixd", "clangd" }
local nvlsp = require "nvchad.configs.lspconfig"

local ooo = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>lua require('fastaction').code_action()<CR>)",
    { buffer = bufnr, desc = "LSP Code Action" })
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = ooo,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
