-- Decompiled with the Synapse X Luau decompiler.

local v1 = Vector3.new(0.05, 0.05, 0.05);
local v2 = Color3.new(1, 1, 1);
local v3 = Vector3.new(0, -1, 0);
local v4 = NumberSequence.new(10);
local v5 = NumberRange.new(0.8);
local v6 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 5.33, 2.75), NumberSequenceKeypoint.new(1, 5.33, 2.75) });
local v7 = NumberRange.new(0.8);
local v8 = NumberRange.new(0, 360);
local v9 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4, 3), NumberSequenceKeypoint.new(1, 0) });
local v10 = NumberRange.new(0.1, 0.15);
local v11 = NumberRange.new(0, 360);
local v12 = Vector2.new(10, 10);
local v13 = {
	None = 0, 
	Whitelist = 1, 
	Blacklist = 2, 
	Function = 3
};
local l__Players__14 = game:GetService("Players");
local l__TweenService__15 = game:GetService("TweenService");
local l__RunService__16 = game:GetService("RunService");
local v17 = Instance.new("NumberValue");
v17.Value = 1;
local l__None__18 = v13.None;
local v19 = NumberSequenceKeypoint.new(0, 1, 0);
local v20 = NumberSequenceKeypoint.new(1, 1, 0);
local v21 = {};
for v22, v23 in pairs({ Vector3.new(0.141421363, 0, 0.141421363), Vector3.new(-0.141421363, 0, 0.141421363), Vector3.new(-0.141421363, 0, -0.141421363), Vector3.new(0.141421363, 0, -0.141421363), Vector3.new(0.400000006, 0, 0), Vector3.new(0.282842726, 0, 0.282842726), Vector3.new(2.44929371E-17, 0, 0.400000006), Vector3.new(-0.282842726, 0, 0.282842726), Vector3.new(-0.400000006, 0, 4.89858741E-17), Vector3.new(-0.282842726, 0, -0.282842726), Vector3.new(-7.34788045E-17, 0, -0.400000006), Vector3.new(0.282842726, 0, -0.282842726), Vector3.new(0.600000024, 0, 0), Vector3.new(0.485410213, 0, 0.352671146), Vector3.new(0.185410202, 0, 0.570633948), Vector3.new(-0.185410202, 0, 0.570633948), Vector3.new(-0.485410213, 0, 0.352671146), Vector3.new(-0.600000024, 0, 7.34788112E-17), Vector3.new(-0.485410213, 0, -0.352671146), Vector3.new(-0.185410202, 0, -0.570633948), Vector3.new(0.185410202, 0, -0.570633948), Vector3.new(0.485410213, 0, -0.352671146), Vector3.new(0.772740662, 0, 0.207055241), Vector3.new(0.565685451, 0, 0.565685451), Vector3.new(0.207055241, 0, 0.772740662), Vector3.new(-0.207055241, 0, 0.772740662), Vector3.new(-0.565685451, 0, 0.565685451), Vector3.new(-0.772740662, 0, 0.207055241), Vector3.new(-0.772740662, 0, -0.207055241), Vector3.new(-0.565685451, 0, -0.565685451), Vector3.new(-0.207055241, 0, -0.772740662), Vector3.new(0.207055241, 0, -0.772740662), Vector3.new(0.565685451, 0, -0.565685451), Vector3.new(0.772740662, 0, -0.207055241) }) do
	table.insert(v21, v23 * 35);
