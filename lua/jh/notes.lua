local utils = require("jh.utils")

local m = {}

m.config = {}
m.config.root_path = "~/Notes"
m.config.project_prefix = "project-"

local function find_project_notes(dir)
  local project_name = utils.guess_project_name(dir)
  return m.config.root_path .. "/" .. m.config.project_prefix .. project_name .. ".md"
end

m.open_current_project_notes = function()
  local dir = vim.fn.expand("%:p:h")
  local path = find_project_notes(dir)
  vim.cmd(":e " .. path)
end

m.open_scratch = function()
  local path = m.config.root_path .. "/scratch.md"
  vim.cmd(":split " .. path)
end

m.find_notes = function() require("telescope.builtin").find_files({ cwd = m.config.root_path }) end

return m
