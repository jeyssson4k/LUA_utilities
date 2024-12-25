-- Check if a filename is provided
if not arg[1] then
    print("Usage: lua script.lua <filename>")
    os.exit(1)
end

local filename = arg[1]
local file = io.open(filename, "r")
if not file then
    print("Error: Could not open file " .. filename)
    os.exit(1)
end

print("Contents of " .. filename .. ":")
print(file:read("*all"))
file:close()
