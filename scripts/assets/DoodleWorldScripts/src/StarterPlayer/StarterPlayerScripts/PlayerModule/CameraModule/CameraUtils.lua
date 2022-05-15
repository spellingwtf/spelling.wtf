-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2, v3 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserCameraToggle");
end);
local v4 = {};
v4.__index = v4;
function v4.new(p1, p2)
	return setmetatable({
		freq = p1, 
		goal = p2, 
		pos = p2, 
		vel = 0
	}, v4);
end;
function v4.step(p3, p4)
	local v5 = p3.freq * 2 * math.pi;
	local l__goal__6 = p3.goal;
	local l__vel__7 = p3.vel;
	local v8 = p3.pos - l__goal__6;
	local v9 = math.exp(-v5 * p4);
	local v10 = (v8 * (1 + v5 * p4) + l__vel__7 * p4) * v9 + l__goal__6;
	p3.pos = v10;
	p3.vel = (l__vel__7 * (1 - v5 * p4) - v8 * (v5 * v5 * p4)) * v9;
	return v10;
end;
v1.Spring = v4;
function v1.map(p5, p6, p7, p8, p9)
	return (p5 - p6) * (p9 - p8) / (p7 - p6) + p8;
end;
function v1.Round(p10, p11)
	local v11 = 10 ^ p11;
	return math.floor(p10 * v11 + 0.5) / v11;
end;
function v1.IsFinite(p12)
	local v12 = false;
	if p12 == p12 then
		v12 = false;
		if p12 ~= math.huge then
			v12 = p12 ~= -math.huge;
		end;
	end;
	return v12;
end;
function v1.IsFiniteVector3(p13)
	return v1.IsFinite(p13.X) and (v1.IsFinite(p13.Y) and v1.IsFinite(p13.Z));
end;
function v1.GetAngleBetweenXZVectors(p14, p15)
	return math.atan2(p15.X * p14.Z - p15.Z * p14.X, p15.X * p14.X + p15.Z * p14.Z);
end;
local function u1(p16)
	return math.floor(p16 + 0.5);
end;
function v1.RotateVectorByAngleAndRound(p17, p18, p19)
	if not (p17.Magnitude > 0) then
		return 0;
	end;
	p17 = p17.unit;
	return u1((math.atan2(p17.z, p17.x) + p18) / p19) * p19 - math.atan2(p17.z, p17.x);
end;
local function u2(p20)
	return p20 / 2 + 0.5;
end;
local function u3(p21)
	p21 = math.clamp(p21, -1, 1);
	if p21 >= 0 then
		return 0.35 * p21 / (0.35 - p21 + 1);
	end;
	return -(0.8 * -p21 / (0.8 + p21 + 1));
end;
local function u4(p22)
	return 1.1 * (2 * math.abs(p22) - 1) - 0.1;
end;
function v1.GamepadLinearToCurve(p23)
	local function v13(p24)
		local v14 = 1;
		if p24 < 0 then
			v14 = -1;
		end;
		return math.clamp(u2(u3(u4(math.abs(p24)))) * v14, -1, 1);
	end;
	return Vector2.new(v13(p23.x), v13(p23.y));
end;
local u5 = v2 or v3;
function v1.ConvertCameraModeEnumToStandard(p25)
	if p25 == Enum.TouchCameraMovementMode.Default then
		return Enum.ComputerCameraMovementMode.Follow;
	end;
	if p25 == Enum.ComputerCameraMovementMode.Default then
		return Enum.ComputerCameraMovementMode.Classic;
	end;
	if p25 ~= Enum.TouchCameraMovementMode.Classic and p25 ~= Enum.DevTouchCameraMovementMode.Classic and p25 ~= Enum.DevComputerCameraMovementMode.Classic and p25 ~= Enum.ComputerCameraMovementMode.Classic then
		if p25 == Enum.TouchCameraMovementMode.Follow or p25 == Enum.DevTouchCameraMovementMode.Follow or p25 == Enum.DevComputerCameraMovementMode.Follow or p25 == Enum.ComputerCameraMovementMode.Follow then
			return Enum.ComputerCameraMovementMode.Follow;
		elseif p25 == Enum.TouchCameraMovementMode.Orbital or p25 == Enum.DevTouchCameraMovementMode.Orbital or p25 == Enum.DevComputerCameraMovementMode.Orbital or p25 == Enum.ComputerCameraMovementMode.Orbital then
			return Enum.ComputerCameraMovementMode.Orbital;
		elseif u5 and (p25 == Enum.ComputerCameraMovementMode.CameraToggle or p25 == Enum.DevComputerCameraMovementMode.CameraToggle) then
			return Enum.ComputerCameraMovementMode.CameraToggle;
		elseif p25 == Enum.DevTouchCameraMovementMode.UserChoice or p25 == Enum.DevComputerCameraMovementMode.UserChoice then
			return Enum.DevComputerCameraMovementMode.UserChoice;
		else
			return Enum.ComputerCameraMovementMode.Classic;
		end;
	end;
	return Enum.ComputerCameraMovementMode.Classic;
end;
return v1;