end;
table.sort(v21, function(p1, p2)
	return p1.magnitude < p2.magnitude;
end);
local v24 = Instance.new("SoundGroup");
v24.Name = "__RainSoundGroup";
v24.Volume = 0.2;
v24.Archivable = false;
local v25 = Instance.new("Sound");
v25.Name = "RainSound";
v25.Volume = 0;
v25.SoundId = "rbxassetid://9057876049";
v25.Looped = true;
v25.SoundGroup = v24;
v25.Parent = v24;
v25.Archivable = false;
local v26 = Instance.new("Part");
v26.Transparency = 1;
v26.Anchored = true;
v26.CanCollide = false;
v26.Locked = false;
v26.Archivable = false;
v26.TopSurface = Enum.SurfaceType.Smooth;
v26.BottomSurface = Enum.SurfaceType.Smooth;
v26.Name = "__RainEmitter";
v26.Size = v1;
v26.Archivable = false;
local v27 = Instance.new("ParticleEmitter");
v27.Name = "RainStraight";
v27.LightEmission = 0.05;
v27.LightInfluence = 0.9;
v27.Size = v4;
v27.Texture = "rbxassetid://1822883048";
v27.LockedToPart = true;
v27.Enabled = false;
v27.Lifetime = v5;
v27.Rate = 600;
v27.Speed = NumberRange.new(60);
v27.EmissionDirection = Enum.NormalId.Bottom;
v27.Parent = v26;
local v28 = Instance.new("ParticleEmitter");
v28.Name = "RainTopDown";
v28.LightEmission = 0.05;
v28.LightInfluence = 0.9;
v28.Size = v6;
v28.Texture = "rbxassetid://1822856633";
v28.LockedToPart = true;
v28.Enabled = false;
v28.Rotation = v8;
v28.Lifetime = v7;
v28.Rate = 600;
v28.Speed = NumberRange.new(60);
v28.EmissionDirection = Enum.NormalId.Bottom;
v28.Parent = v26;
local v29 = {};
local v30 = {};
for v31 = 1, 20 do
	local v32 = Instance.new("Attachment");
	v32.Name = "__RainSplashAttachment";
	local v33 = Instance.new("ParticleEmitter");
	v33.LightEmission = 0.05;
	v33.LightInfluence = 0.9;
	v33.Size = v9;
	v33.Texture = "rbxassetid://1822856633";
	v33.Rotation = v11;
	v33.Lifetime = v10;
	v33.Transparency = NumberSequence.new({ v19, NumberSequenceKeypoint.new(0.25, 0.6, 0), NumberSequenceKeypoint.new(0.75, 0.6, 0), v20 });
	v33.Enabled = false;
	v33.Rate = 0;
	v33.Speed = NumberRange.new(0);
	v33.Name = "RainSplash";
	v33.Parent = v32;
	v32.Archivable = false;
	table.insert(v29, v32);
	local v34 = Instance.new("Attachment");
	v34.Name = "__RainOccludedAttachment";
	local v35 = v26.RainStraight:Clone();
	v35.Speed = NumberRange.new(70, 100);
	v35.SpreadAngle = v12;
	v35.LockedToPart = false;
	v35.Enabled = false;
	v35.Parent = v34;
	local v36 = v26.RainTopDown:Clone();
	v36.Speed = NumberRange.new(70, 100);
	v36.SpreadAngle = v12;
	v36.LockedToPart = false;
	v36.Enabled = false;
	v36.Parent = v34;
	v34.Archivable = false;
	table.insert(v30, v34);
end;
local v37 = {};
local u1 = { v26 };
v37[v13.None] = function(p3, p4)
	if p4 then
		local v38 = { v26, l__Players__14.LocalPlayer and l__Players__14.LocalPlayer.Character } or u1;
	else
		v38 = u1;
	end;
	return workspace:FindPartOnRayWithIgnoreList(p3, v38);
end;
local u2 = nil;
v37[v13.Blacklist] = function(p5)
	return workspace:FindPartOnRayWithIgnoreList(p5, u2);
end;
v37[v13.Whitelist] = function(p6)
	return workspace:FindPartOnRayWithWhitelist(p6, u2);
end;
local u3 = nil;
v37[v13.Function] = function(p7)
	local v39 = p7.Origin + p7.Direction;
	while p7.Direction.magnitude > 0.001 do
		local v40, v41, v42, v43 = workspace:FindPartOnRayWithIgnoreList(p7, u1);
		if not v40 then
			return v40, v41, v42, v43;
		end;
		if u3(v40) then
			return v40, v41, v42, v43;
		end;
		local v44 = v41 + p7.Direction.Unit * 0.001;
		p7 = Ray.new(v44, v39 - v44);	
	end;
end;
local u4 = {};
local u5 = v37[l__None__18];
local u6 = v3;
local u7 = nil;
local u8 = 0;
local u9 = true;
local l__Vector3_new__10 = Vector3.new;
local u11 = 1;
local u12 = 1;
local u13 = 0;
local u14 = 0;
local function u15()
	if #u4 > 0 then
		for v45, v46 in pairs(u4) do
			v46:disconnect();
		end;
		u4 = {};
	end;
