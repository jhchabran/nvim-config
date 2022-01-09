local Job = require("plenary.job")

local m = {}

m.find_git_root = function(dir)
  local stderr = {}
  local stdout = Job:new({
    command = "git",
    args = { "rev-parse", "--show-toplevel" },
    cwd = dir,
    on_stderr = function(_, data) table.insert(stderr, data) end,
  }):sync()
  return stdout[1]
end

m.dirname = function(dir) return dir:match("(.*" .. "/" .. ")") end

m.last_dir_name = function(dir)
  local strs = vim.split(dir, "/")
  return strs[#strs]
end

m.guess_project_name = function(dir)
  local root = m.find_git_root(dir)
  return m.last_dir_name(root)
end

m.current_buffer_parent_dir = function()
  return vim.fn.expand('%:p:h')
end

m.reload_my_lua = function() require("plenary.reload").reload_module("jh.", true) end

-- m.dump_mappings = function()
--   local wk = require("which-key.keys")
--   -- SPC is the leader, but the mappings reference the real key, so the key is " ", not <leader>.
--   local mappings = _G.dump(wk.mappings["n"].tree.root.children[" "])
--   local acc = []

--   local cur = mappings
--     while v ~= nil do
--       for k, v in pairs(cur) do

--       end
--     end

--     for kk,vv in pairs(v.children) do
--   end
-- end

m.dump_which_key_markdown = function(opts)
  local out = {}

  local indent = function(level)
    local str = ""
    for i=0,level,1 do
      str = str .. "  "
    end
    return str
  end

  local dump = function(key, label, level)
    return indent(level) .. "- `" .. key .. "`: " .. label
  end

  local fn
  fn = function(node, level)
    for k, v in pairs(node) do
      if v.name ~= nil then
        local key = k
        table.insert(out, dump(k, "**" .. v.name .. "**", level))
        fn(v, level+1)
      else
        if k ~= "name" then
          table.insert(out, dump(k, v[2], level))
        end
      end
    end
  end

  fn(opts, 0)

  local res = ""
  for i, line in ipairs(out) do
    res = res .. line .. "\n"
  end

  -- Put in the OS clipboard the result
  vim.fn.setreg('+', res)
end

return m
