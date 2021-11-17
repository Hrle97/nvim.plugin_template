#!/usr/bin/env sh
set -euo pipefail

root_path="$(realpath -e "${BASH_SOURCE[0]}" | xargs dirname | xargs dirname)"
test_root_path="$root_path/tests"
example_root_path="$root_path/examples"

test_init_path="$test_root_path/lua/init.lua"

function test()
{
  echo -e "\nRUNNING TESTS\n"

  if nvim --headless --clean \
      -c "lua vim.g.root_path = '$root_path'" \
      -c "lua vim.g.test_root_path = '$test_root_path'" \
      -c "lua vim.g.example_root_path = '$example_root_path'" \
      -c "lua vim.o.runtimepath =
            vim.o.runtimepath .. ',' ..
            vim.g.root_path .. ',' ..
            vim.g.test_root_path" \
      -c "luafile $test_init_path" 2>&1; then
    echo -e "\nTESTS PASSED!"
  else
    echo -e "\nTESTS FAILED!"
    return 1
  fi
}

function main() 
{
  test &

  wait $(jobs -p)
}

main "$@"
