-- Decompiled with the Synapse X Luau decompiler.

local v1, v2 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserCameraInputRefactor");
end);
local v3 = Vector3.new(0, 0, 1);
local v4 = Vector3.new(1, 0, 1);
local v5 = Vector2.new(0, 0);
local v6 = {
	InitialDistance = 25, 
	MinDistance = 10, 
	MaxDistance = 100, 
	InitialElevation = 35, 
	MinElevation = 35, 
	MaxElevation = 35, 
	ReferenceAzimuth = -45, 
	CWAzimuthTravel = 90, 
	CCWAzimuthTravel = 90, 
	UseAzimuthLimits = false
};
local v7 = require(script.Parent:WaitForChild("BaseCamera"));
local v8 = setmetatable({}, v7);
v8.__index = v8;
function v8.new()
	local v9 = setmetatable(v7.new(), v8);
	v9.lastUpdate = tick();
	v9.changedSignalConnections = {};
	v9.refAzimuthRad = nil;
	v9.curAzimuthRad = nil;
	v9.minAzimuthAbsoluteRad = nil;
	v9.maxAzimuthAbsoluteRad = nil;
	v9.useAzimuthLimits = nil;
	v9.curElevationRad = nil;
	v9.minElevationRad = nil;
	v9.maxElevationRad = nil;
	v9.curDistance = nil;
	v9.minDistance = nil;
	v9.maxDistance = nil;
	v9.r3ButtonDown = false;
	v9.l3ButtonDown = false;
	v9.gamepadDollySpeedMultiplier = 1;
	v9.lastUserPanCamera = tick();
	v9.externalProperties = {};
	v9.externalProperties.InitialDistance = 25;
	v9.externalProperties.MinDistance = 10;
	v9.externalProperties.MaxDistance = 100;
	v9.externalProperties.InitialElevation = 35;
	v9.externalProperties.MinElevation = 35;
	v9.externalProperties.MaxElevation = 35;
	v9.externalProperties.ReferenceAzimuth = -45;
	v9.externalProperties.CWAzimuthTravel = 90;
	v9.externalProperties.CCWAzimuthTravel = 90;
	v9.externalProperties.UseAzimuthLimits = false;
	v9:LoadNumberValueParameters();
	return v9;
end;
function v8.LoadOrCreateNumberValueParameter(p1, p2, p3, p4)
	local v10 = script:FindFirstChild(p2);
	if v10 and v10:isA(p3) then
		p1.externalProperties[p2] = v10.Value;
	else
		if p1.externalProperties[p2] == nil then
			return;
		end;
		v10 = Instance.new(p3);
		v10.Name = p2;
		v10.Parent = script;
		v10.Value = p1.externalProperties[p2];
	end;
	if p4 then
		if p1.changedSignalConnections[p2] then
			p1.changedSignalConnections[p2]:Disconnect();
		end;
		p1.changedSignalConnections[p2] = v10.Changed:Connect(function(p5)
			p1.externalProperties[p2] = p5;
			p4(p1);
		end);
	end;
end;
function v8.SetAndBoundsCheckAzimuthValues(p6)
	p6.minAzimuthAbsoluteRad = math.rad(p6.externalProperties.ReferenceAzimuth) - math.abs(math.rad(p6.externalProperties.CWAzimuthTravel));
	p6.maxAzimuthAbsoluteRad = math.rad(p6.externalProperties.ReferenceAzimuth) + math.abs(math.rad(p6.externalProperties.CCWAzimuthTravel));
	p6.useAzimuthLimits = p6.externalProperties.UseAzimuthLimits;
	if p6.useAzimuthLimits then
		p6.curAzimuthRad = math.max(p6.curAzimuthRad, p6.minAzimuthAbsoluteRad);
		p6.curAzimuthRad = math.min(p6.curAzimuthRad, p6.maxAzimuthAbsoluteRad);
	end;
