-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    -- nvim-notify 通知插件
    {
      "rcarriga/nvim-notify",
      config = function()
        require("plugin-config.nvim-notify")
      end,
    },
    -- nvim-tree 侧边栏
    {
      "kyazdani42/nvim-tree.lua",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("plugin-config.nvim-tree")
      end,
    },
    -- bufferline 标签栏
    {
      "akinsho/bufferline.nvim",
      dependencies = { 
        "nvim-tree/nvim-web-devicons",
        "moll/vim-bbye" 
      },
      config = function()
        require("plugin-config.bufferline")
      end,
    },
    -- lualine 状态栏
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { 
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("plugin-config.lualine")
      end,
    },
    -- telescope 模糊查找
    {
      "nvim-telescope/telescope.nvim",
      -- opt = true,
      -- cmd = "Telescope",
      dependencies = {
        -- telescope extensions
        "LinArcX/telescope-env.nvim",
        "nvim-telescope/telescope-ui-select.nvim" 
      },
      config = function()
        require("plugin-config.telescope")
      end,
    },
    -- dashboard-nvim 启动页
    {
      "nvimdev/dashboard-nvim",
      event = "VimEnter",
      config = function()
        require("plugin-config.dashboard")
      end,
      dependencies = { 
        "nvim-tree/nvim-web-devicons",
      }
    },
    -- project 项目管理
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("plugin-config.project")
      end,
    },
    -- treesitter 语法高亮
    {
      "nvim-treesitter/nvim-treesitter",
      -- branch = "master",
      -- lazy = false,
      -- build = ":TSUpdate",
      run = function()
        -- require("nvim-treesitter.install").update({ with_sync = true })
      end,
      dependencies = {
        -- { "p00f/nvim-ts-rainbow" },
        { "HiPhish/rainbow-delimiters.nvim" },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
        { "windwp/nvim-ts-autotag" },
        { "nvim-treesitter/nvim-treesitter-refactor" },
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
      config = function()
        require("plugin-config.nvim-treesitter")
      end,
    },
    -- indent-blankline 缩进线
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ib1",
      ---@module "ibl"
      ---@type ibl.config
      config = function()
        require("plugin-config.indent-blankline")
      end,
    },
    -- toggleterm 终端
    {
      "akinsho/toggleterm.nvim",
      config = function()
        require("plugin-config.toggleterm")
      end,
    },
    -- nvim-surround 括号引号等成对符号操作
    {
      "kylechui/nvim-surround",
      config = function()
        require("plugin-config.nvim-surround")
      end,
    },
    -- Comment 注释插件
    {
      "numToStr/Comment.nvim",
      config = function()
        require("plugin-config.comment")
      end,
    },
    -- nvim-autopairs 自动补全括号引号
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("plugin-config.nvim-autopairs")
      end,
    },
    -- fidget.nvim LSP状态
    {
      "j-hui/fidget.nvim",
      config = function()
        require("plugin-config.fidget")
      end,
    },
    -- todo comments.nvim 待办事项高亮
    {
      "folke/todo-comments.nvim",
      dependencies = {"nvim-lua/plenary.nvim"},
      -- opts = {},
      config = function()
        require("plugin-config.todo-comments")
      end,
    },
    -- which-key 按键提示
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
      },
    },
    -- LSP 语言服务器相关插件
    {
      -- installer
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Lspconfig
      "neovim/nvim-lspconfig",
    },
    -- themes 主题
    {
      -- tokyonight
      {
        "folke/tokyonight.nvim",
        config = function()
          require("plugin-config.tokyonight")
        end,
      },

      -- OceanicNext
      { "mhartington/oceanic-next", event = "VimEnter" },

      -- gruvbox
      -- {
      --   "ellisonleao/gruvbox.nvim",
      --   dependencies = { "rktjmp/lush.nvim" },
      -- },

      -- zephyr
      {"glepnir/zephyr-nvim"},

      -- nord
      {"shaunsingh/nord.nvim"},

      -- onedark
      -- use("ful1e5/onedark.nvim")

      -- nightfox
      -- use("EdenEast/nightfox.nvim")
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
