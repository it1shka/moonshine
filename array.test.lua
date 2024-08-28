local test = require("test_utils")
local array = require("array")

test.suite("array.map", {
  test.case("empty array", function()
    local result = array.map({}, test.const_function(0))
    test.arrayShallowAssert({}, result)
  end),
  test.case("small array", function()
    local target = {1, 2, 3, 4, 5}
    local result = array.map(target, function (x)
      return x + 1
    end)
    test.arrayShallowAssert({2, 3, 4, 5, 6}, result)
  end),
})

test.suite("array.filter", {
  test.case("empty array", function()
    local result = array.filter({}, test.const_function(true))
    test.arrayShallowAssert({}, result)
  end),
  test.case("even numbers", function()
    local numbers = {1, 2, 3, 4, 5, 6, 7}
    local result = array.filter(numbers, function (x)
      return x % 2 == 0
    end)
    test.arrayShallowAssert({2, 4, 6}, result)
  end)
})

test.suite("array.reduce", {
  test.case("empty array with initial", function()
    local result = array.reduce({}, test.const_function(nil), 100)
    assert(result == 100, "didn't return initial value")
  end),
  test.case("empty array without initial", function()
    local result = array.reduce({}, test.const_function(nil))
    assert(result == nil, "didn't return nil")
  end),
  test.case("with initial", function()
    local target = {1, 2, 3, 4, 5}
    local result = array.reduce(target, function (acc, elem)
      return acc + elem
    end, 100)
    assert(result == 115, "wrong result: expected 115, got " .. result)
  end),
  test.case("without initial", function()
    local target = {1, 2, 3, 4}
    local result = array.reduce(target, function (acc, elem)
      return acc * elem
    end)
    assert(result == 24, "wrong result: expected 24, got " .. result)
  end),
})
