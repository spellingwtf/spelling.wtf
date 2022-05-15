-- Decompiled with the Synapse X Luau decompiler.

function DiscretePulse(p1, p2, p3, p4, p5, p6, p7)
	return math.clamp(p3 / (2 * p4) - math.abs((p1 - p5 * p2 + 0.5 * p3) / p4), p6, p7);
end;
function NoiseBetween(p8, p9, p10, p11, p12)
	return p11 + (p12 - p11) * (math.noise(p8, p9, p10) + 0.5);
end;
function CubicBezier(p13, p14, p15, p16, p17)
	return p13 * (1 - p17) ^ 3 + p14 * 3 * p17 * (1 - p17) ^ 2 + p15 * 3 * (1 - p17) * p17 ^ 2 + p16 * p17 ^ 3;
end;
local v1 = Instance.new("ImageHandleAdornment");
v1.Name = "BoltAdorn";
v1.Image = "http://www.roblox.com/asset/?id=4955566540";
v1.Transparency = 1;
v1.Color3 = Color3.new(1, 1, 1);
v1.ZIndex = 0;
v1.Size = Vector2.new(0, 0);
local v2 = Random.new();
local v3 = {};
v3.__index = v3;
local u1 = nil;
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local u3 = nil;
local u4 = nil;
local l__os_clock__5 = os.clock;
local u6 = {};
function v3.new(p18, p19, p20)
	local v4 = setmetatable({}, v3);
	v4.Enabled = true;
	v4.Attachment0 = p18;
	v4.Attachment1 = p19;
	v4.CurveSize0 = 0;
	v4.CurveSize1 = 0;
	v4.MinRadius = 0;
	v4.MaxRadius = 2.4;
	v4.Frequency = 1;
	v4.AnimationSpeed = 7;
	v4.Thickness = 2;
	v4.MinThicknessMultiplier = 0.2;
	v4.MaxThicknessMultiplier = 1;
	v4.MinTransparency = 0;
	v4.MaxTransparency = 1;
	v4.PulseSpeed = 2;
	v4.PulseLength = 1000000;
	v4.FadeLength = 0.2;
	v4.ContractFrom = 0.5;
	v4.Color = Color3.new(1, 1, 1);
	v4.ColorOffsetSpeed = 3;
	v4.Parts = {};
	u1 = workspace.CurrentCamera;
	if l__LocalPlayer__2.PlayerGui:FindFirstChild("LightningBeams") == nil then
		u3 = Instance.new("ScreenGui");
		u3.Name = "LightningBeams";
		u3.ResetOnSpawn = false;
		u3.Parent = l__LocalPlayer__2.PlayerGui;
		u4 = Instance.new("Part");
		u4.Anchored = true;
		u4.Locked = true;
		u4.CanCollide = false;
		u4.CFrame = CFrame.new();
		u4.Size = Vector3.new(0, 0, 0);
		u4.Transparency = 1;
		u4.Parent = u3;
		u4.Name = "AdorneePart";
	end;
	local l__WorldPosition__5 = p18.WorldPosition;
	local v6 = p18.WorldPosition + p18.WorldAxis * v4.CurveSize0;
	local v7 = p19.WorldPosition - p19.WorldAxis * v4.CurveSize1;
	local l__WorldPosition__8 = p19.WorldPosition;
	local v9 = l__WorldPosition__5;
	local v10 = p20 and 30;
	for v11 = 1, v10 do
		local v12 = CubicBezier(l__WorldPosition__5, v6, v7, l__WorldPosition__8, v11 / v10);
		local v13 = v11 ~= v10 and CFrame.lookAt(v9, v12).Position or v12;
		local v14 = v1:Clone();
		v14.Parent = u3;
		v14.Adornee = u4;
		v4.Parts[v11] = v14;
		v9 = v12;
	end;
	v4.PartsHidden = false;
	v4.DisabledTransparency = 1;
	v4.StartT = l__os_clock__5();
	v4.RanNum = math.random() * 100;
	v4.RefIndex = #u6 + 1;
	u6[v4.RefIndex] = v4;
	return v4;
end;
function v3.Destroy(p21)
	u6[p21.RefIndex] = nil;
	for v15 = 1, #p21.Parts do
		p21.Parts[v15]:Destroy();
		if v15 % 100 == 0 then
			wait();
		end;
	end;
	p21 = nil;
