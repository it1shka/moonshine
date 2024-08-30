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
  test.case("single function", function()
    local result = func.compose(test.const_function("Lua"))()
    test.valueAssert("Lua", result)
  end),
  test.case("composed chain", function()
    local composed = func.compose(
      function (x)
        return x + 1
      end,
      function (x)
        return x * 2
      end,
      function (x)
        return x + 2
      end
    )
    local result = composed(3)
    test.valueAssert(11, result)
  end),
})

test.suite("func.curry", {
  test.case("simple case", function()
    local curried = func.curry(function (a, b, c)
      return a + b + c
    end)
    local result = curried(1)()(2)()(3)
    test.valueAssert(6, result)
  end),
  test.case("useful case", function()
    local mult = func.curry(function (a, b)
      return a * b
    end)
    local mult5 = mult(5)
    local mult10 = mult(10)
    test.valueAssert(30, mult5(6))
    test.valueAssert(40, mult10(4))
  end),
})

test.suite("func.memo", {

})