end;
local function u16(p8)
	u8 = 0;
	local v47 = l__TweenService__15:Create(v25, p8, {
		Volume = 0
	});
	v47.Completed:connect(function(p9)
		if p9 == Enum.PlaybackState.Completed then
			v25:Stop();
		end;
		v47:Destroy();
	end);
	v47:Play();
end;
local function v48(p10, p11, p12)
	local v49 = Instance.new(p10);
	if p11 then
		v49.Value = p11;
	end;
	v49.Changed:connect(p12);
	p12(v49.Value);
	return v49;
end;
local v50 = v48("Color3Value", v2, function(p13)
	local v51 = ColorSequence.new(p13);
	v26.RainStraight.Color = v51;
	v26.RainTopDown.Color = v51;
	for v52, v53 in pairs(v29) do
		v53.RainSplash.Color = v51;
	end;
	for v54, v55 in pairs(v30) do
		v55.RainStraight.Color = v51;
		v55.RainTopDown.Color = v51;
	end;
end);
local function v56(p14)
	local v57 = (1 - p14) * (1 - v17.Value);
	local v58 = 1 - v57;
	u11 = 0.7 * v57 + v58;
	u12 = 0.85 * v57 + v58;
	local v59 = NumberSequence.new({ v19, NumberSequenceKeypoint.new(0.25, v57 * 0.6 + v58, 0), NumberSequenceKeypoint.new(0.75, v57 * 0.6 + v58, 0), v20 });
	for v60, v61 in pairs(v29) do
		v61.RainSplash.Transparency = v59;
	end;
