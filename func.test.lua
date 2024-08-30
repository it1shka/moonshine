local test = require("test_utils")
local func = require("func")

test.suite("func.pipe", {
  test.case("completely empty", function()
    local result = func.pipe()()
    test.valueAssert(nil, result)
  end),
  test.case("empty pipe", function()
    local result = func.pipe()("Lua")
    test.valueAssert("Lua", result)
  end),
  test.case("chained operations", function()
    local result = func.pipe(
      function (x)
        return x + 1
      end,
      function (x)
        return x * 3
      end,
      function (x)
        return x - 1
      end
    )(1)
    test.valueAssert(5, result)
  end),
  test.case("without value", function()
    local result = func.pipe(
      test.const_function(5),
      function (x)
        return x - 1
      end,
      function (x)
        return x * 3
      end
    )()
    test.valueAssert(12, result)
  end),
})

test.suite("func.compose", {

})

test.suite("func.curry", {

})

test.suite("func.memo", {

})
