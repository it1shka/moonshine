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

return func