end;
local v62 = v48("NumberValue", 0, v56);
v17.Changed:connect(v56);
local v63 = {
	CollisionMode = v13
};
local function u17()
	local v64 = Random.new();
	local u18 = 6;
	local u19 = true;
	table.insert(u4, l__RunService__16.RenderStepped:connect(function()
		local v65, v66 = u5(Ray.new(workspace.CurrentCamera.CFrame.p, -u6 * 1000), true);
		if not (not u7) and not (workspace.CurrentCamera.CFrame.p.y <= u7) or not (not v65) then
			v26.RainStraight.Enabled = false;
			v26.RainTopDown.Enabled = false;
			u19 = true;
			return;
		end;
		if u8 < 1 and not u9 then
			u8 = 1;
			l__TweenService__15:Create(v25, TweenInfo.new(0.5), {
				Volume = 1
			}):Play();
		end;
		u18 = 6;
		local v67 = math.abs(workspace.CurrentCamera.CFrame.lookVector:Dot(u6));
		local l__p__68 = workspace.CurrentCamera.CFrame.p;
		local v69 = workspace.CurrentCamera.CFrame.lookVector:Cross(-u6);
		local v70 = v69.magnitude > 0.001 and v69.unit or -u6;
		local l__unit__71 = u6:Cross(v70).unit;
		v26.Size = l__Vector3_new__10(40, 40, 40 + (1 - v67) * 60);
		v26.CFrame = CFrame.new(l__p__68.x, l__p__68.y, l__p__68.z, v70.x, -u6.x, l__unit__71.x, v70.y, -u6.y, l__unit__71.y, v70.z, -u6.z, l__unit__71.z) + (1 - v67) * workspace.CurrentCamera.CFrame.lookVector * v26.Size.Z / 3 - v67 * u6 * 20;
		v26.RainStraight.Enabled = true;
		v26.RainTopDown.Enabled = true;
		u19 = false;
	end));
	table.insert(u4, (l__RunService__16:IsRunning() and l__RunService__16.Stepped or l__RunService__16.RenderStepped):connect(function()
		u18 = u18 + 1;
		if u18 >= 6 then
			local v72 = math.abs(workspace.CurrentCamera.CFrame.lookVector:Dot(u6));
			local v73 = NumberSequence.new({ v19, NumberSequenceKeypoint.new(0.25, (1 - v72) * u11 + v72, 0), NumberSequenceKeypoint.new(0.75, (1 - v72) * u11 + v72, 0), v20 });
			local v74 = NumberSequence.new({ v19, NumberSequenceKeypoint.new(0.25, v72 * u12 + (1 - v72), 0), NumberSequenceKeypoint.new(0.75, v72 * u12 + (1 - v72), 0), v20 });
			local v75 = workspace.Camera.CFrame:inverse() * (workspace.Camera.CFrame.p - u6);
			local v76 = NumberRange.new(math.deg(math.atan2(-v75.x, v75.y)));
			if u19 then
				for v77, v78 in pairs(v30) do
					v78.RainStraight.Transparency = v73;
					v78.RainStraight.Rotation = v76;
					v78.RainTopDown.Transparency = v74;
				end;
				if not u9 then
					local v79 = 0;
					if not u7 or workspace.CurrentCamera.CFrame.p.y <= u7 then
						local v80 = 35;
						local v81 = -u6 * 1000;
						for v82 = 1, #v21 do
							if not u5(Ray.new(workspace.CurrentCamera.CFrame * v21[v82], v81), true) then
								v80 = v21[v82].magnitude;
								break;
							end;
						end;
						v79 = 1 - v80 / 35;
					end;
					if math.abs(v79 - u8) > 0.01 then
						u8 = v79;
						l__TweenService__15:Create(v25, TweenInfo.new(1), {
							Volume = u8
						}):Play();
					end;
				end;
			else
				v26.RainStraight.Transparency = v73;
				v26.RainStraight.Rotation = v76;
				v26.RainTopDown.Transparency = v74;
			end;
			u18 = 0;
		end;
		local l__p__83 = workspace.CurrentCamera.CFrame.p;
		local v84 = workspace.CurrentCamera.CFrame.lookVector:Cross(-u6);
		local v85 = v84.magnitude > 0.001 and v84.unit or -u6;
		local l__unit__86 = u6:Cross(v85).unit;
		local v87 = CFrame.new(l__p__83.x, l__p__83.y, l__p__83.z, v85.x, -u6.x, l__unit__86.x, v85.y, -u6.y, l__unit__86.y, v85.z, -u6.z, l__unit__86.z);
		local v88 = u6 * 550;
		for v89 = 1, u13 do
			local v90 = v29[v89];
			local v91 = v30[v89];
			local v92 = v64:NextNumber(-100, 100);
			local v93 = v64:NextNumber(-100, 100);
			local v94, v95, v96 = u5(Ray.new(v87 * l__Vector3_new__10(v92, 500, v93), v88));
			if v94 then
				v90.Position = v95 + v96 * 0.5;
				v90.RainSplash:Emit(1);
				if u19 then
					local v97 = v95 - u6 * 50;
					if u7 and u7 < v97.Y and u6.Y < 0 then
						v97 = v97 + u6 * (u7 - v97.Y) / u6.Y;
					end;
					v91.CFrame = v87 - v87.p + v97;
					v91.RainStraight:Emit(u14);
					v91.RainTopDown:Emit(u14);
				end;
			elseif u19 then
				local v98 = v87 * l__Vector3_new__10(v92, v64:NextNumber(20, 100), v93);
				if u7 and u7 < v98.Y and u6.Y < 0 then
					v98 = v98 + u6 * (u7 - v98.Y) / u6.Y;
				end;
				v91.CFrame = v87 - v87.p + v98;
				v91.RainStraight:Emit(u14);
				v91.RainTopDown:Emit(u14);
			end;
		end;
	end));
end;
function v63.Enable(p15, p16)
	if p16 ~= nil and typeof(p16) ~= "TweenInfo" then
		error("bad argument #1 to 'Enable' (TweenInfo expected, got " .. typeof(p16) .. ")", 2);
	end;
	u15();
	v26.RainStraight.Enabled = true;
	v26.RainTopDown.Enabled = true;
	v26.Parent = workspace.CurrentCamera;
	for v99 = 1, 20 do
		v29[v99].Parent = workspace.Terrain;
		v30[v99].Parent = workspace.Terrain;
	end;
	if l__RunService__16:IsRunning() then
		v24.Parent = game:GetService("SoundService");
	end;
	u17();
	if p16 then
		l__TweenService__15:Create(v17, p16, {
			Value = 0
		}):Play();
	else
		v17.Value = 0;
	end;
	if not v25.Playing then
		v25:Play();
		v25.TimePosition = math.random() * v25.TimeLength;
	end;
	u9 = false;
end;
local function u20()
	u15();
	v26.RainStraight.Enabled = false;
	v26.RainTopDown.Enabled = false;
	v26.Size = v1;
	if not u9 then
		u16(TweenInfo.new(1));
	end;
