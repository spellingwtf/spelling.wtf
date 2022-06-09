local Utilities = {}

local FontDisplayService = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/CustomFonts/FontDisplayService.lua"))()
function Utilities.Write(...)
    return FontDisplayService:Write(...)
end
FontDisplayService:Preload("Avenir")
FontDisplayService:Preload("Outlined")
FontDisplayService:Preload("Outlined")
FontDisplayService:Preload("FWNums")

local v45 = {};
for v46 = 1, 64 do
	v45[v46 - 1] = ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):sub(v46, v46);
end;

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

function Utilities.uid(p27)
	local v47 = nil;
	if not p27 then
		p27 = game:GetService("HttpService"):GenerateGUID(false);
	end;
	p27 = p27:gsub("%X+", "");
	local v48 = #p27;
	local v49 = math.ceil(v48 / 3);
	local v50 = v48 % 3;
	if v50 ~= 0 then
		p27 = p27 .. string.rep("0", 3 - v50);
	end;
	v47 = "";
	local v52
	for v51 = 1, v49 do
		v52 = tonumber(p27:sub(v51 * 3 - 1, v51 * 3 - 1), 16);
		v47 = v47 .. v45[tonumber(p27:sub(v51 * 3 - 2, v51 * 3 - 2), 16) * 4 + math.floor(v52 / 4)] .. v45[v52 % 4 * 16 + tonumber(p27:sub(v51 * 3, v51 * 3), 16)];
	end;
	return v47
end

function Utilities.Signal()
	local v148 = {};
	local u40 = nil;
	local u41 = nil;
	local u42 = Instance.new("BindableEvent");
	function v148.fire(p105, ...)
		u40 = { ... };
		u41 = select("#", ...);
		u42:Fire();
	end;
	function v148.connect(p106, p107)
		if not p107 then
			error("connect(nil)", 2);
		end;
		return u42.Event:Connect(function()
			p107(unpack(u40, 1, u41));
		end);
	end;
	function v148.wait(p108)
		u42.Event:wait();
		assert(u40, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.");
		return unpack(u40, 1, u41);
	end;
	function v148.destroy(p109)
		u42:Destroy();
		u40 = nil;
		u41 = nil;
	end;
	function v148.__index(p110, p111)
		return rawget(v148, p111:lower());
	end;
	setmetatable(v148, v148);
	return v148;
end

local Timing = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/Timing.lua"))()
Utilities.Timing = Timing

function Utilities.Tween(p64, p65, p66, p67, p68)
	if p64 == 0 then
		p66(1, 0);
		return true;
	end;
	if type(p65) == "string" then
		p65 = Timing[p65](p64);
	end;
	p68 = p68 or os.clock;
	local v110 = p68();
	if p66(0, 0) == false then
		return false;
	end;
	if p67 then
		local v111 = "Tween_" .. Utilities.uid();
		local l__RunService__112 = game:GetService("RunService");
		local u30 = false;
		local u31 = Utilities.Signal();
		l__RunService__112:BindToRenderStep(v111, p67, function()
			if u30 then
				return;
			end;
			local v113 = p68() - v110;
			if p64 <= v113 then
				u30 = true;
				p66(1, p64);
				u31:fire(true);
				return;
			end;
			local v114 = v113 / p64;
			if p65 then
				v114 = p65(v113);
			end;
			if p66(v114, v113) == false then
				u30 = true;
				u31:fire(false);
			end;
		end);
		local v115 = u31:wait();
		l__RunService__112:UnbindFromRenderStep(v111);
		return v115;
	end;
	while true do
		task.wait();
		local v116 = p68() - v110;
		if p64 <= v116 then
			p66(1, p64);
			return true;
		end;
		local v117 = v116 / p64;
		if p65 then
			v117 = p65(v116);
		end;
		if p66(v117, v116) == false then
			break;
		end;	
	end;
	return false;
end;

return Utilities