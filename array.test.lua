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

test.suite("array.find_index", {
  test.case("empty array", function()
    local result = array.find_index({}, test.const_function(true))
    test.valueAssert(nil, result)
  end),
  test.case("by value", function()
    local target = {4, 3, 5, "Lua", "JavaScript", "C++", "Prolog"}
    local result = array.find_index(target, "JavaScript")
    test.valueAssert(5, result)
  end),
  test.case("by function", function()
    local target = {{"Tikhon", "Belousov"}, {"John", "Doe"}, {"Freddie", "Mercury"}}
    local result = array.find_index(target, function (elem)
      local full_name = elem[1] .. " " .. elem[2]
      return full_name == "John Doe"
    end)
    test.valueAssert(2, result)
  end),
  test.case("non-existent", function()
    local target = {"Lua", "Perl", "Raku", "Ruby", "JavaScript"}
    local result = array.find_index(target, "C++")
    test.valueAssert(nil, result)
  end),
})

test.suite("array.flatten", {
  test.case("empty array", function()
    local cases = {{}, {{}, {{}}, {{{{}}}}}, {{}, {}}}
    for _, each in ipairs(cases) do
      local result = array.flatten(each)
      test.arrayShallowAssert({}, result)
    end
  end),
  test.case("shallow nesting", function()
    local target = {{1, 2}, 3, 4, {"Lua", "C++"}}
    local result = array.flatten(target)
    local expected = {1, 2, 3, 4, "Lua", "C++"}
    test.arrayShallowAssert(expected, result)
  end),
  test.case("deep nesting", function()
    local target = {{{1, 2,}, {3, 4}}, {5, {{6}}}, 7, 8}
    local result = array.flatten(target)
    local expected = {1, 2, 3, 4, 5, 6, 7, 8}
    test.arrayShallowAssert(expected, result)
  end),
})

test.suite("array.flat_map", {
  test.case("empty array", function()
    local result = array.flat_map({}, test.const_function({"Lua", "C++"}))
    test.arrayShallowAssert({}, result)
  end),
  test.case("simple case 1", function()
    local target = {1, 3, 5, 7}
    local result = array.flat_map(target, function (x)
      return {x, x + 1}
    end)
    test.arrayShallowAssert({1, 2, 3, 4, 5, 6, 7, 8}, result)
  end),
  test.case("simple case 2", function()
    local target = {1, 5, 10}
    local result = array.flat_map(target, function (x)
      return {"Current " .. x, "Twice " .. (x * 2)}
    end)
    test.arrayShallowAssert({
      "Current 1", "Twice 2",
      "Current 5", "Twice 10",
      "Current 10", "Twice 20",
    }, result)
  end),
})

test.suite("array.for_each", {
  test.case("sum of numbers", function()
    local target = {1, 2, 3, 4, 5}
    local sum = 0
    array.for_each(target, function(x)
      sum = sum + x
    end)
    test.valueAssert(15, sum)
  end),
  test.case("print names", function()
    local target = {"Tikhon", "Alex", "Vitaliya"}
    local printed = ""
    array.for_each(target, function (name, index)
      if index == #target then
        printed = printed .. name
      else
        printed = printed .. name .. ", "
      end
    end)
    test.valueAssert("Tikhon, Alex, Vitaliya", printed)
  end),
})

test.suite("array.contains", {
  test.case("empty array", function()
    local result = array.contains({}, "Lua")
    test.valueAssert(false, result)
  end),
  test.case("present by value", function()
    local target = {"C++", "Dart", "MoonScript", "Ruby", "Lua", "CoffeeScript"}
    local result = array.contains(target, "Lua")
    test.valueAssert(true, result)
  end),
  test.case("not present by value", function()
    local target = {"PureScript", "ReasonML", "Pharo", "Erlang"}
    local result = array.contains(target, "Lua")
    test.valueAssert(false, result)
  end),
  test.case("present by function", function()
    local liked = {
      JavaScript = true,
      Java = true,
      Kotlin = false,
    }
    local target = {"JavaScript", "Java", "Kotlin"}
    local result = array.contains(target, function (lang)
      return not liked[lang]
    end)
    test.valueAssert(true, result)
  end),
  test.case("not present by function", function()
    local target = {"Tikhon", "Vlad", "Kacper", "Mateusz"}
    local result = array.contains(target, function (name)
      return name[1] == "L"
    end)
    test.valueAssert(false, result)
  end)
})

test.suite("array.reverse", {
  test.case("empty array", function()
    local result = array.reverse({})
    test.arrayShallowAssert({}, result)
  end),
  test.case("single element", function()
    local result = array.reverse({"Lua"})
    test.arrayShallowAssert({"Lua"}, result)
  end),
  test.case("multiple elements", function()
    local target = {2, 4, 6, 8, "Lua", "Erlang"}
    local result = array.reverse(target)
    test.arrayShallowAssert({"Erlang", "Lua", 8, 6, 4, 2}, result)
  end),
})
