local Utilities = {}

local FontDisplayService = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/CustomFonts/FontDisplayService.lua"))()
function Utilities.Write(...)
    return FontDisplayService:Write(...)
end

function Utilities.Create(class)
    return function(properties)
		local v73 = Instance.new(class);
		for v74, v75 in pairs(properties) do
			local v76, v77 = pcall(function()
				if type(v74) == "number" then
					v75.Parent = v73;
					return;
				end;
				if type(v75) ~= "function" then
					v73[v74] = v75;
					return;
				end;
				v73[v74]:Connect(v75);
			end);
			if not v76 then
				error("Create: could not set property " .. v74 .. " of " .. class .. " (" .. v77 .. ")", 2);
			end;
		end;
		return v73;
	end;
end

return Utilities