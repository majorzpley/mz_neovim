--TODO:
--HACK:
--PERF:
--NOTE:
--FIX:
--WARNING:
local status, todo = pcall(require, "todo-comments")
if not status then
  vim.notify("没有找到 todo-comments")
  return
end

todo.setup({
  signs = true,
  sign_priority = 8,
  keywords = {
    FIX = { icon = " ", color = "error", alt = {"FIXME","BUG"} },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = {"WARNING"} },
    PERF = { icon = " ", color = "hint", alt = {"OPTIM","PERFORMANCE"} },
    NOTE = { icon = " ", color = "hint", alt = {"INFO"} },
  },
  highlight = {
    multiline = true,
    before = "",
    keyword = "wide",
    after = "",
  },
  search = {
    command = "rg",
    args = {"--line-number", "--no-heading", "--color", "never"},
    pattern = [[\b(KEYWORDS):?]],
  },
})
