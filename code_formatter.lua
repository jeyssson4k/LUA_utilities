--[[
* Code Formatter
* @author Jeysson4K
* 12/25/2024
* v0.1
* Removes all blank spaces and
* comments that starts with //
]]--

local VERSION = "v0.1"
local file = nil
local fname = ""
print("Code Formatter "..VERSION.." from "..arg[-1].."\n")

-- Check if a filename is provided
if not arg[1] then
    print("No file provided, exit...")
    os.exit(1)
end

-- Verify if file is valid
local filename = arg[1]
if not io.open(filename, "r") then
    print("Error: Could not open file " .. filename)
    os.exit(1)
end

--Creating filename
i,j = string.find(filename, "%.")
fname = string.sub(filename, 1, i-1).."_f".. string.sub(filename, j, #filename)
print("Formatting code into "..fname.."\n")

--Verify if file is valid
file, err = io.open(fname, "w")
if not file then
    print("Error opening file: " .. err)
    os.exit(1)
end

--Formatting code
for line in io.lines(filename) do
    if #line > 0 then
        u, v = string.find(line, "%s*//.")
        if not u then
            file:write(line.."\n")
        elseif u > 1 then
            file:write(string.sub(line, 1, u-1).."\n")
        end
    end     
end

file:close()
print("File created and written successfully!")
