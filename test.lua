local test = require("test_utils")

test.start_testing()
  dofile("internal_utils.test.lua")
  dofile("array.test.lua")
  dofile("func.test.lua")
test.end_testing()