end;
function v63.Disable(p17, p18)
	if p18 ~= nil and typeof(p18) ~= "TweenInfo" then
		error("bad argument #1 to 'Disable' (TweenInfo expected, got " .. typeof(p18) .. ")", 2);
	end;
	if p18 then
		local v100 = l__TweenService__15:Create(v17, p18, {
			Value = 1
		});
		v100.Completed:connect(function(p19)
			if p19 == Enum.PlaybackState.Completed then
				u20();
			end;
			v100:Destroy();
		end);
		v100:Play();
		u16(p18);
	else
		v17.Value = 1;
		u20();
	end;
	u9 = true;
end;
function v63.SetColor(p20, p21, p22)
	if typeof(p21) ~= "Color3" then
		error("bad argument #1 to 'SetColor' (Color3 expected, got " .. typeof(p21) .. ")", 2);
	elseif p22 ~= nil and typeof(p22) ~= "TweenInfo" then
		error("bad argument #2 to 'SetColor' (TweenInfo expected, got " .. typeof(p22) .. ")", 2);
	end;
	if not p22 then
		v50.Value = p21;
		return;
	end;
	l__TweenService__15:Create(v50, p22, {
		Value = p21
	}):Play();
end;
local function v101(p23, p24)
	return function(p25, p26, p27)
		if typeof(p26) ~= "number" then
			error("bad argument #1 to '" .. p23 .. "' (number expected, got " .. typeof(p26) .. ")", 2);
		elseif p27 ~= nil and typeof(p27) ~= "TweenInfo" then
			error("bad argument #2 to '" .. p23 .. "' (TweenInfo expected, got " .. typeof(p27) .. ")", 2);
		end;
		p26 = math.clamp(p26, 0, 1);
		if not p27 then
			p24.Value = p26;
			return;
		end;
		l__TweenService__15:Create(p24, p27, {
			Value = p26
		}):Play();
	end;
end;
v63.SetTransparency = v101("SetTransparency", v62);
v63.SetSpeedRatio = v101("SetSpeedRatio", (v48("NumberValue", 1, function(p28)
	v26.RainStraight.Speed = NumberRange.new(p28 * 60);
	v26.RainTopDown.Speed = NumberRange.new(p28 * 60);
end)));
v63.SetIntensityRatio = v101("SetIntensityRatio", (v48("NumberValue", 1, function(p29)
	v26.RainStraight.Rate = 600 * p29;
	v26.RainTopDown.Rate = 600 * p29;
	u14 = math.ceil(2 * p29);
	u13 = 20 * p29;
end)));
v63.SetLightEmission = v101("SetLightEmission", (v48("NumberValue", 0.05, function(p30)
	v26.RainStraight.LightEmission = p30;
	v26.RainTopDown.LightEmission = p30;
	for v102, v103 in pairs(v30) do
		v103.RainStraight.LightEmission = p30;
		v103.RainTopDown.LightEmission = p30;
	end;
	for v104, v105 in pairs(v29) do
		v105.RainSplash.LightEmission = p30;
	end;
end)));
v63.SetLightInfluence = v101("SetLightInfluence", (v48("NumberValue", 0.9, function(p31)
	v26.RainStraight.LightInfluence = p31;
	v26.RainTopDown.LightInfluence = p31;
	for v106, v107 in pairs(v30) do
		v107.RainStraight.LightInfluence = p31;
		v107.RainTopDown.LightInfluence = p31;
	end;
	for v108, v109 in pairs(v29) do
		v109.RainSplash.LightInfluence = p31;
	end;
end)));
function v63.SetVolume(p32, p33, p34)
	if typeof(p33) ~= "number" then
		error("bad argument #1 to 'SetVolume' (number expected, got " .. typeof(p33) .. ")", 2);
	elseif p34 ~= nil and typeof(p34) ~= "TweenInfo" then
		error("bad argument #2 to 'SetVolume' (TweenInfo expected, got " .. typeof(p34) .. ")", 2);
	end;
	if not p34 then
		v24.Volume = p33;
		return;
	end;
	l__TweenService__15:Create(v24, p34, {
		Volume = p33
	}):Play();
