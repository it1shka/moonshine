local test = require("test_utils")
local array = require("array")

test.suite("array.map", {
  test.case("empty array", function()
    local result = array.map({}, function() return 0 end)
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
    local result = array.filter({}, function () return true end)
    test.arrayShallowAssert({}, result)
  end),
  test.case("even numbers", function()
    local numbers = {1, 2, 3, 4, 5, 6, 7}
    -- local result = array.filter()
  end)
})
