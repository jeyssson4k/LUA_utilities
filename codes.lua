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

-- Open a file in write mode ("w")
local file, err = io.open("example.txt", "w")

-- Check if the file was successfully opened
if not file then
    print("Error opening file: " .. err)
    return
end

-- Write data to the file
file:write("Hello, Lua!\n")
file:write("This is a new file.\n")

-- Close the file to save changes
file:close()

print("File created and written successfully!")
