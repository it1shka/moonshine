local test = require("test_utils")
local moonshine = require("lib")

test.suite("moonshine: curried usage", {
  test.case("computing sum of even numbers", function()
    local A = moonshine.array.curried
    local F = moonshine.func
    local result = F.pipe (
      A.sequence(function (i)
        return i
      end),
      A.filter(function (x)
        return x % 2 == 0
      end),
      A.reduce(0, function (acc, elem)
        return acc + elem
      end)
    ) (10)
    -- 2, 4, 6, 8,10
    test.valueAssert(30, result)
  end),
})
