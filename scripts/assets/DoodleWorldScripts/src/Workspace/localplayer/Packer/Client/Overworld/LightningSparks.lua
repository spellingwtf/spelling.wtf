-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
v1.__index = v1;
local u1 = {};
function v1.new(p1, p2)
	local v2 = setmetatable({}, v1);
	v2.Enabled = true;
	v2.LightningBolt = p1;
	v2.MaxSparkCount = p2 and 10;
	v2.MinSpeed = 4;
	v2.MaxSpeed = 6;
	v2.MinDistance = 3;
	v2.MaxDistance = 6;
	v2.MinPartsPerSpark = 8;
	v2.MaxPartsPerSpark = 10;
	v2.SparksN = 0;
	v2.SlotTable = {};
	v2.RefIndex = #u1 + 1;
	u1[v2.RefIndex] = v2;
	return v2;
end;
function v1.Destroy(p3)
	u1[p3.RefIndex] = nil;
	for v3, v4 in pairs(p3.SlotTable) do
		if v4.Parts[1].Parent == nil then
			p3.SlotTable[v3] = nil;
		end;
	end;
	p3 = nil;
end;
local u2 = Random.new();
function RandomVectorOffset(p4, p5)
	return (CFrame.lookAt(Vector3.new(), p4) * CFrame.Angles(0, 0, u2:NextNumber(0, 2 * math.pi)) * CFrame.Angles(math.acos(u2:NextNumber(math.cos(p5), 1)), 0, 0)).LookVector;
end;
local u3 = require(script.Parent.LightningBolt);
game:GetService("RunService").Heartbeat:Connect(function()
	local v5, v6, v7 = pairs(u1);
	while true do
		local v8, v9 = v5(v6, v7);
		if not v8 then
			break;
		end;
		if v9.Enabled == true and v9.SparksN < v9.MaxSparkCount then
			local l__LightningBolt__10 = v9.LightningBolt;
			if l__LightningBolt__10.Parts[1] == nil then
				v9:Destroy();
				return;
			end;
			if l__LightningBolt__10.Parts[1].Parent == nil then
				v9:Destroy();
				return;
			end;
			local l__Parts__11 = l__LightningBolt__10.Parts;
			local v12 = #l__Parts__11;
			local v13 = {};
			for v14 = 1, #l__Parts__11 do
				if l__Parts__11[v14].Transparency < 0.3 then
					v13[#v13 + 1] = (v14 - 0.5) / v12;
				end;
			end;
			local v15 = nil;
			local v16 = nil;
			if #v13 ~= 0 then
				v15 = math.ceil(v13[1] * v9.MaxSparkCount);
				v16 = math.ceil(v13[#v13] * v9.MaxSparkCount);
			end;
			for v17 = 1, u2:NextInteger(1, v9.MaxSparkCount - v9.SparksN) do
				if #v13 == 0 then
					break;
				end;
				local v18 = {};
				for v19 = v15, v16 do
					if v9.SlotTable[v19] == nil then
						v18[#v18 + 1] = v19;
					end;
				end;
				if #v18 ~= 0 then
					local v20 = v18[u2:NextInteger(1, #v18)];
					local v21 = u2:NextNumber(-0.5, 0.5);
					local v22 = (v20 - 0.5 + v21) / v9.MaxSparkCount;
					local v23 = 10;
					local v24 = 1;
					for v25 = 1, #v13 do
						local v26 = math.abs(v13[v25] - v22);
						if v26 < v23 then
							v23 = v26;
							v24 = math.floor(v13[v25] * v12 + 0.5 + 0.5);
						end;
					end;
					local v27 = l__Parts__11[v24];
					local v28 = {};
					local v29 = {};
					v28.WorldPosition = v27.CFrame.Position + v21 * v27.CFrame.UpVector * v27.Size.Y;
					v29.WorldPosition = v28.WorldPosition + RandomVectorOffset(v27.CFrame.UpVector, math.pi / 4) * u2:NextNumber(v9.MinDistance, v9.MaxDistance);
					v28.WorldAxis = (v29.WorldPosition - v28.WorldPosition).Unit;
					v29.WorldAxis = v28.WorldAxis;
					local v30 = u3.new(v28, v29, u2:NextInteger(v9.MinPartsPerSpark, v9.MaxPartsPerSpark));
					v30.MinRadius = 0;
					v30.MaxRadius = 0.8;
					v30.AnimationSpeed = 0;
					v30.Thickness = v27.Size.X / 1.2;
					v30.MinThicknessMultiplier = 1;
					v30.MaxThicknessMultiplier = 1;
					v30.PulseLength = 0.5;
					v30.PulseSpeed = u2:NextNumber(v9.MinSpeed, v9.MaxSpeed);
					v30.FadeLength = 0.25;
					local v31, v32, v33 = Color3.toHSV(v27.Color3);
					v30.Color = Color3.fromHSV(v31, 0.5, v33);
					v9.SlotTable[v20] = v30;
				end;
			end;
		end;
		local v34 = 0;
		for v35, v36 in pairs(v9.SlotTable) do
			if v36.Parts[1].Parent ~= nil then
				v34 = v34 + 1;
			else
				v9.SlotTable[v35] = nil;
			end;
		end;
		v9.SparksN = v34;	
	end;
end);
return v1;
