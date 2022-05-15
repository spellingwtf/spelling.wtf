-- Decompiled with the Synapse X Luau decompiler.

local v1, v2 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserCameraInputRefactor");
end);
local v3 = require(script.Parent:WaitForChild("BaseCamera"));
local v4 = setmetatable({}, v3);
v4.__index = v4;
function v4.new()
	local v5 = setmetatable(v3.new(), v4);
	v5.cameraType = Enum.CameraType.Fixed;
	v5.lastUpdate = tick();
	v5.lastDistanceToSubject = nil;
	return v5;
end;
function v4.GetModuleName(p1)
	return "LegacyCamera";
end;
function v4.SetCameraToSubjectDistance(p2, p3)
	return v3.SetCameraToSubjectDistance(p2, p3);
end;
local l__Players__1 = game:GetService("Players");
local u2 = v1 or v2;
local u3 = require(script.Parent:WaitForChild("CameraInput"));
local u4 = Vector2.new(0, 0);
local u5 = require(script.Parent:WaitForChild("CameraUtils"));
function v4.Update(p4, p5)
	if not p4.cameraType then
		return;
	end;
	local v6 = tick();
	local l__CurrentCamera__7 = workspace.CurrentCamera;
	local v8 = l__CurrentCamera__7.CFrame;
	local v9 = l__CurrentCamera__7.Focus;
	local l__LocalPlayer__10 = l__Players__1.LocalPlayer;
	if p4.lastUpdate == nil or v6 - p4.lastUpdate > 1 then
		p4.lastDistanceToSubject = nil;
	end;
	local v11 = p4:GetSubjectPosition();
	if p4.cameraType == Enum.CameraType.Fixed then
		if p4.lastUpdate and not u2 then
			p4.rotateInput = p4.rotateInput + p4:UpdateGamepad() * math.min(0.1, v6 - p4.lastUpdate);
		end;
		if v11 and l__LocalPlayer__10 and l__CurrentCamera__7 then
			if u2 then
				local v12 = p4:CalculateNewLookVectorFromArg(nil, u3.getRotation());
			else
				v12 = p4:CalculateNewLookVector();
				p4.rotateInput = u4;
			end;
			v9 = l__CurrentCamera__7.Focus;
			v8 = CFrame.new(l__CurrentCamera__7.CFrame.p, l__CurrentCamera__7.CFrame.p + p4:GetCameraToSubjectDistance() * v12);
		end;
	elseif p4.cameraType == Enum.CameraType.Attach then
		if v11 and l__CurrentCamera__7 then
			local v13 = p4:GetHumanoid();
			if p4.lastUpdate and v13 and v13.RootPart and not u2 then
				p4.rotateInput = p4.rotateInput + p4:UpdateGamepad() * math.min(0.1, v6 - p4.lastUpdate);
				local v14 = u5.GetAngleBetweenXZVectors(v13.RootPart.CFrame.lookVector, p4:GetCameraLookVector());
				if u5.IsFinite(v14) then
					p4.rotateInput = Vector2.new(v14, p4.rotateInput.Y);
				end;
			end;
			if u2 then
				local v15 = p4:CalculateNewLookVectorFromArg(nil, u3.getRotation());
			else
				v15 = p4:CalculateNewLookVector();
				p4.rotateInput = u4;
			end;
			v9 = CFrame.new(v11);
			v8 = CFrame.new(v11 - p4:GetCameraToSubjectDistance() * v15, v11);
		end;
	else
		if p4.cameraType ~= Enum.CameraType.Watch then
			return l__CurrentCamera__7.CFrame, l__CurrentCamera__7.Focus;
		end;
		if v11 and l__LocalPlayer__10 and l__CurrentCamera__7 then
			local v16 = nil;
			local v17 = p4.GetHumanoid(p4);
			if v17 and v17.RootPart then
				local v18 = v11 - l__CurrentCamera__7.CFrame.p;
				v16 = v18.unit;
				if p4.lastDistanceToSubject and p4.lastDistanceToSubject == p4.GetCameraToSubjectDistance(p4) then
					p4.SetCameraToSubjectDistance(p4, v18.magnitude);
				end;
			end;
			local v19 = p4.GetCameraToSubjectDistance(p4);
			if u2 then
				local v20 = p4.CalculateNewLookVectorFromArg(p4, v16, u3.getRotation());
			else
				v20 = p4.CalculateNewLookVector(p4, v16);
				p4.rotateInput = u4;
			end;
			v9 = CFrame.new(v11);
			v8 = CFrame.new(v11 - v19 * v20, v11);
			p4.lastDistanceToSubject = v19;
		end;
	end;
	p4.lastUpdate = v6;
	return v8, v9;
end;
return v4;
