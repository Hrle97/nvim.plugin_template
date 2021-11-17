project = "plugin"
title = "Plugin Title"
description = "Plugin Description"
full_description = "Plugin Full Description"

not_luadoc = true

template = true
examples = "examples"

custom_tags = {
  {
    "link",
    title = "Links",
    format = function(text)
      local name = text:gsub("^%s*(.-)%s*http.*$", "%1", 1)
      local link = text:gsub("^.*%s*(http.-)%s*$", "%1", 1)
      local fmt = "%s: <%s>"

      return fmt:format(name, link)
    end,
  },
  { "homepage", title = "Homepage" },
}

alias("tfield", { "field", modifiers = { type = "$1" } })
