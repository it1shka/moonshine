local internal_utils = require("internal_utils")

local object = {}

---@generic A
---@param target table<A, any>
---@return A[]
function object.keys(target)
  local output = {}
  for key in pairs(target) do
    output[#output + 1] = key
  end
  return output
end

---@generic A
---@param target table<any, A>
---@return A[]
function object.values(target)
  local output = {}
  for _, value in pairs(target) do
    output[#output + 1] = value
  end
  return output
end

---@generic A
---@param target A
---@param action fun(target: A): any
---@return A
function object.tap(target, action)
  action(target)
  return target
end

local object_curried = internal_utils.compile_curried_module(object)
object.curried = object_curried

return object
