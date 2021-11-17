# Neovim Plugin Template

Template for creating Neovim plugins.

## Dependencies

- [Neovim](https://github.com/neovim/neovim) 0.5.1 (latest stable release)
- [LDoc](https://github.com/lunarmodules/LDoc) 1.4.6 (latest stable release)

## Contents

Instructions on how to get started and the features this template comes with.

### Source

Source code should be put in `./lua/nvim/<plugin_name>`. See the
`./lua/nvim/plugin/init.lua` file and modify it accordingly to get started.

### Tests And Examples

Unit tests should be put in `./tests/lua/unit/`. Examples should be put in
`./examples`. Files in both of these directories are treated as unit tests by
the test script.

The test script is in `./scripts/test.sh`. The script starts `nvim` without
plugins and configuration files, sets up paths to tests and examples and the
`runtimepath` option and runs the `./tests/lua/init.lua` file which sets up
the unit tests and runs them.

You can get started just by adding tests in `./tests/lua/unit/` and examples
in `./examples`.

Tests also come with some utilities and special features.

#### Expect

There is a global variable `expect` that gets set in the
`./tests/lua/init.lua` file which gets loaded from
`./tests/lua/util/expect.lua` with `require("util.expect")`. You can use this
variable as a minimal testing framework.

#### Callback

If a unit test file ends in `callback.lua` then the unit test is treated as
asynchronous and it is expected that this file will return a function which
will expect a single callback argument which will be called once the unit test
is done.

This is to allow testing asynchronous code when unit tests cannot be executed
simultaneously.

### Documentation

Documentation is generated using [LDoc](https://github.com/lunarmodules/LDoc)
and the documentation script.

The documentation script is in `./scripts/gen_docs.sh`. The script generates a
static HTML site in `./.github/pages/index.html` and a Vim help text file in
`./doc/<plugin_name>.txt`. The script uses the file
`./lua/nvim/<plugin_name>/init.lua` to generate the documentation and the
files in `./examples` to generate examples.

You should inspect the contents of the `./scripts/docs` directory, read a bit
of
[LDoc documentation](https://stevedonovan.github.io/ldoc/manual/doc.md.html)
and change the contents of the documentation configuration files in the
`./scripts/docs/html` and `./scripts/docs/vim_help` directories to get
started.

### Github Workflows

For now, there is only a single test workflow in
`./.github/workflows/test.yaml` with which Github will run the test script on
each push and pull request to the main branch, so check out that file if you
want to change the version of Neovim you are testing with or if your plugin
has some other dependencies that need to be set up before testing.

### Github Pages

The files `./.nojekyll` and `./index.html` will redirect to the generated
documentation in `./.github/pages/index.html`, so if you want to add Github
pages for online documentation, all you have to do is enable it in the
`Settings -> Pages` of your repo by selecting the main branch and root as the
Github Pages directory.
