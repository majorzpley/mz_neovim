-- https://github.com/kyazdani42/nvim-tree.lua
-- local nvim_tree = require'nvim-tree'

local uConfig = require("uConfig")
local uTree = uConfig.nvimTree

if uTree == nil or not uTree.enable then
  return
end

local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  vim.notify("没有找到 nvim-tree")
  return
end

keymap("n", uTree.toggle, ":NvimTreeToggle<CR>")
local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    keymap("n",uTree.refresh, api.tree.reload, opts("Refresh"))
    -- open / close
    keymap("n",uTree.edit, api.node.open.edit, opts("Open"))
    keymap("n",uTree.system_open, api.node.run.system, opts('Run System'))
    keymap("n",uTree.tabnew, api.node.open.tab, opts('Open: New Tab'))
    keymap("n",uTree.vsplit, api.node.open.vertical, opts('Open: Vertical Split'))
    keymap("n",uTree.split, api.node.open.horizontal, opts('Open: Horizontal Split'))

    --movement
    keymap("n",uTree.dir_up, api.tree.change_root_to_parent, opts('Up'))
    keymap("n",uTree.cd, api.tree.change_root_to_node, opts('CD'))

    -- file toggle
    keymap("n",uTree.toggle_git_ignored, api.tree.toggle_gitignore_filter, opts('Toggle Git Ignored'))
    keymap("n", uTree.toggle_dotfiles, api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
    keymap("n", uTree.toggle_custom, api.tree.toggle_custom_filter, opts("Toggle Hidden"))

    -- file operations
    keymap("n",uTree.create, api.fs.create, opts('Create'))
    keymap("n",uTree.remove, api.fs.remove, opts('Delete'))
    keymap("n",uTree.rename, api.fs.rename, opts('Rename'))
    keymap("n",uTree.copy, api.fs.copy.node, opts('Copy'))
    keymap("n",uTree.cut, api.fs.cut, opts('Cut'))
    keymap("n",uTree.paste, api.fs.paste, opts('Paste'))
    keymap("n",uTree.copy_name, api.fs.copy.filename, opts('Copy Name'))
    keymap("n",uTree.copy_path, api.fs.copy.relative_path, opts('Copy Relative Path'))
    keymap("n",uTree.copy_absolute_path, api.fs.copy.absolute_path, opts('Copy Absolute Path'))
    keymap("n",uTree.toggle_file_info, api.node.show_info_popup, opts('File Info'))
end 
-- 列表操作快捷键
-- local list_keys = { -- 打开文件或文件夹
--   {
--     key = uTree.edit,
--     action = "edit",
--   },
--   {
--     key = uTree.system_open,
--     action = "system_open",
--   }, -- v分屏打开文件
--   {
--     key = uTree.vsplit,
--     action = "vsplit",
--   }, -- h分屏打开文件
--   {
--     key = uTree.split,
--     action = "split",
--   }, -- gitignore
--   {
--     key = uTree.toggle_git_ignored,
--     action = "toggle_git_ignored",
--   }, -- Hide (dotfiles)
--   {
--     key = uTree.toggle_dotfiles,
--     action = "toggle_dotfiles",
--   }, -- toggle filters > custom
--   {
--     key = uTree.toggle_custom,
--     action = "toggle_custom",
--   },
--   {
--     key = uTree.refresh,
--     action = "refresh",
--   }, -- 文件操作
--   {
--     key = uTree.create,
--     action = "create",
--   },
--   {
--     key = uTree.remove,
--     action = "remove",
--   },
--   {
--     key = uTree.rename,
--     action = "rename",
--   },
--   {
--     key = uTree.copy,
--     action = "copy",
--   },
--   {
--     key = uTree.cut,
--     action = "cut",
--   },
--   {
--     key = uTree.paste,
--     action = "paste",
--   },
--   {
--     key = uTree.copy_name,
--     action = "copy_name",
--   },
--   {
--     key = uTree.copy_path,
--     action = "copy_path",
--   },
--   {
--     key = uTree.copy_absolute_path,
--     action = "copy_absolute_path",
--   },
--   {
--     key = uTree.toggle_file_info,
--     action = "toggle_file_info",
--   },
--   {
--     key = uTree.tabnew,
--     action = "tabnew",
--   }, -- 进入下一级
--   {
--     key = uTree.cd,
--     action = "cd",
--   }, -- 进入上一级
--   {
--     key = uTree.dir_up,
--     action = "dir_up",
--   },
-- }

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
  on_attach = my_on_attach,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  git = {
    enable = true,
    ignore = true,
  },
  filters = {
    -- 隐藏 .文件
    dotfiles = true,
    -- 隐藏 00_env 文件夹,即 toogle_custom 使用
    -- custom = { "00_env" },
  },
  view = {
    -- 宽度
    width = 34,
    -- 也可以 'right'
    side = "left",
    relativenumber = false,
    signcolumn = "yes",
  },
  actions = {
    open_file = {
      -- 首次打开大小适配
      resize_window = true,
      -- 打开文件时关闭 tree
      quit_on_open = false,
    },
  },
  -- wsl install -g wsl-open
  -- https://github.com/4U6U57/wsl-open/
  system_open = {
    -- mac
    cmd = "open",
    -- windows
    -- cmd = "wsl-open",
  },
  renderer = {
    root_folder_label = false,
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "after",
    },
  },
})