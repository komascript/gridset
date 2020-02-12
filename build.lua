#!/usr/bin/env texlua

release_info = "2020-02-12 v0.3"

-- Build script for gridset

module = "gridset"

unpackfiles = {"gridset.dtx"}

-- CTAN information

ctanpkg = "gridset"

packtdszip = true

uploadconfig = {
   pkg        = "gridset",
   version    = release_info,
   author     = "Markus Kohm",
   license    = "lppl1.3c",
   summary    = "An experimental LaTeX package for semi-manual grid (a.k.a. in-register) setting",
   topic      = "typeset-grid",
   ctanPath   = "/macros/latex/contrib/gridset",
   bugtracker = "https://github.com/komascript/gridset/issues",
   home       = "https://komascript.de/gridset",
   repository = "https://github.com/komascript/gridset.git",
} 

-- Detail how to set the version automatically
-- Example: `l3build tag --date 2020-02-31 v0.3'

tagfiles = {"*.dtx","README.md","build.lua"}

function update_tag (file,content,tagname,tagdate)
   tagname = string.gsub (tagname, "v(%d+%.%d+)", "%1")
   
   if string.match (file, "%.dtx$") then
      return string.gsub (content,
			  "%[%d%d%d%d%-%d%d%-%d%d v%d+%.%d+",
			  "[" .. tagdate .. " v" .. tagname )
   elseif string.match (file, "%.md$") then
      return string.gsub (content,
			  "\nRelease: %d%d%d%d%-%d%d%-%d%d v%d+%.%d+  \n",
			  "\nRelease: " .. tagdate .. " v" .. tagname .. "  \n")
   elseif string.match (file, "%.lua$") then
      return string.gsub (content,
			  '\nrelease_info = "%d%d%d%d%-%d%d%-%d%d v%d+%.%d+"\n',
			  '\nrelease_info = "' .. tagdate .. " v" .. tagname .. '"\n')
   end
   return content
end

-- Find and run the build system
kpse.set_program_name("kpsewhich")
if not release_date then
  dofile(kpse.lookup("l3build.lua"))
end
