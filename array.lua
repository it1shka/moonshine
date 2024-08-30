local internal_utils = require("internal_utils")

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

---@generic A
---@param target A[]
---@param selector fun(elem: A, index: integer): boolean
---return A?
function array.find(target, selector)
  for index, value in ipairs(target) do
    if selector(value, index) then
      return value
    end
  end
  return nil
end

---@generic A
---@param ... A[]
---@return A[]
function array.concat(...)
  local args = table.pack(...)
  local output = {}
  for _, arr in ipairs(args) do
    for _, each in ipairs(arr) do
      output[#output + 1] = each
    end
  end
  return output
end

---@generic A
---@param target A[]
---@param selector fun(elem: A, index: integer): boolean
---@return boolean
function array.every(target, selector)
  for index, value in ipairs(target) do
    if not selector(value, index) then
      return false
    end
  end
  return true
end

---@generic A
---@param length integer
---@param construct (A | fun(index: integer): A)
---@return A[]
function array.sequence(length, construct)
  assert(length >= 0, "Sequence length should be non-negative")
  local output = {}
  for i = 1, length do
    if internal_utils.is_callable(construct) then
      output[i] = construct(i)
    else
      output[i] = construct
    end
  end
  return output
end

---@generic A
---@param target A[]
---@param selector (A | fun(elem: A, index: integer): boolean)
---@return integer?
function array.find_index(target, selector)
  for index, value in ipairs(target) do
    local flag
    if internal_utils.is_callable(selector) then
      flag = selector(value, index)
    else
      flag = selector == value
    end
    if flag then
      return index
    end
  end
  return nil
end

---@generic A
---@alias Rec (A | Rec[])
---@param target Rec[]
function array.flatten(target)
  local output = {}
  for _, value in ipairs(target) do
    if internal_utils.is_array(value) then
      local flattened = array.flatten(value)
      for _, each in ipairs(flattened) do
        output[#output + 1] = each
      end
    else
      output[#output + 1] = value
    end
  end
  return output
end

---@generic A, B
---@param target A[]
---@param transformer fun(elem: A, index: integer): (B | B[])
---@return B[]
function array.flat_map(target, transformer)
  local output = {}
  for index, value in ipairs(target) do
    local transformed = transformer(value, index)
    if internal_utils.is_array(transformed) then
      for _, each in ipairs(transformed) do
        output[#output + 1] = each
      end
    else
      output[#output + 1] = transformed
    end
  end
  return output
end

---@generic A
---@param target A[]
---@param action fun(elem: A, index: integer): any
function array.for_each(target, action)
  for index, value in ipairs(target) do
    action(value, index)
  end
end

---@generic A
---@param target A[]
---@param selector (A | fun(elem: A, index: integer): boolean)
---@return boolean
function array.contains(target, selector)
  for index, value in ipairs(target) do
    local flag
    if internal_utils.is_callable(selector) then
      flag = selector(value, index)
    else
      flag = (value == selector)
    end
    if flag then
      return true
    end
  end
  return false
end

return array
