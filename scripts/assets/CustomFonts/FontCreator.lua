
-- Script Hash: 64227ba7f4ff6318048980bff02febbf7deb864236bb919d4bfb0ee8451a679cf830d34e7990ad12b0317292a2a05df5
-- Decompiled with the Synapse X Luau decompiler.

local l__TextService__1 = game:GetService("TextService");
local v2 = {};
local v3 = {};
local u1 = {};
function v3.__index(p1, p2)
	if u1[p2] then
		return u1[p2];
	end;
	error(tostring(p2) .. " is not a valid member of FontCreator");
end;
function v3.__newindex(p3, p4, p5)
	error("FontCreator." .. tostring(p4) .. " cannot be set");
end;
setmetatable(v2, v3);
local v4 = {};
local u2 = {};
function v4.__index(p6, p7)
	if u2[p6][p7] ~= nil then
		return u2[p6][p7];
	end;
	error(tostring(p7) .. " is not a valid member of font");
end;
function v4.__newindex(p8, p9, p10)
	error("font." .. tostring(p9) .. " cannot be set");
end;
local function v5(p11, p12)
	local v6 = {};
	for v7, v8 in pairs(p12.specialCharacters) do
		local v9 = 1;
		local v10 = #v8;
		while true do
			-- ERRORING HERE
			task.wait() 
			print("s")
			local v11, v12 = p11:find(v8, v9, true);
			if not v11 then
				break;
			end;
			v9 = v12 + 1;
			table.insert(v6, { v11, v10, v8 });		
		end;
	end;
	table.sort(v6, function(p13, p14)
		return p13[1] < p14[1];
	end);
	local v13 = v6[1];
	local u3 = nil;
	local u4 = v13 and v13[1];
	local u5 = 1;
	return coroutine.wrap(function()
		for v14, v15 in utf8.graphemes(p11) do
			if u3 then
				u3 = u3 - 1;
				if u3 == 0 then
					u3 = nil;
				end;
			elseif u4 and v14 == u4 then
				local v16 = v6[u5];
				u3 = v16[2] - 1;
				u5 = u5 + 1;
				u4 = v6[u5];
				u4 = u4 and u4[1];
				coroutine.yield(v16[3], v14, true);
			else
				coroutine.yield(p11:sub(v14, v15), v14, false);
			end;
		end;
	end);
end;
u1.iterateGraphemes = v5;
local u6 = {};
function u1.load(p15)
	if type(p15) == "string" and u6[p15] then
		return u6[p15];
	end;
	local v17 = {};
	local v18 = {};
	setmetatable(v18, v4);
	u2[v18] = v17;
	local v19 = nil;
	if type(p15) == "string" then
		local v20 = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/CustomFonts/Fonts/"..p15..".lua"))();
		if v20 == nil or type(v20) ~= "table" then
			error(tostring(p15) .. " is not a valid font name");
		end;
		v19 = v20;
	elseif type(p15) == "table" then
		v19 = p15;
		p15 = v19.name;
	end;
	for v21, v22 in next, v19 do
		v17[v21] = v22;
	end;
	local v23 = v17.isV2 and false;
	v17.isV2 = v23;
	v17.letterSpacing = v17.letterSpacing and 0;
	v17.baselineOffset = v17.baselineOffset and 0;
	if not v17.extensions then
		v17.extensions = {};
	end;
	v17.specialCharacters = {};
	v17.yScale = v17.yScale and false;
	local l__next__24 = next;
	local l__map__25 = v17.map;
	local v26 = nil;
	while true do
		--ERRORING HERE
		task.wait()
		local v27, v28 = l__next__24(l__map__25, v26);
		if not v27 then
			break;
		end;
		if utf8.len(v27) > 1 then
			table.insert(v17.specialCharacters, v27);
		end;
		local v29 = v28[6];
		if v29 then
			local v30 = v28[3];
			local v31 = v28[4];
			v28[8] = v30;
			v28[9] = v31;
			v28[3] = v30 * v29;
			v28[4] = v31 * v29;
		end;
		if v23 and not v28.NoHeightFix then
			local l__Y__32 = v28.ImageRectSize.Y;
			local l__Y__33 = v28.SpriteOffset.Y;
			local l__modeBaselineToTop__34 = v17.modeBaselineToTop;
			local v35 = -l__Y__33 < l__modeBaselineToTop__34 and l__modeBaselineToTop__34 + l__Y__33 or 0;
			local v36 = l__Y__33 + l__Y__32 < 0 and -l__Y__33 - l__Y__32 or 0;
			if v35 > 0 or v36 > 0 then
				v28.ImageRectSize = v28.ImageRectSize + Vector2.new(0, v35 + v36);
				v28.ImageRectOffset = v28.ImageRectOffset + Vector2.new(0, -v35);
				v28.SpriteOffset = v28.SpriteOffset + Vector2.new(0, -v35);
			end;
		end;	
	end;
	if not v17.baseHeight then
		local v37 = 0;
		for v38, v39 in next, v17.map do
			v37 = math.max(v37, v39[4]);
		end;
		v17.baseHeight = v37;
	end;
	v17.substitutionWidths = v17.substitutionWidths or {};
	v17.specialWordCharacters = {};
	for v40, v41 in next, v17.specialWordCharactersList or {} do
		v17.specialWordCharacters[v41] = true;
	end;
	if v17.extraAdvance then
		local l__extraAdvance__42 = v17.extraAdvance;
		for v43, v44 in pairs(v17.map) do
			v44.Advance = v44.Advance + l__extraAdvance__42;
		end;
	end;
	function v17.getCharBounds(p16)
		local v45 = v17.map[p16];
		if v45 then
			return v45, false;
		end;
		local v46 = v17.substitutionWidths[p16];
		if not v46 then
			v46 = l__TextService__1:GetTextSize(p16, math.min(100, v17.substitutionSize), v17.substitutionFont, Vector2.new(9999, 500));
			if v17.substitutionSize > 100 then
				local v47 = v17.substitutionSize / 100;
				v46 = Vector2.new(math.floor(v46.X * v47 + 0.5), math.floor(v46.Y * v47 + 0.5));
			end;
			v17.substitutionWidths[p16] = v46;
		end;
		return v46, true;
	end;
	function v17.getStringSize(p17, p18)
		local v48 = p18 / v17.baseHeight;
		local v49 = 0;
		local v50 = 0;
		local v51, v52, v53 = v5(p17, v17);
		while true do
			--ERRORING HERE
			task.wait()
			local v54 = v51(v52, v53);
			if not v54 then
				break;
			end;
			local v55, v56 = v17.getCharBounds(v54);
			local v57 = v56 and v55.Y or (v23 and v55.ImageRectSize.Y or v55[4]);
			local v58 = v48 * v57 / v17.baseHeight;
			local v59 = v57 * v58;
			local v60 = v17.extensions[v54];
			if v60 then
				v59 = v59 + (v60[1] + v60[2]) * v58;
			end;
			v49 = v49 + ((v56 and v55.X or (v23 and v55.Advance or v55[3])) + v17.letterSpacing) * v48;
			v50 = math.max(v50, v59);		
		end;
		return Vector2.new(v49, v50);
	end;
	v17.loaded = false;
	function v17.setLoaded()
		v17.loaded = true;
	end;
	u6[p15] = v18;
	return v18;
end;
return v2;

