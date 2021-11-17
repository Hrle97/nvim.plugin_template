#!/usr/bin/env bash
set -euo pipefail

# root
root_path="$(realpath -e "${BASH_SOURCE[0]}" | xargs dirname | xargs dirname)"
doc_root_path="$root_path/doc"
doc_scripts_root_path="$root_path/scripts/doc"

# source
doc_file="$root_path/lua/nvim/plugin/init.lua"


##############################################################################
# Configs

doc_html_scripts_root_path="$doc_scripts_root_path/html"
doc_html_config_file="$doc_html_scripts_root_path/config.lua"

doc_vim_help_scripts_root_path="$doc_scripts_root_path/vim_help"
doc_vim_help_config_file="$doc_vim_help_scripts_root_path/config.lua"


##############################################################################
# Generation

doc_github_gen_path="$root_path/.github/pages"

doc_vim_help_gen_path="$root_path/doc"
doc_vim_help_gen_name="plugin"
doc_vim_help_gen_ext="txt"
doc_vim_help_unnecessary_css_path="$doc_vim_help_gen_path/ldoc.css"
doc_vim_help_unnecessary_examples_path="$doc_vim_help_gen_path/examples"


function main() 
{
  ldoc \
    --config "$doc_html_config_file" \
    --dir "$doc_github_gen_path" \
    "$doc_file"

  ldoc \
    --config "$doc_vim_help_config_file" \
    --dir "$doc_vim_help_gen_path" \
    --output "$doc_vim_help_gen_name" \
    --ext "$doc_vim_help_gen_ext" \
    "$doc_file"

  rm "$doc_vim_help_unnecessary_css_path"
  if [ -d  "$doc_vim_help_unnecessary_examples_path" ]
  then
    rm -r "$doc_vim_help_unnecessary_examples_path"
  fi
}

main "$@"
