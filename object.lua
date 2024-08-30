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

return object
