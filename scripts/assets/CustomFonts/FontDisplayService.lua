
-- Script Hash: d3356fac18cd018a0d992bbf669f208e55bd1d221195a41a066a7abc09e06f347131e7c580ed1f80f1259ef6f2adeb8c
--[[VARIABLE DEFINITION ANOMALY DETECTED, DECOMPILATION OUTPUT POTENTIALLY INCORRECT]]--
-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2 = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/CustomFonts/FontCreator.lua"))();
local l__ContentProvider__3 = game:GetService("ContentProvider");
local l__RenderStepped__4 = game:GetService("RunService").RenderStepped;
local v5 = {};
for v6 = 1, 54 do
	v5[("abcdefghijklmnopqrstuvwxyz.?!1234567890/-'\";:,[]{}()<>"):sub(v6, v6):lower()] = true;
end;
local v7 = {};
local u1 = {};
function v7.__index(p1, p2)
	if u1[p2] then
		return u1[p2];
	end;
	error(tostring(p2) .. " is not a valid member of fontDisplayService");
end;
function v7.__newindex(p3, p4, p5)
	error("fontDisplayService." .. tostring(p4) .. " cannot be set");
end;
setmetatable(v1, v7);
function u1.Preload(p6, p7)
	local v8 = v2.load(p7);
	local l__source__2 = v8.source;
	coroutine.wrap(function()
		local v9 = {};
		if type(l__source__2) == "table" then
			for v10 = 1, #l__source__2 do
				local v11 = Instance.new("ImageLabel");
				v11.Image = l__source__2[v10];
				v9[v10] = v11;
			end;
		else
			local v12 = Instance.new("ImageLabel");
			v12.Image = l__source__2;
			v9[1] = v12;
		end;
		l__ContentProvider__3:PreloadAsync(v9);
		for v13, v14 in ipairs(v9) do
			v14:Destroy();
		end;
		v8.setLoaded();
	end)()
end;
local l__iterateGraphemes__3 = v2.iterateGraphemes;
local function u4(p8, p9)
	local v15 = tick();
	while true do
		l__RenderStepped__4:wait();
		local v16 = tick() - v15;
		if p8 <= v16 then
			p9(1);
			return;
		end;
		if p9(v16 / p8) == false then
			break;
		end;	
	end;
