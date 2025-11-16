local status, db = pcall(require, "dashboard")
if not status then
  vim.notify("没有找到 dashboard")
  return
end

db.setup({
theme = 'hyper',
config = {
    week_header = {
        enable = true,
    },
    shortcut = {
        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
        {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
        },
        {
            icon = ' ',
            desc = 'Recently files',
            group = 'Label',
            action = "Telescope oldfiles",
            key = 'r',
        },
        {
            icon = "󰌏 ",
            desc = "Edit keymaps",
            action = "edit ~/.config/nvim/lua/keymaps.lua",
            key = "k",
        },
        -- {
        --     desc = ' Apps',
        --     group = 'DiagnosticHint',
        --     action = 'Telescope app',
        --     key = 'a',
        -- },
        -- {
        --     desc = ' dotfiles',
        --     group = 'Number',
        --     action = 'Telescope dotfiles',
        --     key = 'd',
        -- },
    },
    packages = { enable = true }, -- show how many plugins neovim loaded
    -- project = { enable = true, limit = 8, icon = 'your icon', label = '', action = 'Telescope find_files cwd=' },
    -- mru = { enable = true, limit = 10, icon = 'your icon', label = '', cwd_only = false },
    footer = {" https://github.com/majorzpley?tab=repositories"}, -- footer
},
})