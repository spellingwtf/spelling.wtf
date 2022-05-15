-- Decompiled with the Synapse X Luau decompiler.

local v1 = Vector2.new(0, 0);
local v2 = math.rad(220);
local v3 = math.rad(0);
local v4 = math.rad(250);
local v5 = CFrame.fromOrientation(math.rad(-15), 0, 0);
local v6, v7 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserCameraToggle");
end);
local v8, v9 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserCameraInputRefactor");
end);
local v10 = require(script.Parent:WaitForChild("BaseCamera"));
local v11 = setmetatable({}, v10);
v11.__index = v11;
local u1 = require(script.Parent:WaitForChild("CameraUtils"));
function v11.new()
	local v12 = setmetatable(v10.new(), v11);
	v12.isFollowCamera = false;
	v12.isCameraToggle = false;
	v12.lastUpdate = tick();
	v12.cameraToggleSpring = u1.Spring.new(5, 0);
	return v12;
end;
local u2 = v6 or v7;
local u3 = require(script.Parent:WaitForChild("CameraInput"));
function v11.GetCameraToggleOffset(p1, p2)
	assert(u2);
	if not p1.isCameraToggle then
		return Vector3.new();
	end;
	local l__currentSubjectDistance__13 = p1.currentSubjectDistance;
	if u3.getTogglePan() then
		p1.cameraToggleSpring.goal = math.clamp(u1.map(l__currentSubjectDistance__13, 0.5, p1.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1), 0, 1);
	else
		p1.cameraToggleSpring.goal = 0;
	end;
	return Vector3.new(0, p1.cameraToggleSpring:step(p2) * (math.clamp(u1.map(l__currentSubjectDistance__13, 0.5, 64, 0, 1), 0, 1) + 1), 0);
end;
function v11.SetCameraMovementMode(p3, p4)
	v10.SetCameraMovementMode(p3, p4);
	p3.isFollowCamera = p4 == Enum.ComputerCameraMovementMode.Follow;
	p3.isCameraToggle = p4 == Enum.ComputerCameraMovementMode.CameraToggle;