end;
local u5 = {
	__newindex = function(p10, p11, p12)
		for v17, v18 in ipairs(p10) do
			if v18.ClassName == "ImageLabel" then
				v18["ImageColor3"] = p12
			else
				v18["TextColor3"] = p12
			end;
		end;
	end
};
function u1.WriteToFrame(p13, fontname, size, text, wraps, frame, wordDetectionEnabled, p20)
	local v20 = nil;
	local v21 = nil;
	local v22 = nil;
	local v23 = nil;
	local v24 = nil;
	local v25 = nil;
	local v26 = nil;
	if p20 then
		v20 = p20.Color;
		v21 = p20.WritingToChatBox;
		v22 = p20.AnimationRate;
		v23 = p20.AnimationFadeDisabled;
		v24 = p20.Transparency;
		if p20.Scaled then
			v25 = true
		else
			v25 = false
		end;
		v26 = p20.TextXAlignment;
	end;
	if text == "" then
		return {};
	end;
	local v28 = v2.load(fontname);
	local l__substitutionFont__29 = v28.substitutionFont;
	local l__substitutionSize__30 = v28.substitutionSize;
	local l__source__31 = v28.source;
	local v32 = type(l__source__31) == "table";
	if v28.yScale ~= nil then
		local v33 = Instance.new("Frame");
		v33.BackgroundTransparency = 1;
		v33.Size = UDim2.new(1, 0, v28.yScale, 0);
		v33.AnchorPoint = Vector2.new(0, 0.5);
		v33.Position = UDim2.new(0, 0, 0.5, 0);
		v33.ZIndex = frame.ZIndex;
		v33.Parent = frame;
		frame = v33;
		size = math.floor(size * v28.yScale + 0.5);
	end;
	local v34 = math.floor(l__substitutionSize__30 * size / v28.baseHeight + 0.5);
	local v35 = Vector2.new(0, v28.baselineOffset);
	local v36 = Vector2.new();
	local v37 = Vector2.new(0, 0);
	local v38
	local v39
	if wraps then
		v38 = true;
	else
		v38 = false;
	end;
	if wordDetectionEnabled then
		v39 = true;
	else
		v39 = false;
	end;
	local u6 = Vector2.new(0, 0);
	local l__AbsoluteSize__7 = frame.AbsoluteSize;
	local u8 = size / v28.baseHeight;
	local u9 = v37;
	local function u10(p21, p22)
		if not v38 or not (l__AbsoluteSize__7.X < u6.X + p21) then
			u6 = u6 + Vector2.new(p21, 0);
			u9 = u9 + Vector2.new(p22, 0);
			return;
		end;
		u6 = Vector2.new(0, u6.Y + v28.letterSpacing * u8 + size + v28.lineSpacing * u8);
		u9 = Vector2.new(0, u9.Y + v28.letterSpacing + v28.baseHeight + v28.lineSpacing);
	end;
	local l__isV2__11 = v28.isV2;
	local u12 = {};
	local l__substitutionAlignment__13 = v28.substitutionAlignment;
	local u14 = {};
	local u15 = {};
	local u16 = {};
	local u17 = {};
	local u18 = {};
	local u19 = nil;
	local u20 = {};
	local u21 = 0;
	local function u22(p23)
		if p23 == " " or p23 == "\t" then
			local v40
			if p23 == " " then
				v40 = 1;
			else
				v40 = false;
				if p23 == "\t" then
					v40 = 3;
				end;
			end;
			u10((v28.spaceWidth + v28.letterSpacing) * v40 * u8, (v28.spaceWidth + v28.letterSpacing) * v40);
		elseif p23 == "\n" then
			u6 = Vector2.new(0, u6.y + v28.letterSpacing * u8 + size + v28.lineSpacing * u8);
			u9 = Vector2.new(0, u9.y + v28.letterSpacing + v28.baseHeight + v28.lineSpacing);
		else
			local v41, v42 = v28.getCharBounds(p23);
			local v43 = l__isV2__11 and not v42;
			local v44 = v43 and v41.ImageRectSize.X or (v42 and v41.X or v41[3]);
			local v45 = v43 and v41.ImageRectSize.Y or (v42 and v41.Y or v41[4]);
			local v46 = u8 / (v45 / v28.baseHeight);
			local v47 = v43 and v41.Advance or v44;
			local v48 = u9 + v35;
			if v43 then
				v48 = v48 + v41.SpriteOffset;
			end;
			local v49
			if v42 then
				v49 = Instance.new("TextLabel");
				v49.Name = tostring(#u12 + 1);
				v49.BackgroundTransparency = 1;
				v49.Font = v28.substitutionFont;
				v49.Text = p23;
				v49.TextSize = v34;
				v49.Position = UDim2.new(0, v48.X * u8, 0, (v48.Y + l__substitutionAlignment__13) * u8);
				v49.Size = UDim2.new(0, v44 * u8, 0, size);
				u14[v49] = Vector2.new(v44, v28.baseHeight);
				u15[v49] = v48 + Vector2.new(0, l__substitutionAlignment__13);
				u16[v49] = "TextTransparency";
				v49.ZIndex = frame.ZIndex;
				v49.TextColor3 = v20 or Color3.new(1, 1, 1);
				if v22 then
					v49.TextTransparency = 1;
				elseif v24 then
					v49.TextTransparency = v24;
				end;
			else
				v49 = Instance.new("ImageLabel");
				v49.Name = tostring(#u12 + 1);
				v49.BackgroundTransparency = 1;
				local v50 = v41[5];
				if not v50 then
					if v32 then
						v50 = l__source__31[v41.Sheet] or l__source__31;
					else
						v50 = l__source__31;
					end;
				end;
				if type(v50) == "table" then
					v49.Image = v50[1]
				else
					v49.Image = v50
				end
				v49.ImageRectOffset = l__isV2__11 and v41.ImageRectOffset or Vector2.new(v41[1], v41[2]);
				v49.ImageRectSize = l__isV2__11 and v41.ImageRectSize or Vector2.new(v41[8] or v41[3], v41[9] or v41[4]);
				if p23 == "[EMPTY]" then
					u17[#u17 + 1] = v49;
				end;
				local v51 = l__isV2__11 and v41.PostScale or v41[7];
				local v52 = v48.X * u8;
				local v53 = v48.Y * u8;
				local v54 = v44 * u8;
				local v55 = v45 * u8;
				if v51 then
					v52 = v52 - v54 * 0.5 * (v51 - 1);
					v53 = v53 - v55 * 0.5 * (v51 - 1);
					v54 = v54 * v51;
					v55 = v55 * v51;
					local v56 = l__isV2__11 and v49.ImageRectSize or Vector2.new(v41[3], v41[4]);
					u14[v49] = v56 * v51;
					u15[v49] = v48 - 0.5 * v56 * (v51 - 1);
				else
					u14[v49] = v49.ImageRectSize;
					u15[v49] = v48;
				end;
				v49.Position = UDim2.new(0, v52, 0, v53);
				local v57
				if l__isV2__11 then
					if v51 then
						v49.Size = UDim2.new(0, v54, 0, v55);
					else
						v49.Size = UDim2.new(0, v54, 0, v55);
						u18[v49] = v41.SpriteOffset.Y;
					end;
					v57 = v41.NoColor;
				else
					v49.Size = UDim2.new(0, v54, 0, v55);
					v57 = v41[5];
				end;
				u16[v49] = "ImageTransparency";
				v49.ZIndex = frame.ZIndex;
				if v20 and not v57 then
					v49.ImageColor3 = v20;
				end;
				if v22 then
					v49.ImageTransparency = 1;
				elseif v24 then
					v49.ImageTransparency = v24;
				end;
				if not l__isV2__11 then
					local v58 = v28.extensions[p23];
					if v58 then
						local v59 = v58[1] and 0;
						local v60 = v58[2] and 0;
						v49.ImageRectOffset = v49.ImageRectOffset + Vector2.new(0, -v59);
						v49.ImageRectSize = v49.ImageRectSize + Vector2.new(0, v59 + v60);
						v49.Position = v49.Position + UDim2.new(0, 0, 0, v46 * -v59);
						v49.Size = v49.Size + UDim2.new(0, 0, 0, v46 * (v59 + v60));
						u15[v49] = u15[v49] + Vector2.new(0, -v59);
						u14[v49] = u14[v49] + Vector2.new(0, v59 + v60);
					end;
				end;
			end;
			table.insert(u12, v49);
			u10((v47 + v28.letterSpacing) * u8, v47 + v28.letterSpacing);
		end;
		return true;
	end;
	local function v61()
		if u19 == "\n" and v21 then
			return false;
		end;
		u19 = table.concat(u20, "");
		if l__AbsoluteSize__7.X < u6.X + u21 and u6.X > 0 then
			if v21 then
				return false;
			end;
			if v38 and v39 then
				u6 = Vector2.new(0, u6.Y + v28.letterSpacing * u8 + size + v28.lineSpacing * u8);
				u9 = Vector2.new(0, u9.Y + v28.letterSpacing + v28.baseHeight + v28.lineSpacing);
			end;
		end;
		for v62, v63 in pairs(u20) do
			u22(v63);
		end;
		u20 = {};
		u21 = 0;
		return true;
	end;
	local v64 = nil;
	local v65 = nil;
	local v66, v67, v68 = l__iterateGraphemes__3(text, v28);
	while true do
		local v69, v70, v71 = v66(v67, v68);
		if not v69 then
			break;
		end;
		local v72 = v69 == "[--]";
		if not (not v5[v69:lower()]) or not (not v28.specialWordCharacters[v69]) or v72 then
			table.insert(u20, v69);
			if #u20 == 1 then
				v65 = v70;
			end;
			u21 = u21 + v28.getStringSize(v69, size).X;
			if v72 and not v61() then
				v64 = text:sub(v65);
				break;
			end;
		else
			if #u20 > 0 and not v61() then
				v64 = text:sub(v65);
				break;
			end;
			if v69 == " " or v69 == "\t" or v69 == "\n" then
				u22(v69);
			else
				v65 = v70;
				u20 = { v69 };
				u21 = v28.getStringSize(v69, size).X;
				if not v61() then
					v64 = text:sub(v70);
					break;
				end;
			end;
		end;	
	end;
	if #u20 > 0 and not v61() then
		v64 = text:sub(v65);
	end;
	local v73 = 0;
	local v74 = 0;
	local v75 = 0;
	local v76 = 0;
	for v77, v78 in next, u12 do
		v73 = math.max(v73, v78.Position.X.Offset + v78.Size.X.Offset);
		v74 = math.max(v74, v78.Position.Y.Offset + v78.Size.Y.Offset);
		local v79 = u15[v78];
		local v80 = u14[v78];
		v75 = math.max(v75, v79.X + v80.X);
		v76 = math.max(v76, v79.Y + v80.Y);
	end;
	local v81 = Vector2.new(v73, v74);
	local v82 = Vector2.new(v75, v76);
	local v83 = nil;
	if v25 then
		local l__X__84 = v81.X;
		local l__X__85 = v82.X;
		local l__baseHeight__86 = v28.baseHeight;
		local v87 = Instance.new("Frame");
		v87.BackgroundTransparency = 1;
		v87.SizeConstraint = Enum.SizeConstraint.RelativeYY;
		v87.Size = UDim2.new(l__X__85 / l__baseHeight__86, 0, 1, 0);
		v87.Parent = frame;
		if v26 ~= Enum.TextXAlignment.Left then
			if v26 == Enum.TextXAlignment.Right then
				v87.AnchorPoint = Vector2.new(1, 0);
				v87.Position = UDim2.new(1, 0, 0, 0);
			else
				v87.AnchorPoint = Vector2.new(0.5, 0);
				v87.Position = UDim2.new(0.5, 0, 0, 0);
			end;
		end;
		local v88, v89, v90 = pairs(u12);
		for v92, v93 in v88, v89, v90 do
			local v94 = u14[v93];
			local v91 = u15[v93];
			v93.Size = UDim2.new(v94.X / l__X__85, 0, v94.Y / l__baseHeight__86, 0);
			if u18[v93] then
				local v95 = u18[v93];
				v93.Position = UDim2.new(v91.X / l__X__85, 0, (v91.Y - v95) / l__baseHeight__86, 0)
				v93.AnchorPoint = Vector2.new(0, -v95 / v93.ImageRectSize.Y);
			else
				v93.Position = UDim2.new(v91.X / l__X__85, 0, v91.Y / l__baseHeight__86, 0);
			end;
			v93.Parent = v87;
			if v93:IsA("TextLabel") then
				v93:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
					v93.TextSize = math.floor(l__substitutionSize__30 * v93.AbsoluteSize.Y / v28.baseHeight + 0.5);
				end);
			end;
		end
		v83 = v87;
	else
		for v96, v97 in next, u12 do
			v97.Parent = frame;
		end;
	end;
	if v22 then
		local v99 = p20.Blip;
		if v99 then
			local u23 = true;
			local u24 = 0;
			coroutine.wrap(function()
				local l__RenderStepped__100 = game:GetService("RunService").RenderStepped;
				while u23 do
					local v101 = tick();
					if v101 - u24 > 0.06 then
						v99.Play();
						u24 = v101;
					end;
					l__RenderStepped__100:wait();				
				end;
			end)();
		end;
		local l__x__102 = v81.x;
		local u28
		if v25 then
			local l__X__104 = v82.X;
			local u27 = false;
			u4(l__X__104 / u8 / v28.baseHeight / v22, function(p24)
				if u27 then
					return false;
				end;
				local v105 = l__X__104 * p24;
				local v106, v107, v108 = pairs(u12);
				while true do
					local v109 = nil;
					local v110 = nil;
					local v111, v112 = v106(v107, v108);
					if not v111 then
						break;
					end;
					v108 = v111;
					v109 = u14[v112].X;
					v110 = u15[v112].X;
					local v113 = u16[v112];
					if v23 then
						if v110 + v109 / 2 <= v105 then
							v112[v113] = 0
						else
							v112[v113] = 1
						end;
					elseif v110 + v109 <= v105 then
						v112[v113] = 0;
					elseif v110 < v105 then
						v112[v113] = 1 - (v105 - v110) / v109;
					end;				
				end;
			end);
		else
			u28 = false;
			u4(l__x__102 / u8 / v28.baseHeight / v22, function(p25)
				if u28 then
					return false;
				end;
				local v115 = l__x__102 * p25;
				local v116, v117, v118 = pairs(u12);
				while true do
					local v119 = nil;
					local v120, v121 = v116(v117, v118);
					if not v120 then
						break;
					end;
					v118 = v120;
					local l__Offset__122 = v121.Position.X.Offset;
					local l__Offset__123 = v121.Size.X.Offset;
					v119 = u16[v121];
					if l__Offset__122 + l__Offset__123 <= v115 then
						v121[v119] = 0;
					elseif l__Offset__122 < v115 then
						v121[v119] = 1 - (v115 - l__Offset__122) / l__Offset__123;
					end;				
				end;
			end);
		end;
		if u28 then
			for v124, v125 in pairs(u12) do
				v125[u16[v125]] = 0;
			end;
		end;
	end;
	local v126 = {
		Frame = v83, 
		MaxBounds = v81, 
		AbsoluteMaxBounds = v82, 
		Labels = u12, 
		Empties = #u17 > 0 and u17 or nil, 
		destroy = function(p26)
			for v127, v128 in pairs(u12) do
				v128:Destroy();
			end;
		end
	};
	v126.Destroy = v126.destroy;
	if p20.Theme then
		p20.Theme.Parent = setmetatable(u12, u5);
	end;
	if not v21 then
		return v126;
	end;
	return v64, v126;
end;
function u1.Write(p27, text)
	return function(p29)
		return p27:WriteToFrame(p29.Font, p29.Size or p29.Frame.AbsoluteSize.Y, text, p29.Wraps, p29.Frame, p29.WordDetectionEnabled, p29);
	end;
end;
return v1;