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
    test.valueAssert(24, result)
  end),
  test.case("element is not present", function()
    local target = {1, 3, 5, 7, 9}
    local result = array.find(target, function (x)
      return x * 2 > 20
    end)
    test.valueAssert(nil, result)
  end),
})

test.suite("array.concat", {
  test.case("empty array", function()
    local result = array.concat()
    test.arrayShallowAssert({}, result)
  end),
  test.case("simple case", function()
    local result = array.concat({1, 2}, {3, 4}, {5, 6})
    test.arrayShallowAssert({1, 2, 3, 4, 5, 6}, result)
  end),
})

test.suite("array.every", {
  test.case("empty array", function()
    local result = array.every({}, test.const_function(false))
    test.valueAssert(true, result)
  end),
  test.case("true case", function()
    local target = {1, 3, 5, 7, 9}
    local result = array.every(target, function (x)
      return x % 2 == 1
    end)
    test.valueAssert(true, result)
  end),
  test.case("false case", function()
    local target = {2, 4, 5, 6, 8}
    local result = array.every(target, function (x)
      return x % 2 == 0
    end)
    test.valueAssert(false, result)
  end),
})

test.suite("array.sequence", {
  test.case("empty sequence", function()
    local result = array.sequence(0, "A")
    test.arrayShallowAssert({}, result)
  end),
  test.case("constant sequence", function()
    local result = array.sequence(3, "Lua")
    test.arrayShallowAssert({"Lua", "Lua", "Lua"}, result)
  end),
  test.case("odd sequence", function()
    local result = array.sequence(5, function (i) 
      return i * 2 - 1
    end)
    test.arrayShallowAssert({1, 3, 5, 7, 9}, result)
  end),
})