end;
local l__Players__4 = game:GetService("Players");
local u5 = v8 or v9;
local u6 = v3;
local l__VRService__7 = game:GetService("VRService");
function v11.Update(p5)
	local v14 = tick();
	local v15 = v14 - p5.lastUpdate;
	local l__CurrentCamera__16 = workspace.CurrentCamera;
	local l__CFrame__17 = l__CurrentCamera__16.CFrame;
	local l__Focus__18 = l__CurrentCamera__16.Focus;
	local v19 = nil;
	if p5.resetCameraAngle then
		local v20 = p5:GetHumanoidRootPart();
		if v20 then
			v19 = (v20.CFrame * v5).lookVector;
		else
			v19 = v5.lookVector;
		end;
		p5.resetCameraAngle = false;
	end;
	local v21 = p5:GetHumanoid();
	local l__CameraSubject__22 = l__CurrentCamera__16.CameraSubject;
	local v23 = l__CameraSubject__22 and l__CameraSubject__22:IsA("VehicleSeat");
	local v24 = l__CameraSubject__22 and l__CameraSubject__22:IsA("SkateboardPlatform");
	local v25 = v21 and v21:GetState() == Enum.HumanoidStateType.Climbing;
	if p5.lastUpdate == nil or v15 > 1 then
		p5.lastCameraTransform = nil;
	end;
	if u5 then
		local v26 = u3.getRotation();
	else
		v26 = p5.rotateInput;
	end;
	if u5 then
		local l__currentSubjectDistance__27 = p5.currentSubjectDistance;
		local v28 = u3.getZoomDelta();
		if math.abs(v28) > 0 then
			if p5.inFirstPerson and v28 < 0 then
				local v29 = 0.5;
			elseif v28 > 0 then
				v29 = l__currentSubjectDistance__27 + v28 * (1 + l__currentSubjectDistance__27 * 0.5);
			else
				v29 = (l__currentSubjectDistance__27 + v28) / (1 - v28 * 0.5);
			end;
			p5:SetCameraToSubjectDistance(v29);
		end;
	end;
	if p5.lastUpdate and not u5 then
		local v30 = p5:UpdateGamepad();
		if p5:ShouldUseVRRotation() then
			p5.rotateInput = p5.rotateInput + p5:GetVRRotationInput();
		else
			local v31 = math.min(0.1, v15);
			if v30 ~= v1 then
				p5.rotateInput = p5.rotateInput + v30 * v31;
			end;
			local v32 = 0;
			if not v23 and not v24 then
				if p5.turningLeft then
					local v33 = -120;
				else
					v33 = 0;
				end;
				if p5.turningRight then
					local v34 = 120;
				else
					v34 = 0;
				end;
				v32 = v32 + v33 + v34;
			end;
			if v32 ~= 0 then
				p5.rotateInput = p5.rotateInput + Vector2.new(math.rad(v32 * v31), 0);
			end;
		end;
	end;
	local v35 = p5:GetCameraHeight();
	if u5 then
		if u3.getRotation() ~= Vector2.new() then
			u6 = 0;
			p5.lastUserPanCamera = tick();
		end;
	elseif p5.userPanningTheCamera then
		u6 = 0;
		p5.lastUserPanCamera = tick();
	end;
	local v36 = v14 - p5.lastUserPanCamera < 2;
	local v37 = p5:GetSubjectPosition();
	if v37 and l__Players__4.LocalPlayer and l__CurrentCamera__16 then
		local v38 = p5:GetCameraToSubjectDistance();
		if v38 < 0.5 then
			v38 = 0.5;
		end;
		if p5:GetIsMouseLocked() and not p5:IsInFirstPerson() then
			if u5 then
				local v39 = p5:CalculateNewLookCFrameFromArg(v19, v26);
			else
				v39 = p5:CalculateNewLookCFrame(v19);
			end;
			local v40 = p5:GetMouseLockOffset();
			local v41 = v40.X * v39.rightVector + v40.Y * v39.upVector + v40.Z * v39.lookVector;
			if u1.IsFiniteVector3(v41) then
				v37 = v37 + v41;
			end;
		else
			if u5 then
				local v42 = u3.getRotation() ~= Vector2.new();
			else
				v42 = p5.userPanningTheCamera == true;
			end;
			if not v42 and p5.lastCameraTransform then
				local v43 = p5:IsInFirstPerson();
				if not v23 and not v24 then
					if p5.isFollowCamera and v25 and p5.lastUpdate and v21 and v21.Torso then
						if v43 then
							if p5.lastSubjectCFrame and ((v23 or v24) and l__CameraSubject__22:IsA("BasePart")) then
								local v44 = -u1.GetAngleBetweenXZVectors(p5.lastSubjectCFrame.lookVector, l__CameraSubject__22.CFrame.lookVector);
								if u1.IsFinite(v44) then
									if u5 then
										v26 = v26 + Vector2.new(v44, 0);
									else
										p5.rotateInput = p5.rotateInput + Vector2.new(v44, 0);
									end;
								end;
								u6 = 0;
							end;
						elseif not v36 then
							local v45 = v21.Torso.CFrame.lookVector;
							if v24 and not u5 then
								v45 = l__CameraSubject__22.CFrame.lookVector;
							end;
							u6 = math.clamp(u6 + v2 * v15, 0, v4);
							local v46 = math.clamp(u6 * v15, 0, 1);
							if p5:IsInFirstPerson() and (not p5.isFollowCamera or not p5.isClimbing) then
								v46 = 1;
							end;
							local v47 = u1.GetAngleBetweenXZVectors(v45, p5:GetCameraLookVector());
							if u1.IsFinite(v47) and math.abs(v47) > 0.0001 then
								if u5 then
									v26 = v26 + Vector2.new(v47 * v46, 0);
								else
									p5.rotateInput = p5.rotateInput + Vector2.new(v47 * v46, 0);
								end;
							end;
						end;
					elseif p5.isFollowCamera and not v43 and not v36 and not l__VRService__7.VREnabled then
						local v48 = u1.GetAngleBetweenXZVectors(-(p5.lastCameraTransform.p - v37), p5:GetCameraLookVector());
						if u1.IsFinite(v48) and math.abs(v48) > 0.0001 and 0.4 * v15 < math.abs(v48) then
							v26 = v26 + Vector2.new(v48, 0);
						end;
					end;
				elseif p5.lastUpdate and v21 and v21.Torso then
					if v43 then
						if p5.lastSubjectCFrame and ((v23 or v24) and l__CameraSubject__22:IsA("BasePart")) then
							v44 = -u1.GetAngleBetweenXZVectors(p5.lastSubjectCFrame.lookVector, l__CameraSubject__22.CFrame.lookVector);
							if u1.IsFinite(v44) then
								if u5 then
									v26 = v26 + Vector2.new(v44, 0);
								else
									p5.rotateInput = p5.rotateInput + Vector2.new(v44, 0);
								end;
							end;
							u6 = 0;
						end;
					elseif not v36 then
						v45 = v21.Torso.CFrame.lookVector;
						if v24 and not u5 then
							v45 = l__CameraSubject__22.CFrame.lookVector;
						end;
						u6 = math.clamp(u6 + v2 * v15, 0, v4);
						v46 = math.clamp(u6 * v15, 0, 1);
						if p5:IsInFirstPerson() and (not p5.isFollowCamera or not p5.isClimbing) then
							v46 = 1;
						end;
						v47 = u1.GetAngleBetweenXZVectors(v45, p5:GetCameraLookVector());
						if u1.IsFinite(v47) and math.abs(v47) > 0.0001 then
							if u5 then
								v26 = v26 + Vector2.new(v47 * v46, 0);
							else
								p5.rotateInput = p5.rotateInput + Vector2.new(v47 * v46, 0);
							end;
						end;
					end;
				elseif p5.isFollowCamera and not v43 and not v36 and not l__VRService__7.VREnabled then
					v48 = u1.GetAngleBetweenXZVectors(-(p5.lastCameraTransform.p - v37), p5:GetCameraLookVector());
					if u1.IsFinite(v48) and math.abs(v48) > 0.0001 and 0.4 * v15 < math.abs(v48) then
						v26 = v26 + Vector2.new(v48, 0);
					end;
				end;
			end;
		end;
		if not p5.isFollowCamera then
			local l__VREnabled__49 = l__VRService__7.VREnabled;
			if l__VREnabled__49 then
				local v50 = p5:GetVRFocus(v37, v15);
			else
				v50 = CFrame.new(v37);
			end;
			local l__p__51 = local v52.p;
			if l__VREnabled__49 and not p5:IsInFirstPerson() then
				local l__magnitude__53 = (v37 - l__CurrentCamera__16.CFrame.p).magnitude;
				if u5 then
					local v54 = v26;
				else
					v54 = p5.rotateInput;
				end;
				if v38 < l__magnitude__53 or v54.x ~= 0 then
					local v55 = nil;
					v55 = math.min(l__magnitude__53, v38);
					if u5 then
						local v56 = p5:CalculateNewLookFromArg(nil, v26) * v55;
					else
						v56 = p5:CalculateNewLook() * v55;
					end;
					local v57 = l__p__51 - v56;
					local v58 = l__CurrentCamera__16.CFrame.lookVector;
					if v54.x ~= 0 then
						v58 = v56;
					end;
					if not u5 then
						p5.rotateInput = v1;
					end;
					local v59 = CFrame.new(v57, (Vector3.new(v57.x + v58.x, v57.y, v57.z + v58.z))) + Vector3.new(0, v35, 0);
				end;
			else
				if u5 then
					local v60 = p5:CalculateNewLookVectorFromArg(v19, v26);
				else
					v60 = p5:CalculateNewLookVector(v19);
					p5.rotateInput = v1;
				end;
				v59 = CFrame.new(l__p__51 - v38 * v60, l__p__51);
			end;
		else
			if u5 then
				local v61 = p5:CalculateNewLookVectorFromArg(v19, v26);
			else
				v61 = p5:CalculateNewLookVector(v19);
				p5.rotateInput = v1;
			end;
			if l__VRService__7.VREnabled then
				v52 = p5:GetVRFocus(v37, v15);
			else
				v52 = CFrame.new(v37);
			end;
			v59 = CFrame.new(v52.p - v38 * v61, v52.p) + Vector3.new(0, v35, 0);
		end;
		if u2 then
			local v62 = p5:GetCameraToggleOffset(v15);
			v52 = v52 + v62;
			v59 = v59 + v62;
		end;
		p5.lastCameraTransform = l__CFrame__17;
		p5.lastCameraFocus = l__Focus__18;
		if (v23 or v24) and l__CameraSubject__22:IsA("BasePart") then
			p5.lastSubjectCFrame = l__CameraSubject__22.CFrame;
		else
			p5.lastSubjectCFrame = nil;
		end;
	end;
	if u5 then
		u3.resetInputForFrameEnd();
	end;
	p5.lastUpdate = v14;
	return l__CFrame__17, l__Focus__18;
end;
function v11.EnterFirstPerson(p6)
	p6.inFirstPerson = true;
	p6:UpdateMouseBehavior();
end;
function v11.LeaveFirstPerson(p7)
	p7.inFirstPerson = false;
	p7:UpdateMouseBehavior();
end;
return v11;