end;
function v8.SetAndBoundsCheckElevationValues(p7)
	local v11 = math.max(p7.externalProperties.MinElevation, -80);
	local v12 = math.min(p7.externalProperties.MaxElevation, 80);
	p7.minElevationRad = math.rad(math.min(v11, v12));
	p7.maxElevationRad = math.rad(math.max(v11, v12));
	p7.curElevationRad = math.max(p7.curElevationRad, p7.minElevationRad);
	p7.curElevationRad = math.min(p7.curElevationRad, p7.maxElevationRad);
end;
function v8.SetAndBoundsCheckDistanceValues(p8)
	p8.minDistance = p8.externalProperties.MinDistance;
	p8.maxDistance = p8.externalProperties.MaxDistance;
	p8.curDistance = math.max(p8.curDistance, p8.minDistance);
	p8.curDistance = math.min(p8.curDistance, p8.maxDistance);
end;
function v8.LoadNumberValueParameters(p9)
	p9:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil);
	p9:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil);
	p9:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", p9.SetAndBoundsCheckAzimuthValue);
	p9:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", p9.SetAndBoundsCheckAzimuthValues);
	p9:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", p9.SetAndBoundsCheckAzimuthValues);
	p9:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", p9.SetAndBoundsCheckElevationValues);
	p9:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", p9.SetAndBoundsCheckElevationValues);
	p9:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", p9.SetAndBoundsCheckDistanceValues);
	p9:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", p9.SetAndBoundsCheckDistanceValues);
	p9:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", p9.SetAndBoundsCheckAzimuthValues);
	p9.curAzimuthRad = math.rad(p9.externalProperties.ReferenceAzimuth);
	p9.curElevationRad = math.rad(p9.externalProperties.InitialElevation);
	p9.curDistance = p9.externalProperties.InitialDistance;
	p9:SetAndBoundsCheckAzimuthValues();
	p9:SetAndBoundsCheckElevationValues();
	p9:SetAndBoundsCheckDistanceValues();
end;
function v8.GetModuleName(p10)
	return "OrbitalCamera";
end;
local u1 = require(script.Parent:WaitForChild("CameraUtils"));
function v8.SetInitialOrientation(p11, p12)
	if not p12 or not p12.RootPart then
		warn("OrbitalCamera could not set initial orientation due to missing humanoid");
		return;
	end;
	local l__unit__13 = (p12.RootPart.CFrame.lookVector - Vector3.new(0, 0.23, 0)).unit;
	local v14 = u1.GetAngleBetweenXZVectors(l__unit__13, p11:GetCameraLookVector());
	local v15 = math.asin(p11:GetCameraLookVector().y) - math.asin(l__unit__13.y);
	if not u1.IsFinite(v14) then
		v14 = 0;
	end;
	if not u1.IsFinite(v15) then
		v15 = 0;
	end;
	p11.rotateInput = Vector2.new(v14, v15);
end;
function v8.GetCameraToSubjectDistance(p13)
	return p13.curDistance;
end;
local l__Players__2 = game:GetService("Players");
function v8.SetCameraToSubjectDistance(p14, p15)
	if l__Players__2.LocalPlayer then
		p14.currentSubjectDistance = math.clamp(p15, p14.minDistance, p14.maxDistance);
		p14.currentSubjectDistance = math.max(p14.currentSubjectDistance, p14.FIRST_PERSON_DISTANCE_THRESHOLD);
	end;
	p14.inFirstPerson = false;
	p14:UpdateMouseBehavior();
	return p14.currentSubjectDistance;
end;
local u3 = Vector3.new(0, 0, 0);
function v8.CalculateNewLookVector(p16, p17, p18)
	local v16 = p17 or p16:GetCameraLookVector();
	local v17 = math.asin(v16.y);
	local v18 = Vector2.new(p18.x, (math.clamp(p18.y, v17 - math.rad(80), v17 - math.rad(-80))));
	return (CFrame.Angles(0, -v18.x, 0) * CFrame.new(u3, v16) * CFrame.Angles(-v18.y, 0, 0)).lookVector;
