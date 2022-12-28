-- A function that applies passes the output of string.format to the print
-- function
---@param string string #template string
local function fprint(string, ...)
  print(string.format(string, ...))
end
--
-- A function that verifies if the plugin passed as a parameter is installed,
-- if it isn't it will be installed
---@param plugin string #the plugin, must follow the format `username/repository`
---@param branch string? #the branch of the plugin
local function assert_installed_plugin(plugin, branch)
  local _, _, plugin_name = string.find(plugin, [[%S+/(%S+)]])
  local plugin_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/" .. plugin_name
  if vim.fn.empty(vim.fn.glob(plugin_path)) ~= 0 then
    fprint("Couldn't find '%s', cloning new copy to %s", plugin_name, plugin_path)
    if branch ~= nil then
      vim.fn.system({
        "git",
        "clone",
        "https://github.com/" .. plugin,
        "--branch",
        branch,
        plugin_path,
      })
    else
      vim.fn.system({
        "git",
        "clone",
        "https://github.com/" .. plugin,
        plugin_path,
      })
    end
  end
  vim.opt.runtimepath:prepend(plugin_path)
end

assert_installed_plugin("rktjmp/hotpot.nvim", "nightly")
assert_installed_plugin("wbthomason/packer.nvim")

if pcall(require, "hotpot") then
  -- Setup hotpot.nvim
  require("hotpot").setup({
    provide_require_fennel = true,
    -- show fennel compiler results in when editing fennel files
    enable_hotpot_diagnostics = true,
    compiler = {
      -- options passed to fennel.compile for modules, defaults to {}
      modules = {
        -- not default but recommended, align lua lines with fnl source
        -- for more debuggable errors, but less readable lua.
        correlate = true
      },
      macros = {
        -- allow macros to access vim global, needed for nyoom modules
        env = "_COMPILER",
        compilerEnv = _G,
        allowGlobals = true,
      },
    }
  })
  -- Import neovim configuration
  require("conf")
else
  print("Unable to require hotpot")
end

-- vim.cmd[[colorscheme tokyonight]]
-- -- vim.cmd[[colorscheme lumona]]
-- vim.cmd[[packadd cfilter]]
