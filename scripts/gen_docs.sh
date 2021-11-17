#!/usr/bin/env bash
set -euo pipefail

# root
root_path="$(realpath -e "${BASH_SOURCE[0]}" | xargs dirname | xargs dirname)"

# script root
docs_scripts_root_path="$root_path/scripts/docs"

# source
docs_file="$root_path/lua/nvim/plugin/init.lua"


##############################################################################
# Configs

docs_html_scripts_root_path="$docs_scripts_root_path/html"
docs_html_config_file="$docs_html_scripts_root_path/config.lua"

docs_vim_help_scripts_root_path="$docs_scripts_root_path/vim_help"
docs_vim_help_config_file="$docs_vim_help_scripts_root_path/config.lua"


##############################################################################
# Generation

docs_github_gen_path="$root_path/.github/pages"

docs_vim_help_gen_path="$root_path/doc"
docs_vim_help_gen_name="plugin"
docs_vim_help_gen_ext="txt"
docs_vim_help_unnecessary_css_path="$docs_vim_help_gen_path/ldoc.css"
docs_vim_help_unnecessary_examples_path="$docs_vim_help_gen_path/examples"


function main() 
{
  ldoc \
    --config "$docs_html_config_file" \
    --dir "$docs_github_gen_path" \
    "$docs_file"

  ldoc \
    --config "$docs_vim_help_config_file" \
    --dir "$docs_vim_help_gen_path" \
    --output "$docs_vim_help_gen_name" \
    --ext "$docs_vim_help_gen_ext" \
    "$docs_file"

  rm "$docs_vim_help_unnecessary_css_path"
  if [ -d  "$docs_vim_help_unnecessary_examples_path" ]
  then
    rm -r "$docs_vim_help_unnecessary_examples_path"
  fi
}

main "$@"
