local internal_utils = {}

---@param target any
---@return boolean
function internal_utils.is_callable(target)
  if type(target) == "function" then
    return true
  end
  local meta = getmetatable(target)
  if meta and meta.__call then
    return true
  end
  return false
end

return internal_utils
