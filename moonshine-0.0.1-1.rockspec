rockspec_format = "3.0"
package = "moonshine"
version = "0.0.1-1"

source = {
  url = "...", -- TODO: 
}

description = {
  summary = "Functional library for Lua",
  detailed = [[
    Library providing common functional utilities
    for the Lua programming language
  ]],
  license = "NON-AI MIT",
}

dependencies = {
  "lua >= 5.3",
}

build = {
  type = "builtin",
  modules = {
    moonshine = "lib.lua",
    moonshine_array = "array.lua",
    moonshine_func = "func.lua",
  },
}

test = {
  type = "command",
  script = "test.lua",
}
