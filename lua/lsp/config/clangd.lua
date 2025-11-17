local common = require("lsp.common-config")

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  cmd = {
    "clangd",
    "--background-index",
    "--pch-storage=memory",
    "--clang-tidy",
    "--completion-style=detailed",
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  on_attach = function(client, bufnr)
    common.disableFormat(client)
    common.keyAttach(bufnr)
  end,
}

return {
    on_setup = function(server)
        vim.lsp.config("clangd",{
            cmd = opts.cmd,
            init_options = opts.init_options,
            capabilities = opts.capabilities,
            flags = opts.flags,
            on_attach = opts.on_attach,
        })
        vim.lsp.enable("clangd")
    end,
}