end;
local u21 = v48("Vector3Value", v3, function(p35)
	if p35.magnitude > 0.001 then
		u6 = p35.unit;
	end;
end);
function v63.SetDirection(p36, p37, p38)
	if typeof(p37) ~= "Vector3" then
		error("bad argument #1 to 'SetDirection' (Vector3 expected, got " .. typeof(p37) .. ")", 2);
	elseif p38 ~= nil and typeof(p38) ~= "TweenInfo" then
		error("bad argument #2 to 'SetDirection' (TweenInfo expected, got " .. typeof(p38) .. ")", 2);
	end;
	if not (p37.unit.magnitude > 0) then
		warn("Attempt to set rain direction to a zero-length vector, falling back on default direction = (" .. tostring(v3) .. ")");
		p37 = v3;
	end;
	if not p38 then
		u21.Value = p37;
		return;
	end;
	l__TweenService__15:Create(u21, p38, {
		Value = p37
	}):Play();
end;
function v63.SetCeiling(p39, p40)
	if p40 ~= nil and typeof(p40) ~= "number" then
		error("bad argument #1 to 'SetCeiling' (number expected, got " .. typeof(p40) .. ")", 2);
	end;
	u7 = p40;
end;
function v63.SetStraightTexture(p41, p42)
	if typeof(p42) ~= "string" then
		error("bad argument #1 to 'SetStraightTexture' (string expected, got " .. typeof(p42) .. ")", 2);
	end;
	v26.RainStraight.Texture = p42;
	for v110, v111 in pairs(v30) do
		v111.RainStraight.Texture = p42;
	end;
end;
function v63.SetTopDownTexture(p43, p44)
	if typeof(p44) ~= "string" then
		error("bad argument #1 to 'SetStraightTexture' (string expected, got " .. typeof(p44) .. ")", 2);
	end;
	v26.RainTopDown.Texture = p44;
	for v112, v113 in pairs(v30) do
		v113.RainTopDown.Texture = p44;
	end;
end;
function v63.SetSplashTexture(p45, p46)
	if typeof(p46) ~= "string" then
		error("bad argument #1 to 'SetStraightTexture' (string expected, got " .. typeof(p46) .. ")", 2);
	end;
	for v114, v115 in pairs(v29) do
		v115.RainSplash.Texture = p46;
	end;
end;
function v63.SetSoundId(p47, p48)
	if typeof(p48) ~= "string" then
		error("bad argument #1 to 'SetSoundId' (string expected, got " .. typeof(p48) .. ")", 2);
	end;
	v25.SoundId = p48;
end;
local u22 = l__None__18;
function v63.SetCollisionMode(p49, p50, p51)
	if p50 == v13.None then
		u2 = nil;
		u3 = nil;
	elseif p50 == v13.Blacklist then
		if typeof(p51) == "Instance" then
			u2 = { p51, v26 };
		elseif typeof(p51) == "table" then
			for v116 = 1, #p51 do
				if typeof(p51[v116]) ~= "Instance" then
					error("bad argument #2 to 'SetCollisionMode' (blacklist contained a " .. typeof(p51[v116]) .. " on index " .. tostring(v116) .. " which is not an Instance)", 2);
				end;
			end;
			u2 = { v26 };
			for v117 = 1, #p51 do
				table.insert(u2, p51[v117]);
			end;
		else
			error("bad argument #2 to 'SetCollisionMode (Instance or array of Instance expected, got " .. typeof(p51) .. ")'", 2);
		end;
		u3 = nil;
	elseif p50 == v13.Whitelist then
		if typeof(p51) == "Instance" then
			u2 = { p51 };
		elseif typeof(p51) == "table" then
			for v118 = 1, #p51 do
				if typeof(p51[v118]) ~= "Instance" then
					error("bad argument #2 to 'SetCollisionMode' (whitelist contained a " .. typeof(p51[v118]) .. " on index " .. tostring(v118) .. " which is not an Instance)", 2);
				end;
			end;
			u2 = {};
			for v119 = 1, #p51 do
				table.insert(u2, p51[v119]);
			end;
		else
			error("bad argument #2 to 'SetCollisionMode (Instance or array of Instance expected, got " .. typeof(p51) .. ")'", 2);
		end;
		u3 = nil;
	elseif p50 == v13.Function then
		if typeof(p51) ~= "function" then
			error("bad argument #2 to 'SetCollisionMode' (function expected, got " .. typeof(p51) .. ")", 2);
		end;
		u2 = nil;
		u3 = p51;
	else
		error("bad argument #1 to 'SetCollisionMode (Rain.CollisionMode expected, got " .. typeof(p51) .. ")'", 2);
	end;
	u22 = p50;
	u5 = v37[p50];
end;
return v63;
