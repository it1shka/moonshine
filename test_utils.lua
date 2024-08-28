local test = {}

function test.start_testing()
  test.totalTests = 0
  test.totalSuits = 0
  test.passedTests = 0
  test.passedSuits = 0
end

function test.end_testing()
  local testPercentage = math.floor(test.passedTests / test.totalTests * 100 + 0.5)
  local suitPercentage = math.floor(test.passedSuits / test.totalSuits * 100 + 0.5)
  print(test.passedTests .. "/" .. test.totalTests .. " tests passed (" .. testPercentage .. "%)")
  print(test.passedSuits .. "/" .. test.totalSuits .. " suits passed (" .. suitPercentage .. "%)")
  if test.passedSuits == test.totalSuits then
    print("Everything is OK")
  else
    print("Some tests failed")
  end
end

---@param suite_name string
---@param suite_cases (fun(): boolean)[]
function test.suite(suite_name, suite_cases)
  print("Running " .. suite_name .. " suite: ")
  test.totalSuits = test.totalSuits + 1
  local passed = 0
  for _, case in ipairs(suite_cases) do
    test.totalTests = test.totalTests + 1
    local ok = case()
    if ok then
      test.passedTests = test.passedTests + 1
      passed = passed + 1
    end
  end
  if #suite_cases == passed then
    test.passedSuits = test.passedSuits + 1
  end
  print(passed .. " passed, " .. (#suite_cases - passed) .. " failed")
  print()
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

---@generic A
---@param value A
---@return fun(): A
function test.const_function(value)
  return function()
    return value
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
