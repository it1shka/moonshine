local array = {}

---@generic A, B
---@param target A[]
---@param transformer fun(elem: A, index: integer): B
---@return B[]
function array.map(target, transformer)
  local output = {}
  for index, value in ipairs(target) do
    output[index] = transformer(value, index)
  end
  return output
end

---@generic A
---@param target A[]
---@param selector fun(elem: A, index: integer): boolean
---@return A[]
function array.filter(target, selector)
  local output = {}
  for index, value in ipairs(target) do
    if selector(value, index) then
      output[#output+1] = value
    end
  end
  return output
end

return array
