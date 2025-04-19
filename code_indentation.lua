--[[
* Variable Indenter
* @author Jeysson4K
* 4/18/2025
* v0.1
]]--

local VERSION = "v0.1"
local file = nil
local fname = ""
print("Code Indenter "..VERSION.." from "..arg[-1].."\n")

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
fname = string.sub(filename, 1, i-1).."_i".. string.sub(filename, j, #filename)
print("Indenting code into "..fname.."\n")

--Verify if file is valid
file, err = io.open(fname, "w")
if not file then
    print("Error opening file: " .. err)
    os.exit(1)
end

--Identifying the max indentation needed
local max_variable_len = 0
for line in io.lines(filename) do
    if #line > 0 then
        u, v = string.find(line, "^.-%s*=.")
        local keyword = string.match(line, "^%s*(else%s+if)%s")
            or string.match(line, "^%s*(elseif)%s")
            or string.match(line, "^%s*(elif)%s")
            or string.match(line, "^%s*(if)%s")
            or string.match(line, "^%s*(while)%s")
            or string.match(line, "^%s*(for)%s")
            or string.match(line, "%s*//.")
        if u and not keyword then
            local var = string.sub(line, u, v-2)
            local last_word = ""
            for word in string.gmatch(var, "%S+") do
                last_word = word 
            end
            if #last_word > max_variable_len then
                max_variable_len = #last_word + 1
            end
        end
    end    
end

--Creating the actual indentation
print("Max indentation: "..max_variable_len)
for line in io.lines(filename) do
    if #line > 0 then
        u, v = string.find(line, "^.-%s*=.")
        local keyword = string.match(line, "^%s*(else%s+if)%s")
            or string.match(line, "^%s*(elseif)%s")
            or string.match(line, "^%s*(elif)%s")
            or string.match(line, "^%s*(if)%s")
            or string.match(line, "^%s*(while)%s")
            or string.match(line, "^%s*(for)%s")
            or string.match(line, "%s*//.-=.*")
        if u and not keyword then
            local var = string.sub(line, u, v-2)
            local last_word = ""
            for word in string.gmatch(var, "%S+") do
                last_word = word 
            end
            local var_value = string.match(line, "=%s*(.+)")
            local indent = max_variable_len - #last_word
            local indented_var = var.. string.rep(" ", indent) .. "= " .. var_value
            file:write(indented_var.."\n")
        else
            file:write(line.."\n")
        end
    end 
end

file:close()
print("File created and written successfully!")
