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
