_G.plugin = require "nvim.plugin"
_G.expect = require "util.expect"
_G.fun = require "util.fun"

local co = coroutine
local thread = nil
local done = false

local function run_units(kind, pattern)
  for _, unit_path in ipairs(vim.fn.glob(pattern, 0, 1)) do
    local unit_name = vim.fn.fnamemodify(unit_path, ":t:r")
    print("RUNNING " .. kind:upper() .. ": " .. unit_name .. " ...\n")

    -- TODO: better error handling
    local error = nil

    if unit_name:match "callback" then
      local unit = dofile(unit_path)
      assert(
        type(unit) == "function",
        "Callback unit " .. unit_name .. " must return a function!"
      )

      unit(vim.schedule_wrap(function(err)
        co.resume(thread, err)
      end))
      error = co.yield()
    else
      local ran, res = pcall(dofile, unit_path)
      if not ran then
        error = res
      end
    end

    if error then
      print("FAILED " .. kind:upper() .. ": " .. unit_name .. "\n")
      print(error)
      print "\n"
      vim.cmd [[cq]]
    else
      print("PASSED " .. kind:upper() .. ": " .. unit_name .. "\n")
      print "\n"
    end
  end
end

thread = co.create(function()
  run_units("unit test", vim.g.test_root_path .. "/lua/unit/**/*.lua")
  run_units("example", vim.g.example_root_path .. "/**/*.lua")
  done = true
end)

co.resume(thread)
vim.wait(
  1000 * 60 * 5, -- give it 5 min max
  function()
    return done
  end,
  100 -- check every 100 ms
)
vim.cmd [[q]]
