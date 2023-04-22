return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      setup = {
        angularls = function(_, opts)
          opts.on_attach = function(client, _)
            client.server_capabilities.documentRangeFormattingProvider = false
            client.server_capabilities.foldingRangeProvider = false
          end
        end,
      },
    },
  },
}
