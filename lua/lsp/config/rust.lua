local common = require("lsp.common-config")
local cfg = require("uConfig")
-- local opts = {
--   capabilities = common.capabilities,
--   flags = common.flags,
--   on_attach = function(client, bufnr)
--     common.disableFormat(client)
--     common.keyAttach(bufnr)
--   end,
--   settings = {
--     -- to enable rust-analyzer settings visit:
--     -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
--     ["rust-analyzer"] = {
--       -- enable clippy on save
--       checkOnSave = {
--         command = "clippy",
--       },
--     },
--   },
-- }

-- return {
--   on_setup = function(server)
--     local ok_rt, rust_tools = pcall(require, "rust-tools")
--     if not ok_rt then
--       print("Failed to load rust tools, will set up `rust_analyzer` without `rust-tools`.")
--       server.setup(opts)
--     else
--       -- We don't want to call lspconfig.rust_analyzer.setup() when using rust-tools
--     --   rust_tools.setup({
--     --     server = opts,
--     --     dap = require("dap.nvim-dap.config.rust"),
--     --   })
--     end
--   end,
-- }

return {
    on_setup = function(_)
        -- Do not call the nvim-lspconfig.rust_analyzer setup or set up the LSP client for rust-analyzer manually,
        -- as doing so may cause conflicts.
        vim.g.rustaceanvim = {
            -- Plugin configuration
            tools = {},
            -- LSP configuration
            server = {
                on_attach = function(_, bufnr)
                    common.keyAttach(bufnr)
                    local opt = { noremap = true, silent = true, buffer = bufnr }

                    ---@diagnostic disable-next-line: need-check-nil
                    keymap("n", cfg.lsp.hover, function()
                        vim.cmd.RustLsp({ "hover", "actions" })
                    end, opt)
                    ---@diagnostic disable-next-line: need-check-nil
                    keymap("n", cfg.lsp.code_action, function()
                        vim.cmd.RustLsp("codeAction")
                    end, opt)

                    keymap("n", cfg.lsp.rs_explain_error, function()
                        vim.cmd.RustLsp("explainError", "current")
                    end, opt)
                end,
                default_settings = {
                    -- rust-analyzer language server configuration
                    ["rust-analyzer"] = {},
                },
            },
            -- DAP configuration
            dap = {},
        }
    end,
}