end;
local u4 = v1 or v2;
function v8.GetGamepadPan(p19, p20, p21, p22)
	assert(not u4);
	if p22.UserInputType ~= p19.activeGamepad or p22.KeyCode ~= Enum.KeyCode.Thumbstick2 then
		return Enum.ContextActionResult.Pass;
	end;
	if p19.r3ButtonDown or p19.l3ButtonDown then
		if p22.Position.Y > 0.2 then
			p19.gamepadDollySpeedMultiplier = 0.96;
		elseif p22.Position.Y < -0.2 then
			p19.gamepadDollySpeedMultiplier = 1.04;
		else
			p19.gamepadDollySpeedMultiplier = 1;
		end;
	else
		if p21 == Enum.UserInputState.Cancel then
			p19.gamepadPanningCamera = v5;
			return;
		end;
		if Vector2.new(p22.Position.X, -p22.Position.Y).magnitude > 0.2 then
			p19.gamepadPanningCamera = Vector2.new(p22.Position.X, -p22.Position.Y);
		else
			p19.gamepadPanningCamera = v5;
		end;
	end;
	return Enum.ContextActionResult.Sink;
end;
function v8.DoGamepadZoom(p23, p24, p25, p26)
	assert(not u4);
	if p26.UserInputType ~= p23.activeGamepad or p26.KeyCode ~= Enum.KeyCode.ButtonR3 and p26.KeyCode ~= Enum.KeyCode.ButtonL3 then
		return Enum.ContextActionResult.Pass;
	end;
	if p25 == Enum.UserInputState.Begin then
		p23.r3ButtonDown = p26.KeyCode == Enum.KeyCode.ButtonR3;
		p23.l3ButtonDown = p26.KeyCode == Enum.KeyCode.ButtonL3;
	elseif p25 == Enum.UserInputState.End then
		if p26.KeyCode == Enum.KeyCode.ButtonR3 then
			p23.r3ButtonDown = false;
		elseif p26.KeyCode == Enum.KeyCode.ButtonL3 then
			p23.l3ButtonDown = false;
		end;
		if not p23.r3ButtonDown and not p23.l3ButtonDown then
			p23.gamepadDollySpeedMultiplier = 1;
		end;
	end;
	return Enum.ContextActionResult.Sink;
end;
function v8.BindGamepadInputActions(p27)
	assert(not u4);
	p27:BindAction("OrbitalCamGamepadPan", function(p28, p29, p30)
		return p27:GetGamepadPan(p28, p29, p30);
	end, false, Enum.KeyCode.Thumbstick2);
	p27:BindAction("OrbitalCamGamepadZoom", function(p31, p32, p33)
		return p27:DoGamepadZoom(p31, p32, p33);
	end, false, Enum.KeyCode.ButtonR3, Enum.KeyCode.ButtonL3);
