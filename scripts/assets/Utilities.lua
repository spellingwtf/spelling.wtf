local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Utilities = {}

local FontDisplayService = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/CustomFonts/FontDisplayService.lua"))()
function Utilities.Write(...)
    return FontDisplayService:Write(...)
end
FontDisplayService:Preload("Avenir")
FontDisplayService:Preload("R1")
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

Utilities.gui = Utilities.Create("ScreenGui")({
	Parent = CoreGui,
	IgnoreGuiInset = true
})

Utilities.fadeGui = Utilities.Create("Frame")({
	Parent = Utilities.gui,
	BorderSizePixel = 0,
	Size = UDim2.fromScale(1, 1),
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Name = "FadeGui",
	BackgroundTransparency = 1
})

function Utilities.uid(p27)
	local v47 = nil;
	if not p27 then
		p27 = HttpService:GenerateGUID(false);
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
		local u30 = false;
		local u31 = Utilities.Signal();
		RunService:BindToRenderStep(v111, p67, function()
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
		RunService:UnbindFromRenderStep(v111);
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

function Utilities.FadeOut(p42, p43, p44)
	Utilities.fadeGui.ZIndex = 30;
	Utilities.fadeGui.BackgroundColor3 = p43 or Color3.new(0, 0, 0);
	local l__BackgroundTransparency__20 = Utilities.fadeGui.BackgroundTransparency;
	Utilities.Tween(p42, nil, function(p45)
		Utilities.fadeGui.BackgroundTransparency = l__BackgroundTransparency__20 + (0 - l__BackgroundTransparency__20) * p45;
		if p44 then
			p44(p45);
		end;
	end);
end;
function Utilities.FadeIn(p46, p47)
	local l__BackgroundTransparency__21 = Utilities.fadeGui.BackgroundTransparency;
	Utilities.Tween(p46, nil, function(p48)
		Utilities.fadeGui.BackgroundTransparency = l__BackgroundTransparency__21 + (1 - l__BackgroundTransparency__21) * p48;
		if p47 then
			p47(p48);
		end;
	end);
end;
function Utilities.FadeOutWithCircle(p49, p50)
	local l__Create__80 = Utilities.Create;
	local v81 = l__Create__80("Frame")({
		BackgroundTransparency = 1, 
		Size = UDim2.new(1, 0, 1, 36), 
		Position = UDim2.new(0, 0, 0, -36), 
		Parent = Utilities.gui
	});
	local u22 = l__Create__80("ImageLabel")({
		BackgroundTransparency = 1, 
		Image = "rbxassetid://317129150", 
		ZIndex = 9, 
		Parent = v81
	});
	local u23 = l__Create__80("Frame")({
		BorderSizePixel = 0, 
		BackgroundColor3 = Color3.new(0, 0, 0), 
		ZIndex = 9, 
		Parent = v81
	});
	local u24 = l__Create__80("Frame")({
		BorderSizePixel = 0, 
		BackgroundColor3 = Color3.new(0, 0, 0), 
		ZIndex = 9, 
		Parent = v81, 
		Position = UDim2.new(1, 0, 0, 0)
	});
	local u25 = l__Create__80("Frame")({
		BorderSizePixel = 0, 
		BackgroundColor3 = Color3.new(0, 0, 0), 
		ZIndex = 9, 
		Parent = v81
	});
	local u26 = l__Create__80("Frame")({
		BorderSizePixel = 0, 
		BackgroundColor3 = Color3.new(0, 0, 0), 
		ZIndex = 9, 
		Parent = v81, 
		Position = UDim2.new(0, 0, 1, 0)
	});
	Utilities.Tween(p49 and 0.6, nil, function(p51)
		local v82 = v81.AbsoluteSize.X * 1.42 * (1 - p51);
		u22.Size = UDim2.new(0, v82, 0, v82);
		u22.Position = UDim2.new(0.5, -v82 / 2, 0.5, -v82 / 2);
		u23.Size = UDim2.new(0.5, -v82 / 2 + 1, 1, 0);
		u24.Size = UDim2.new(-0.5, v82 / 2 - 1, 1, 0);
		u25.Size = UDim2.new(1, 0, 0.5, -v82 / 2 + 1);
		u26.Size = UDim2.new(1, 0, -0.5, v82 / 2 - 1);
	end);
	if not p50 then
		Utilities.fadeGui.BackgroundColor3 = Color3.new(0, 0, 0);
		Utilities.fadeGui.BackgroundTransparency = 0;
		v81:Destroy();
		return;
	end;
	return { v81, u22, u23, u24, u25, u26 };
end;
function Utilities.FadeInWithCircle(p52, p53)
	local v83 = nil;
	local v84 = nil;
	local v85 = nil;
	local v86 = nil;
	local v87 = nil;
	local v88 = nil;
	if p53 then
		local v89, v90, v91, v92, v93, v94 = unpack(p53);
		v83 = v89;
		v84 = v90;
		v85 = v91;
		v86 = v92;
		v87 = v93;
		v88 = v94;
	end;
	if not v83 then
		local l__Create__95 = Utilities.Create;
		v83 = l__Create__95("Frame")({
			BackgroundTransparency = 1, 
			Size = UDim2.new(1, 0, 1, 36), 
			Position = UDim2.new(0, 0, 0, -36), 
			Parent = Utilities.gui
		});
		v84 = l__Create__95("ImageLabel")({
			BackgroundTransparency = 1, 
			Image = "rbxassetid://317129150", 
			ZIndex = 9, 
			Parent = v83
		});
		v85 = l__Create__95("Frame")({
			BorderSizePixel = 0, 
			BackgroundColor3 = Color3.new(0, 0, 0), 
			ZIndex = 9, 
			Parent = v83
		});
		v86 = l__Create__95("Frame")({
			BorderSizePixel = 0, 
			BackgroundColor3 = Color3.new(0, 0, 0), 
			ZIndex = 9, 
			Parent = v83, 
			Position = UDim2.new(1, 0, 0, 0)
		});
		v87 = l__Create__95("Frame")({
			BorderSizePixel = 0, 
			BackgroundColor3 = Color3.new(0, 0, 0), 
			ZIndex = 9, 
			Parent = v83
		});
		v88 = l__Create__95("Frame")({
			BorderSizePixel = 0, 
			BackgroundColor3 = Color3.new(0, 0, 0), 
			ZIndex = 9, 
			Parent = v83, 
			Position = UDim2.new(0, 0, 1, 0)
		});
		Utilities.fadeGui.BackgroundTransparency = 1;
	end;
	Utilities.Tween(p52 and 0.6, nil, function(p54)
		local v96 = v83.AbsoluteSize.X * 1.42 * p54;
		v84.Size = UDim2.new(0, v96, 0, v96);
		v84.Position = UDim2.new(0.5, -v96 / 2, 0.5, -v96 / 2);
		v85.Size = UDim2.new(0.5, -v96 / 2 + 1, 1, 0);
		v86.Size = UDim2.new(-0.5, v96 / 2 - 1, 1, 0);
		v87.Size = UDim2.new(1, 0, 0.5, -v96 / 2 + 1);
		v88.Size = UDim2.new(1, 0, -0.5, v96 / 2 - 1);
	end);
	v83:Destroy();
end;

return Utilities