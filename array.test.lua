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
    test.valueAssert(100, result)
  end),
  test.case("empty array without initial", function()
    local result = array.reduce({}, test.const_function(nil))
    test.valueAssert(nil, result)
  end),
  test.case("with initial", function()
    local target = {1, 2, 3, 4, 5}
    local result = array.reduce(target, function (acc, elem)
      return acc + elem
    end, 100)
    test.valueAssert(115, result)
  end),
  test.case("without initial", function()
    local target = {1, 2, 3, 4}
    local result = array.reduce(target, function (acc, elem)
      return acc * elem
    end)
    test.valueAssert(24, result)
  end),
})

test.suite("array.find", {
  test.case("empty array", function()
    local result = array.find({}, test.const_function(true))
    test.valueAssert(nil, result)
  end),

  test.case("find even", function()
    local target = {1, 3, 17, 19, 29, 24, 2, 4, 6, 101, 103}
    local result = array.find(target, function (x)
      return x % 2 == 0
    end)
    -- TODO:
    --test.valueAssert(
  end),
})
