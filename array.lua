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

---@generic A, B
---@param target A[]
---@param reducer fun(acc: B, elem: A, index: integer): B
---@param initial B?
---@return B
function array.reduce(target, reducer, initial)
  local acc, start
  if initial ~= nil then
    acc = initial
    start = 1
  else
    acc = target[1]
    start = 2
  end
  for i = start, #target do
    acc = reducer(acc, target[i], i)
  end
  return acc
end

return array
