local f = string.format
local rep = string.rep
local gsub = string.gsub
local sub = string.sub

local Formats = {
	boolean = function(v)
		return tostring(v)
	end,
	number = function(v)
		return tostring(v)
	end,
	string = function(v)
		return f('"%s"', gsub(v, '"', '\\"'))
	end,
	Instance = function(v)
		-- Just convert instances to strings
		return f('"%s"', gsub(v.Name, '"', '\\"'))
	end
}

local function FormatType(v)
	local FFunc = assert(
		Formats[typeof(v)],
		f("Type '%s' unsupported by FormatType.", typeof(v))
	)

	return FFunc(v)
end

local function FormatK(k)
	return f('[%s]', FormatType(k))
end

local function Indent(amount)
	return rep("    ", amount)
end

-- Main function
local function TblToStr(tbl, depth)
	local tblStr = "{\n"
	
	local depth = depth or 0
	
	for k, v in pairs(tbl) do
		local Fv
		
		-- Allows nested tables
		if typeof(v) == "table" then
			Fv = TblToStr(v, depth + 1)
		else
			Fv = FormatType(v)
		end
		
		-- Ignore the "[1] = v" etc.
		-- Becomes: v
		if typeof(k) == "number" then
			tblStr = tblStr .. f("%s%s,\n", Indent(depth + 1), Fv)
		else
			tblStr = tblStr .. f("%s%s = %s,\n", Indent(depth + 1), FormatK(k), Fv)
		end
	end
	
	-- Remove trailing comma and newline
	tblStr = sub(tblStr, 0, #tblStr - 2)
	
	-- Add } to end
	tblStr = tblStr .. "\n" .. Indent(depth) .. "}"
	
	return tblStr
end

return TblToStr