end;
local u7 = math.cos(math.rad(90));
local l__Cross__8 = Vector3.new().Cross;
game:GetService("RunService").Heartbeat:Connect(function()
	for v16, v17 in pairs(u6) do
		if v17.Enabled == true then
			v17.PartsHidden = false;
			local v18 = 1 - v17.MaxTransparency;
			local v19 = 1 - v17.MinTransparency;
			local l__MinRadius__20 = v17.MinRadius;
			local l__MaxRadius__21 = v17.MaxRadius;
			local l__Thickness__22 = v17.Thickness;
			local l__Parts__23 = v17.Parts;
			local v24 = #l__Parts__23;
			local l__RanNum__25 = v17.RanNum;
			local l__AnimationSpeed__26 = v17.AnimationSpeed;
			local l__Frequency__27 = v17.Frequency;
			local l__MinThicknessMultiplier__28 = v17.MinThicknessMultiplier;
			local l__MaxThicknessMultiplier__29 = v17.MaxThicknessMultiplier;
			local l__Attachment0__30 = v17.Attachment0;
			local l__Attachment1__31 = v17.Attachment1;
			local l__WorldPosition__32 = l__Attachment0__30.WorldPosition;
			local v33 = l__Attachment0__30.WorldPosition + l__Attachment0__30.WorldAxis * v17.CurveSize0;
			local v34 = l__Attachment1__31.WorldPosition - l__Attachment1__31.WorldAxis * v17.CurveSize1;
			local l__WorldPosition__35 = l__Attachment1__31.WorldPosition;
			local v36 = l__os_clock__5() - v17.StartT;
			local l__PulseLength__37 = v17.PulseLength;
			local l__PulseSpeed__38 = v17.PulseSpeed;
			local l__FadeLength__39 = v17.FadeLength;
			local l__Color__40 = v17.Color;
			local l__ColorOffsetSpeed__41 = v17.ColorOffsetSpeed;
			local v42 = 1 - v17.ContractFrom;
			local v43 = l__WorldPosition__32;
			local v44 = l__WorldPosition__32;
			if v36 < (l__PulseLength__37 + 1) / l__PulseSpeed__38 then
				for v45 = 1, v24 do
					local v46 = l__Parts__23[v45];
					local v47 = v45 / v24;
					local v48 = DiscretePulse(v47, l__PulseSpeed__38, l__PulseLength__37, l__FadeLength__39, v36, v18, v19);
					local v49 = CubicBezier(l__WorldPosition__32, v33, v34, l__WorldPosition__35, v47);
					local v50 = -v36;
					local v51 = l__AnimationSpeed__26 * v50 + l__Frequency__27 * 10 * v47 - 0.2 + l__RanNum__25 * 4;
					local v52 = 5 * (l__AnimationSpeed__26 * 0.01 * v50 / 10 + l__Frequency__27 * v47) + l__RanNum__25 * 4;
					local v53 = NoiseBetween(5 * v51, 1.5, 1 * v52, 0, 0.2 * math.pi) + NoiseBetween(0.5 * v51, 1.5, 0.1 * v52, 0, 1.8 * math.pi);
					local v54 = NoiseBetween(3.4, v52, v51, l__MinRadius__20, l__MaxRadius__21) * math.exp(-5000 * (v47 - 0.5) ^ 10);
					local v55 = NoiseBetween(2.3, v52, v51, l__MinThicknessMultiplier__28, l__MaxThicknessMultiplier__29);
					if v45 ~= v24 then
						local v56 = (CFrame.new(v44, v49) * CFrame.Angles(0, 0, v53) * CFrame.Angles(math.acos(math.clamp(NoiseBetween(v52, v51, 2.7, u7, 1), -1, 1)), 0, 0) * CFrame.new(0, 0, -v54)).Position or v49;
					else
						v56 = v49;
					end;
					local v57 = v56 - v43;
					if v42 < v48 then
						v46.Size = Vector2.new(l__Thickness__22 * v55 * v48, v57.Magnitude + l__Thickness__22 * v55 * v48 * 0.2);
						local v58 = 0.5 * (v43 + v56);
						local l__Unit__59 = v57.Unit;
						v46.CFrame = CFrame.fromMatrix(v58, l__Cross__8(u1.CFrame.Position - v58, l__Unit__59).Unit, l__Unit__59);
						v46.Transparency = 1 - v48;
					elseif v42 - 1 / (v24 * l__FadeLength__39) < v48 then
						if v47 < v36 * l__PulseSpeed__38 - 0.5 * l__PulseLength__37 then
							local v60 = 1;
						else
							v60 = -1;
						end;
						local v61 = (1 - (v48 - (v42 - 1 / (v24 * l__FadeLength__39))) * v24 * l__FadeLength__39) * v60;
						v46.Size = Vector2.new(l__Thickness__22 * v55 * v48, (1 - math.abs(v61)) * v57.Magnitude + l__Thickness__22 * v55 * v48 * 0.2);
						local v62 = v43 + (v56 - v43) * (math.max(0, v61) + 0.5 * (1 - math.abs(v61)));
						local l__Unit__63 = v57.Unit;
						v46.CFrame = CFrame.fromMatrix(v62, l__Cross__8(u1.CFrame.Position - v62, l__Unit__63).Unit, l__Unit__63);
						v46.Transparency = 1 - v48;
					else
						v46.Transparency = 1;
					end;
					if typeof(l__Color__40) == "Color3" then
						v46.Color3 = l__Color__40;
					else
						local v64 = (l__RanNum__25 + v47 - v36 * l__ColorOffsetSpeed__41) % 1;
						local l__Keypoints__65 = l__Color__40.Keypoints;
						for v66 = 1, #l__Keypoints__65 - 1 do
							if l__Keypoints__65[v66].Time < v64 and v64 < l__Keypoints__65[v66 + 1].Time then
								v46.Color3 = l__Keypoints__65[v66].Value:lerp(l__Keypoints__65[v66 + 1].Value, (v64 - l__Keypoints__65[v66].Time) / (l__Keypoints__65[v66 + 1].Time - l__Keypoints__65[v66].Time));
								break;
							end;
						end;
					end;
					v43 = v56;
					v44 = v49;
				end;
			else
				v17:Destroy();
			end;
		elseif v17.PartsHidden == false then
			v17.PartsHidden = true;
			local l__DisabledTransparency__67 = v17.DisabledTransparency;
			for v68 = 1, #v17.Parts do
				v17.Parts[v68].Transparency = l__DisabledTransparency__67;
			end;
		end;
	end;
end);
return v3;
