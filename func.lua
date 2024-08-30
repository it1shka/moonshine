local func = {}

---@param ... (fun (value: any): any)
---@return fun(value: any): any
function func.pipe(...)
  local args = table.pack(...)
  return function (value)
    local acc = value
    for _, fn in ipairs(args) do
      acc = fn(acc)
    end
    return acc
  end
end

---@param ... (fun(value: any): any)
---@return fun(value: any): any
function func.compose(...)
  local args = table.pack(...)
  assert(#args > 0)
  local fn = args[#args]
  for i = #args - 1, 1, -1 do
    local fn_outer = args[i]
    local fn_inner = fn
    fn = function (x)
      return fn_outer(fn_inner(x))
    end
  end
  return fn
end

---@param target fun(...): any
---@param ... any
---@return fun(...): any
function func.curry(target, ...)
  local target_info = debug.getinfo(target)
  assert(not target_info.isvararg)

  if select("#", ...) >= target_info.nparams then
    return target(...)
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

    return func.curry(target, table.unpack(args))
  end
end

return func