end;
local u5 = require(script.Parent:WaitForChild("CameraInput"));
local l__VRService__6 = game:GetService("VRService");
local u7 = 2 * math.pi;
function v8.Update(p34, p35)
	local v19 = tick();
	local v20 = v19 - p34.lastUpdate;
	if u4 then
		local v21 = u5.getRotation() ~= Vector2.new();
	else
		v21 = p34.userPanningTheCamera == true;
	end;
	local l__CurrentCamera__22 = workspace.CurrentCamera;
	local v23 = l__CurrentCamera__22.CFrame;
	local l__Focus__24 = l__CurrentCamera__22.Focus;
	local v25 = l__CurrentCamera__22 and l__CurrentCamera__22.CameraSubject;
	local v26 = v25 and v25:IsA("VehicleSeat");
	local v27 = v25 and v25:IsA("SkateboardPlatform");
	if p34.lastUpdate == nil or v20 > 1 then
		p34.lastCameraTransform = nil;
	end;
	if p34.lastUpdate and not u4 then
		local v28 = p34:UpdateGamepad();
		if p34:ShouldUseVRRotation() then
			p34.rotateInput = p34.rotateInput + p34:GetVRRotationInput();
		else
			local v29 = math.min(0.1, v20);
			if v28 ~= v5 then
				v21 = true;
				p34.rotateInput = p34.rotateInput + v28 * v29;
			end;
			local v30 = 0;
			if not v26 and not v27 then
				if p34.TurningLeft then
					local v31 = -120;
				else
					v31 = 0;
				end;
				if p34.TurningRight then
					local v32 = 120;
				else
					v32 = 0;
				end;
				v30 = v30 + v31 + v32;
			end;
			if v30 ~= 0 then
				p34.rotateInput = p34.rotateInput + Vector2.new(math.rad(v30 * v29), 0);
				v21 = true;
			end;
		end;
	end;
	if v21 then
		p34.lastUserPanCamera = tick();
	end;
	local v33 = p34:GetSubjectPosition();
	if v33 and l__Players__2.LocalPlayer and l__CurrentCamera__22 then
		if p34.gamepadDollySpeedMultiplier ~= 1 then
			p34:SetCameraToSubjectDistance(p34.currentSubjectDistance * p34.gamepadDollySpeedMultiplier);
		end;
		local l__VREnabled__34 = l__VRService__6.VREnabled;
		local v35 = l__VREnabled__34 and p34:GetVRFocus(v33, v20) or CFrame.new(v33);
		if u4 then
			local v36 = u5.getRotation();
		else
			v36 = p34.rotateInput;
		end;
		if l__VREnabled__34 and not p34:IsInFirstPerson() then
			local v37 = p34:GetCameraHeight();
			local v38 = v33 - l__CurrentCamera__22.CFrame.p;
			local l__magnitude__39 = v38.magnitude;
			if p34.currentSubjectDistance < l__magnitude__39 or v36.x ~= 0 then
				local v40 = p34:CalculateNewLookVector(v38.unit * v4, Vector2.new(v36.x, 0)) * math.min(l__magnitude__39, p34.currentSubjectDistance);
				local v41 = v35.p - v40;
				local v42 = l__CurrentCamera__22.CFrame.lookVector;
				if v36.x ~= 0 then
					v42 = v40;
				end;
				if not u4 then
					p34.rotateInput = v5;
				end;
				v23 = CFrame.new(v41, (Vector3.new(v41.x + v42.x, v41.y, v41.z + v42.z))) + Vector3.new(0, v37, 0);
			end;
		else
			p34.curAzimuthRad = p34.curAzimuthRad - v36.x;
			if p34.useAzimuthLimits then
				p34.curAzimuthRad = math.clamp(p34.curAzimuthRad, p34.minAzimuthAbsoluteRad, p34.maxAzimuthAbsoluteRad);
			else
				p34.curAzimuthRad = p34.curAzimuthRad ~= 0 and math.sign(p34.curAzimuthRad) * (math.abs(p34.curAzimuthRad) % u7) or 0;
			end;
			p34.curElevationRad = math.clamp(p34.curElevationRad + v36.y, p34.minElevationRad, p34.maxElevationRad);
			v23 = CFrame.new(v33 + p34.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-p34.curElevationRad, p34.curAzimuthRad, 0) * v3), v33);
			if not u4 then
				p34.rotateInput = v5;
			end;
		end;
		p34.lastCameraTransform = v23;
		p34.lastCameraFocus = l__Focus__24;
		if (v26 or v27) and v25:IsA("BasePart") then
			p34.lastSubjectCFrame = v25.CFrame;
		else
			p34.lastSubjectCFrame = nil;
		end;
	end;
	p34.lastUpdate = v19;
	return v23, l__Focus__24;
end;
return v8;
