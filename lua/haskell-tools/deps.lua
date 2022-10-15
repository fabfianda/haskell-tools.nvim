local M = {}

local function require_or_err(modname, err_msg)
  local has_mod, mod = pcall(require, modname)
  if not has_mod then
    error('haskell-tools: ' .. err_msg)
  end
  return mod
end

-- @param module name: The name of the module
-- @param on_available: function(module)
-- @param on_not_available: (optonal) function() | anything
-- @return the return value of on_available or on_not_available
function M.if_available(modname, on_available, on_not_available)
  local has_mod, mod = pcall(require, modname)
  if has_mod then
    return on_available(mod)
  end
  if not on_not_available then
    return nil
  end
  if type(on_not_available) == 'function' 
    then return on_not_available() 
  end
  return on_not_available
end

M.lspconfig = require_or_err('lspconfig', 'This plugin requires the neovim/nvim-lspconfig plugin')

return M
