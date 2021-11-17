project = "Plugin Name"
title = "Plugin Title"
description = "Plugin Description"
full_description = "Plugin Full Description"

not_luadoc = true

format = "markdown"
style = true
examples = "examples"
readme = "README.md"

custom_tags = {
  {
    "link",
    title = "Links",
    format = function(text)
      local name = text:gsub("%s*(.*) http.*", "%1", 1)
      local link = text:gsub(".* (http.*)%s*", "%1", 1)
      local fmt = '<a href="%s">%s</a>'

      return fmt:format(link, name)
    end,
  },
  { "homepage" },
}

alias("tfield", { "field", modifiers = { type = "$1" } })
