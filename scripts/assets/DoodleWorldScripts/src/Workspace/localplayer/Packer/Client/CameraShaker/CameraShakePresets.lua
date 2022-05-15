-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local u1 = require(script.Parent.CameraShakeInstance);
function v1.Bump()
	local v2 = u1.new(2.5, 4, 0.1, 0.75);
	v2.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
	v2.RotationInfluence = Vector3.new(1, 1, 1);
	return v2;
end;
function v1.Explosion()
	local v3 = u1.new(5, 10, 0, 1.5);
	v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
	v3.RotationInfluence = Vector3.new(4, 1, 1);
	return v3;
end;
function v1.Earthquake()
	local v4 = u1.new(0.6, 3.5, 2, 10);
	v4.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
	v4.RotationInfluence = Vector3.new(1, 1, 4);
	return v4;
end;
function v1.BadTrip()
	local v5 = u1.new(10, 0.15, 5, 10);
	v5.PositionInfluence = Vector3.new(0, 0, 0.15);
	v5.RotationInfluence = Vector3.new(2, 1, 4);
	return v5;
end;
function v1.HandheldCamera()
	local v6 = u1.new(1, 0.25, 5, 10);
	v6.PositionInfluence = Vector3.new(0, 0, 0);
	v6.RotationInfluence = Vector3.new(1, 0.5, 0.5);
	return v6;
end;
function v1.Vibration()
	local v7 = u1.new(0.4, 20, 2, 2);
	v7.PositionInfluence = Vector3.new(0, 0.15, 0);
	v7.RotationInfluence = Vector3.new(1.25, 0, 4);
	return v7;
end;
function v1.RoughDriving()
	local v8 = u1.new(1, 2, 1, 1);
	v8.PositionInfluence = Vector3.new(0, 0, 0);
	v8.RotationInfluence = Vector3.new(1, 1, 1);
	return v8;
end;
local v9 = {};
function v9.__index(p1, p2)
	local v10 = v1[p2];
	if type(v10) == "function" then
		return v10();
	end;
	error("No preset found with index \"" .. p2 .. "\"");
end;
return setmetatable({}, v9);
