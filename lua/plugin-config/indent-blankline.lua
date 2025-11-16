-- https://github.com/lukas-reineke/indent-blankline.nvim现在api已经更新至V3版本
local status, ibl = pcall(require, "ibl")
if not status then
  vim.notify("没有找到 indent_blankline")
  return
end

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

-- require("ibl").setup { indent = { highlight = highlight } }

ibl.setup({
  indent = {
    -- 竖线样式
    -- char = '¦'
    -- char = '┆'
    -- char = '│'
    -- char = "⎸",
    -- char = "▏",
    highlight = highlight,
  },
  scope = {
    -- enable = true,
    show_start = true,
    highlight = "IblScope",
  },
  exclude = {
    filetypes = {
      "null-ls-info",
      "dashboard",
      "packer",
      "terminal",
      "help",
      "log",
      "markdown",
      "TelescopePrompt",
      "lsp-installer",
      "lspinfo",
      "toggleterm",
      "text",
    },
  },
})
