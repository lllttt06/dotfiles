local pubspec = vim.fn.glob("pubspec.yaml")
if pubspec == "" then return false end
local pubspec_content = vim.fn.readfile(pubspec)
local joined_content = table.concat(pubspec_content, "\n")

local flutter_dependency = string.match(joined_content, "flutter:\n[%s\t]*sdk:[%s\t]*flutter")
return flutter_dependency ~= nil
