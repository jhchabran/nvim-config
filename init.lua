-- local hotpot_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/hotpot.nvim'
--
-- if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
--   print("Could not find hotpot.nvim, cloning new copy to", hotpot_path)
--   vim.fn.system({'git', 'clone',
--                  'https://github.com/rktjmp/hotpot.nvim', hotpot_path})
--   vim.cmd("helptags " .. hotpot_path .. "/doc")
-- end

-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "--single-branch",
--     "https://github.com/folke/lazy.nvim.git",
--     lazypath,
--   })
-- end
-- vim.opt.runtimepath:prepend(lazypath)

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
	local plugin_path = vim.fn.stdpath("data") .. "/boot/" .. plugin_name
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
assert_installed_plugin("folke/lazy.nvim")

if pcall(require, "hotpot") then
	-- Setup hotpot.nvim
	require("hotpot").setup({
		provide_require_fennel = true,
	})
	-- Import neovim configuration
  require("conf")
else
	print("Unable to require hotpot")
end
--
-- -- tweaked version of the snippet at https://neovim.io/doc/user/tabpage.html
-- vim.cmd([[
-- 	function MyTabLine()
-- 	  let s = ''
-- 	  for i in range(tabpagenr('$'))
-- 	    " select the highlighting
-- 	    if i + 1 == tabpagenr()
-- 	      let s .= '%#TabLineSel#'
-- 	    else
-- 	      let s .= '%#TabLine#'
-- 	    endif
--
-- 	    " set the tab page number (for mouse clicks)
-- 	    let s .= '%' . (i + 1) . 'T'
--
-- 	    " the label is made by MyTabLabel()
-- 	    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
-- 	  endfor
--
-- 	  " after the last tab fill with TabLineFill and reset tab page nr
-- 	  let s .= '%#TabLineFill#%T'
--
-- 	  return s
-- 	endfunction
--
-- 	function MyTabLabel(n)
-- 	  let buflist = tabpagebuflist(a:n)
-- 	  let winnr = tabpagewinnr(a:n)
-- 	  return bufname(buflist[winnr - 1]) . '(' . tabpagewinnr(a:n, '$') . ')'
-- 	endfunction
--
--   set tabline=%!MyTabLine()
-- ]])
--
-- vim.cmd[[colorscheme tokyonight]]
-- -- vim.cmd[[colorscheme lumona]]
-- vim.cmd[[packadd cfilter]]
