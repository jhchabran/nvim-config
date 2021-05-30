local Job = require('plenary.job')

local m = {}

m.find_git_root = function(dir) 
  local stdout, ret = Job:new({ command = 'git', args = {'rev-parse', '--show-toplevel'}, cwd = dir, on_stderr = function(_, data)
    table.insert(stderr, data)
  end }):sync()
  return stdout[1]
end

m.dirname = function(dir)
  return dir:match("(.*"..'/'..")")
end

m.string_split = function(str, sep) 
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for s in string.gmatch(str, "([^"..sep.."]+)") do
    table.insert(t, s)
  end

  return t
end

m.last_dir_name = function(dir)
  local strs = m.string_split(dir, '/')
  return strs[#strs]
end

m.guess_project_name = function(dir)
  local root = m.find_git_root(dir)
  return m.last_dir_name(root)
end


m.reload_my_lua = function() 
  require('plenary.reload').reload_module('jh.', true)
end

return m
