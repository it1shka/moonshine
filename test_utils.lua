local test = {}

---@param suite_name string
---@param suite_cases (fun(): boolean)[]
function test.suite(suite_name, suite_cases)
  print("Running " .. suite_name .. " suite: ")
  local passed = 0
  for _, case in ipairs(suite_cases) do
    local ok = case()
    if ok then
      passed = passed + 1
    end
  end
  print(passed .. " passed, " .. (#suite_cases - passed) .. " failed")
end

---@param case_name string
---@param case_fn fun(): any
---@return fun(): boolean
function test.case(case_name, case_fn)
  return function()
    local ok, err = pcall(case_fn)
    if ok then
      print(case_name .. ": passed")
    else
      print(case_name .. ": failed (" .. err .. ")")
    end
    return ok
  end
end

---@param correct any[]
---@param tested any[]
function test.arrayShallowAssert(correct, tested)
  assert(type(tested) == "table", "Not a table")
  assert(#correct == #tested, "Length mismatch")
  for index, value in ipairs(correct) do
    assert(value == tested[index], "Mismatch at index " .. index)
  end
end

return test
