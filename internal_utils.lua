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

---@param target fun(...): any
---@param ... any
---@return fun(...): any
function internal_utils.reverse_curry(target, ...)
  local target_size = debug.getinfo(target).nparams

  if select("#", ...) >= target_size then
    local args = table.pack(...)
    local reversed_args = {}
    for index, value in ipairs(args) do
      local reverse_index = args.n - index + 1
      reversed_args[reverse_index] = value
    end
    return target(table.unpack(reversed_args))
  end

  local outer_args = { ... }
  return function (...)
    local inner_args = { ... }

    local args = {}
    for _, each in ipairs(outer_args) do
      args[#args + 1] = each
    end
    for _, each in ipairs(inner_args) do
      args[#args + 1] = each
    end

    return internal_utils.reverse_curry(target, table.unpack(args))
  end
end

---@param module table<string, fun(...): any>
---@return table<string, fun(...): any>
function internal_utils.compile_curried_module(module)
  local output = {}
  for fn_name, fn_obj in pairs(module) do
    local fn_info = debug.getinfo(fn_obj)
    if fn_info.isvararg or fn_info.nparams < 2 then
      output[fn_name] = fn_obj
    else
      output[fn_name] = internal_utils.reverse_curry(fn_obj)
    end
  end
  return output
end

return internal_utils
