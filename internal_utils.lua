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

---@param target any
---@return boolean
function internal_utils.is_array(target)
  if type(target) ~= "table" then
    return false
  end
  local max_key = 0
  for key in pairs(target) do
    if math.type(key) ~= "integer" then
      return false
    end
    max_key = math.max(max_key, key)
  end
  return max_key == #target
end

return internal_utils
