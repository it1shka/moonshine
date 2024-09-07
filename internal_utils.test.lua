local test = require("test_utils")
local internal_utils = require("internal_utils")

test.suite("internal_utils.is_callable", {
  test.case("function", function()
    local result = internal_utils.is_callable(test.const_function("Lua"))
    test.valueAssert(true, result)
  end),
  test.case("not a function", function()
    local notFunctions = {1, nil, "Lua", {}}
    for _, each in ipairs(notFunctions) do
      local result = internal_utils.is_callable(each)
      test.valueAssert(false, result)
    end
  end),
  test.case("callable table", function()
    local callable_table = {}
    setmetatable(callable_table, {
      __call = test.const_function("Lua"),
    })
    assert(callable_table() == "Lua")
    local result = internal_utils.is_callable(callable_table)
    test.valueAssert(true, result)
  end),
})

test.suite("internal_utils.is_array", {
  test.case("empty array is an array", function()
    local result = internal_utils.is_array({})
    test.valueAssert(true, result)
  end),
  test.case("not arrays by type", function()
    local cases = {1, "Lua", nil, test.const_function("Lua")}
    for _, each in ipairs(cases) do
      local result = internal_utils.is_array(each)
      test.valueAssert(false, result)
    end
  end),
  test.case("not arrays by semantics", function()
    local cases = {
      {
        a = 1,
        b = 2
      },
      {
        name = "Tikhon",
        surname = "Belousov"
      },
    }
    for _, each in ipairs(cases) do
      local result = internal_utils.is_array(each)
      test.valueAssert(false, result)
    end
  end),
  test.case("are arrays", function()
    local cases = {
      {1, 2, 3, 4, 5},
      {"Lua", "C++", "Python"},
    }
    for _, each in ipairs(cases) do
      local result = internal_utils.is_array(each)
      test.valueAssert(true, result)
    end
  end),
  test.case("arrays with holes are not arrays", function()
    local arr = {}
    arr[1] = "Lua"
    arr[3] = "C++"
    arr[10] = "JavaScript"
    local result = internal_utils.is_array(arr)
    test.valueAssert(false, result)
  end),
})

test.suite("internal_utils.reverse_curry", {
  -- TODO:
})

test.suite("internal_utils.compile_curried_module", {
  -- TODO:
})
