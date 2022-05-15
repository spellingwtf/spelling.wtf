-- Decompiled with the Synapse X Luau decompiler.

local v1 = Vector3.new(0, 0, 1);
local v2 = Vector3.new(1, 0, 1);
local v3 = math.rad(-80);
local v4 = math.rad(80);
local v5 = math.rad(30);
local v6 = math.rad(-15);
local v7 = math.rad(15);
local v8 = Vector2.new(math.rad(15), 0);
local v9 = Vector2.new(math.rad(45), 0);
local v10 = Vector2.new(0, 0);
local v11 = Vector3.new(0, 0, 0);
local v12 = Vector2.new(0.00945 * math.pi, 0.003375 * math.pi);
local v13 = Vector2.new(0.002 * math.pi, 0.0015 * math.pi);
local v14 = Vector3.new(0, 5, 0);
local v15 = Vector3.new(0, 4, 0);
local v16 = Vector3.new(0, 1.5, 0);
local v17 = Vector3.new(0, 1.5, 0);
local v18 = Vector3.new(0, 2, 0);
local v19 = Vector3.new(2, 2, 1);
local v20, v21 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserCameraToggle");
end);
local v22, v23 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserFixZoomInZoomOutDiscrepancy");
end);
local v24, v25 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserFixGamepadCameraTracking");
end);
local v26, v27 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserCameraInputRefactor");
end);
local v28 = {};
v28.__index = v28;
local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__UserGameSettings__2 = UserSettings():GetService("UserGameSettings");
function v28.new()
	local v29 = setmetatable({}, v28);
	v29.FIRST_PERSON_DISTANCE_THRESHOLD = 1;
	v29.cameraType = nil;
	v29.cameraMovementMode = nil;
	v29.lastCameraTransform = nil;
	v29.rotateInput = v10;
	v29.userPanningCamera = false;
	v29.lastUserPanCamera = tick();
	v29.humanoidRootPart = nil;
	v29.humanoidCache = {};
	v29.lastSubject = nil;
	v29.lastSubjectPosition = Vector3.new(0, 5, 0);
	v29.defaultSubjectDistance = math.clamp(12.5, l__LocalPlayer__1.CameraMinZoomDistance, l__LocalPlayer__1.CameraMaxZoomDistance);
	v29.currentSubjectDistance = math.clamp(12.5, l__LocalPlayer__1.CameraMinZoomDistance, l__LocalPlayer__1.CameraMaxZoomDistance);
	v29.inFirstPerson = false;
	v29.inMouseLockedMode = false;
	v29.portraitMode = false;
	v29.isSmallTouchScreen = false;
	v29.resetCameraAngle = true;
	v29.enabled = false;
	v29.inputBeganConn = nil;
	v29.inputChangedConn = nil;
	v29.inputEndedConn = nil;
	v29.startPos = nil;
	v29.lastPos = nil;
	v29.panBeginLook = nil;
	v29.panEnabled = true;
	v29.keyPanEnabled = true;
	v29.distanceChangeEnabled = true;
	v29.PlayerGui = nil;
	v29.cameraChangedConn = nil;
	v29.viewportSizeChangedConn = nil;
	v29.boundContextActions = {};
	v29.shouldUseVRRotation = false;
	v29.VRRotationIntensityAvailable = false;
	v29.lastVRRotationIntensityCheckTime = 0;
	v29.lastVRRotationTime = 0;
	v29.vrRotateKeyCooldown = {};
	v29.cameraTranslationConstraints = Vector3.new(1, 1, 1);
	v29.humanoidJumpOrigin = nil;
	v29.trackingHumanoid = nil;
	v29.cameraFrozen = false;
	v29.subjectStateChangedConn = nil;
	v29.gamepadZoomPressConnection = nil;
	v29.activeGamepad = nil;
	v29.gamepadPanningCamera = false;
	v29.lastThumbstickRotate = nil;
	v29.numOfSeconds = 0.7;
	v29.currentSpeed = 0;
	v29.maxSpeed = 6;
	v29.vrMaxSpeed = 4;
	v29.lastThumbstickPos = Vector2.new(0, 0);
	v29.ySensitivity = 0.65;
	v29.lastVelocity = nil;
	v29.gamepadConnectedConn = nil;
	v29.gamepadDisconnectedConn = nil;
	v29.currentZoomSpeed = 1;
	v29.L3ButtonDown = false;
	v29.dpadLeftDown = false;
	v29.dpadRightDown = false;
	v29.isDynamicThumbstickEnabled = false;
	v29.fingerTouches = {};
	v29.dynamicTouchInput = nil;
	v29.numUnsunkTouches = 0;
	v29.inputStartPositions = {};
	v29.inputStartTimes = {};
	v29.startingDiff = nil;
	v29.pinchBeginZoom = nil;
	v29.userPanningTheCamera = false;
	v29.touchActivateConn = nil;
	v29.mouseLockOffset = v11;
	if l__LocalPlayer__1.Character then
		v29:OnCharacterAdded(l__LocalPlayer__1.Character);
	end;
	l__LocalPlayer__1.CharacterAdded:Connect(function(p1)
		v29:OnCharacterAdded(p1);
	end);
	if v29.cameraChangedConn then
		v29.cameraChangedConn:Disconnect();
	end;
	v29.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		v29:OnCurrentCameraChanged();
	end);
	v29:OnCurrentCameraChanged();
	if v29.playerCameraModeChangeConn then
		v29.playerCameraModeChangeConn:Disconnect();
	end;
	v29.playerCameraModeChangeConn = l__LocalPlayer__1:GetPropertyChangedSignal("CameraMode"):Connect(function()
		v29:OnPlayerCameraPropertyChange();
	end);
	if v29.minDistanceChangeConn then
		v29.minDistanceChangeConn:Disconnect();
	end;
	v29.minDistanceChangeConn = l__LocalPlayer__1:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function()
		v29:OnPlayerCameraPropertyChange();
	end);
	if v29.maxDistanceChangeConn then
		v29.maxDistanceChangeConn:Disconnect();
	end;
	v29.maxDistanceChangeConn = l__LocalPlayer__1:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()
		v29:OnPlayerCameraPropertyChange();
	end);
	if v29.playerDevTouchMoveModeChangeConn then
		v29.playerDevTouchMoveModeChangeConn:Disconnect();
	end;
	v29.playerDevTouchMoveModeChangeConn = l__LocalPlayer__1:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function()
		v29:OnDevTouchMovementModeChanged();
	end);
	v29:OnDevTouchMovementModeChanged();
	if v29.gameSettingsTouchMoveMoveChangeConn then
		v29.gameSettingsTouchMoveMoveChangeConn:Disconnect();
	end;
	v29.gameSettingsTouchMoveMoveChangeConn = l__UserGameSettings__2:GetPropertyChangedSignal("TouchMovementMode"):Connect(function()
		v29:OnGameSettingsTouchMovementModeChanged();
	end);
	v29:OnGameSettingsTouchMovementModeChanged();
	l__UserGameSettings__2:SetCameraYInvertVisible();
	l__UserGameSettings__2:SetGamepadCameraSensitivityVisible();
	v29.hasGameLoaded = game:IsLoaded();
	if not v29.hasGameLoaded then
		v29.gameLoadedConn = game.Loaded:Connect(function()
			v29.hasGameLoaded = true;
			v29.gameLoadedConn:Disconnect();
			v29.gameLoadedConn = nil;
		end);
	end;
	v29:OnPlayerCameraPropertyChange();
	return v29;
end;
function v28.GetModuleName(p2)
	return "BaseCamera";
end;
local l__UserInputService__3 = game:GetService("UserInputService");
function v28.OnCharacterAdded(p3, p4)
	p3.resetCameraAngle = p3.resetCameraAngle or p3:GetEnabled();
	p3.humanoidRootPart = nil;
	if l__UserInputService__3.TouchEnabled then
		p3.PlayerGui = l__LocalPlayer__1:WaitForChild("PlayerGui");
		for v30, v31 in ipairs(p4:GetChildren()) do
			if v31:IsA("Tool") then
				p3.isAToolEquipped = true;
			end;
		end;
		p4.ChildAdded:Connect(function(p5)
			if p5:IsA("Tool") then
				p3.isAToolEquipped = true;
			end;
		end);
		p4.ChildRemoved:Connect(function(p6)
			if p6:IsA("Tool") then
				p3.isAToolEquipped = false;
			end;
		end);
	end;
end;
function v28.GetHumanoidRootPart(p7)
	if not p7.humanoidRootPart and l__LocalPlayer__1.Character then
		local v32 = l__LocalPlayer__1.Character:FindFirstChildOfClass("Humanoid");
		if v32 then
			p7.humanoidRootPart = v32.RootPart;
		end;
	end;
	return p7.humanoidRootPart;
end;
function v28.GetBodyPartToFollow(p8, p9, p10)
	local v33 = nil;
	if p9:GetState() == Enum.HumanoidStateType.Dead then
		v33 = p9.Parent;
		if not v33 or not v33:IsA("Model") then
			return p9.RootPart;
		end;
	else
		return p9.RootPart;
	end;
	return v33:FindFirstChild("Head") or p9.RootPart;
end;
local l__VRService__4 = game:GetService("VRService");
function v28.GetSubjectPosition(p11)
	local v34 = p11.lastSubjectPosition;
	local l__CurrentCamera__35 = game.Workspace.CurrentCamera;
	local v36 = l__CurrentCamera__35 and l__CurrentCamera__35.CameraSubject;
	if not v36 then
		return;
	end;
	if v36:IsA("Humanoid") then
		local v37 = v36:GetState() == Enum.HumanoidStateType.Dead;
		if l__VRService__4.VREnabled and v37 and v36 == p11.lastSubject then
			v34 = p11.lastSubjectPosition;
		else
			local v38 = v36.RootPart;
			if v37 and v36.Parent and v36.Parent:IsA("Model") then
				v38 = v36.Parent:FindFirstChild("Head") and v38;
			end;
			if v38 and v38:IsA("BasePart") then
				if v36.RigType == Enum.HumanoidRigType.R15 then
					if v36.AutomaticScalingEnabled then
						local v39 = v17;
						if v38 == v36.RootPart then
							v39 = v39 + Vector3.new(0, v36.RootPart.Size.Y / 2 - v19.Y / 2, 0);
						end;
					else
						v39 = v18;
					end;
				else
					v39 = v16;
				end;
				if v37 then
					v39 = v11;
				end;
				v34 = v38.CFrame.p + v38.CFrame:vectorToWorldSpace(v39 + v36.CameraOffset);
			end;
		end;
	elseif v36:IsA("VehicleSeat") then
		local v40 = v14;
		if l__VRService__4.VREnabled then
			v40 = v15;
		end;
		v34 = v36.CFrame.p + v36.CFrame:vectorToWorldSpace(v40);
	elseif v36:IsA("SkateboardPlatform") then
		v34 = v36.CFrame.p + v14;
	elseif v36:IsA("BasePart") then
		v34 = v36.CFrame.p;
	elseif v36:IsA("Model") then
		if v36.PrimaryPart then
			v34 = v36:GetPrimaryPartCFrame().p;
		else
			v34 = v36:GetModelCFrame().p;
		end;
	end;
	p11.lastSubject = v36;
	p11.lastSubjectPosition = v34;
	return v34;
end;
function v28.UpdateDefaultSubjectDistance(p12)
	if p12.portraitMode then
		p12.defaultSubjectDistance = math.clamp(25, l__LocalPlayer__1.CameraMinZoomDistance, l__LocalPlayer__1.CameraMaxZoomDistance);
		return;
	end;
	p12.defaultSubjectDistance = math.clamp(12.5, l__LocalPlayer__1.CameraMinZoomDistance, l__LocalPlayer__1.CameraMaxZoomDistance);
end;
function v28.OnViewportSizeChanged(p13)
	local l__ViewportSize__41 = game.Workspace.CurrentCamera.ViewportSize;
	p13.portraitMode = l__ViewportSize__41.X < l__ViewportSize__41.Y;
	local v42 = l__UserInputService__3.TouchEnabled;
	if v42 then
		v42 = true;
		if not (l__ViewportSize__41.Y < 500) then
			v42 = l__ViewportSize__41.X < 700;
		end;
	end;
	p13.isSmallTouchScreen = v42;
	p13:UpdateDefaultSubjectDistance();
end;
function v28.OnCurrentCameraChanged(p14)
	if l__UserInputService__3.TouchEnabled then
		if p14.viewportSizeChangedConn then
			p14.viewportSizeChangedConn:Disconnect();
			p14.viewportSizeChangedConn = nil;
		end;
		local l__CurrentCamera__43 = game.Workspace.CurrentCamera;
		if l__CurrentCamera__43 then
			p14:OnViewportSizeChanged();
			p14.viewportSizeChangedConn = l__CurrentCamera__43:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				p14:OnViewportSizeChanged();
			end);
		end;
	end;
	if p14.cameraSubjectChangedConn then
		p14.cameraSubjectChangedConn:Disconnect();
		p14.cameraSubjectChangedConn = nil;
	end;
	local l__CurrentCamera__44 = game.Workspace.CurrentCamera;
	if l__CurrentCamera__44 then
		p14.cameraSubjectChangedConn = l__CurrentCamera__44:GetPropertyChangedSignal("CameraSubject"):Connect(function()
			p14:OnNewCameraSubject();
		end);
		p14:OnNewCameraSubject();
	end;
end;
function v28.OnDynamicThumbstickEnabled(p15)
	if l__UserInputService__3.TouchEnabled then
		p15.isDynamicThumbstickEnabled = true;
	end;
end;
function v28.OnDynamicThumbstickDisabled(p16)
	p16.isDynamicThumbstickEnabled = false;
end;
function v28.OnGameSettingsTouchMovementModeChanged(p17)
	if l__LocalPlayer__1.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
		if l__UserGameSettings__2.TouchMovementMode ~= Enum.TouchMovementMode.DynamicThumbstick and l__UserGameSettings__2.TouchMovementMode ~= Enum.TouchMovementMode.Default then
			p17:OnDynamicThumbstickDisabled();
			return;
		end;
	else
		return;
	end;
	p17:OnDynamicThumbstickEnabled();
end;
function v28.OnDevTouchMovementModeChanged(p18)
	if l__LocalPlayer__1.DevTouchMovementMode == Enum.DevTouchMovementMode.DynamicThumbstick then
		p18:OnDynamicThumbstickEnabled();
		return;
	end;
	p18:OnGameSettingsTouchMovementModeChanged();
end;
function v28.OnPlayerCameraPropertyChange(p19)
	p19:SetCameraToSubjectDistance(p19.currentSubjectDistance);
end;
function v28.GetCameraHeight(p20)
	if not l__VRService__4.VREnabled or not (not p20.inFirstPerson) then
		return 0;
	end;
	return math.sin(v7) * p20.currentSubjectDistance;
end;
function v28.InputTranslationToCameraAngleChange(p21, p22, p23)
	return p22 * p23;
end;
function v28.GamepadZoomPress(p24)
	local v45 = p24:GetCameraToSubjectDistance();
	if v45 > 15 then
		p24:SetCameraToSubjectDistance(10);
		return;
	end;
	if v45 > 5 then
		p24:SetCameraToSubjectDistance(0);
		return;
	end;
	p24:SetCameraToSubjectDistance(20);
end;
local u5 = v26 or v27;
local u6 = require(script.Parent:WaitForChild("CameraInput"));
function v28.Enable(p25, p26)
	if p25.enabled ~= p26 then
		p25.enabled = p26;
		if p25.enabled then
			if u5 then
				u6.setInputEnabled(true);
				p25.gamepadZoomPressConnection = u6.gamepadZoomPress:Connect(function()
					p25:GamepadZoomPress();
				end);
			else
				p25:ConnectInputEvents();
				p25:BindContextActions();
			end;
			if l__LocalPlayer__1.CameraMode == Enum.CameraMode.LockFirstPerson then
				p25.currentSubjectDistance = 0.5;
				if not p25.inFirstPerson then
					p25:EnterFirstPerson();
					return;
				end;
			end;
		else
			if u5 then
				u6.setInputEnabled(false);
				if p25.gamepadZoomPressConnection then
					p25.gamepadZoomPressConnection:Disconnect();
					p25.gamepadZoomPressConnection = nil;
				end;
			else
				p25:DisconnectInputEvents();
				p25:UnbindContextActions();
			end;
			p25:Cleanup();
		end;
	end;
end;
function v28.GetEnabled(p27)
	return p27.enabled;
end;
function v28.OnInputBegan(p28, p29, p30)
	if p29.UserInputType == Enum.UserInputType.Touch then
		p28:OnTouchBegan(p29, p30);
		return;
	end;
	if p29.UserInputType == Enum.UserInputType.MouseButton2 then
		p28:OnMouse2Down(p29, p30);
		return;
	end;
	if p29.UserInputType == Enum.UserInputType.MouseButton3 then
		p28:OnMouse3Down(p29, p30);
	end;
end;
function v28.OnInputChanged(p31, p32, p33)
	if p32.UserInputType == Enum.UserInputType.Touch then
		p31:OnTouchChanged(p32, p33);
		return;
	end;
	if p32.UserInputType == Enum.UserInputType.MouseMovement then
		p31:OnMouseMoved(p32, p33);
	end;
end;
function v28.OnInputEnded(p34, p35, p36)
	if p35.UserInputType == Enum.UserInputType.Touch then
		p34:OnTouchEnded(p35, p36);
		return;
	end;
	if p35.UserInputType == Enum.UserInputType.MouseButton2 then
		p34:OnMouse2Up(p35, p36);
		return;
	end;
	if p35.UserInputType == Enum.UserInputType.MouseButton3 then
		p34:OnMouse3Up(p35, p36);
	end;
end;
local l__math_abs__7 = math.abs;
local u8 = v22 or v23;
function v28.OnPointerAction(p37, p38, p39, p40, p41)
	assert(not u5);
	if p41 then
		return;
	end;
	if p39.Magnitude > 0 then
		p37.rotateInput = p37.rotateInput + p37:InputTranslationToCameraAngleChange(20 * p39, v13) * Vector2.new(1, l__UserGameSettings__2:GetCameraYInvertValue());
	end;
	local l__currentSubjectDistance__46 = p37.currentSubjectDistance;
	local v47 = -(p38 + p40);
	if l__math_abs__7(v47) > 0 then
		if p37.inFirstPerson and v47 > 0 then
			local v48 = 1;
		elseif u8 then
			if v47 > 0 then
				v48 = l__currentSubjectDistance__46 + v47 * (1 + l__currentSubjectDistance__46 * 0.5);
			else
				v48 = (l__currentSubjectDistance__46 + v47) / (1 - v47 * 0.5);
			end;
		else
			v48 = l__currentSubjectDistance__46 + v47 * (1 + l__currentSubjectDistance__46 * 0.5);
		end;
		p37:SetCameraToSubjectDistance(v48);
	end;
end;
local l__GuiService__9 = game:GetService("GuiService");
local u10 = v20 or v21;
function v28.ConnectInputEvents(p42)
	assert(not u5);
	p42.pointerActionConn = l__UserInputService__3.PointerAction:Connect(function(p43, p44, p45, p46)
		p42:OnPointerAction(p43, p44, p45, p46);
	end);
	p42.inputBeganConn = l__UserInputService__3.InputBegan:Connect(function(p47, p48)
		p42:OnInputBegan(p47, p48);
	end);
	p42.inputChangedConn = l__UserInputService__3.InputChanged:Connect(function(p49, p50)
		p42:OnInputChanged(p49, p50);
	end);
	p42.inputEndedConn = l__UserInputService__3.InputEnded:Connect(function(p51, p52)
		p42:OnInputEnded(p51, p52);
	end);
	p42.menuOpenedConn = l__GuiService__9.MenuOpened:connect(function()
		p42:ResetInputStates();
	end);
	p42.gamepadConnectedConn = l__UserInputService__3.GamepadDisconnected:connect(function(p53)
		if p42.activeGamepad ~= p53 then
			return;
		end;
		p42.activeGamepad = nil;
		p42:AssignActivateGamepad();
	end);
	p42.gamepadDisconnectedConn = l__UserInputService__3.GamepadConnected:connect(function(p54)
		if p42.activeGamepad == nil then
			p42:AssignActivateGamepad();
		end;
	end);
	p42:AssignActivateGamepad();
	if not u10 then
		p42:UpdateMouseBehavior();
	end;
end;
function v28.BindContextActions(p55)
	assert(not u5);
	p55:BindGamepadInputActions();
	p55:BindKeyboardInputActions();
end;
function v28.AssignActivateGamepad(p56)
	assert(not u5);
	local v49 = l__UserInputService__3:GetConnectedGamepads();
	if #v49 > 0 then
		for v50 = 1, #v49 do
			if p56.activeGamepad == nil then
				p56.activeGamepad = v49[v50];
			elseif v49[v50].Value < p56.activeGamepad.Value then
				p56.activeGamepad = v49[v50];
			end;
		end;
	end;
	if p56.activeGamepad == nil then
		p56.activeGamepad = Enum.UserInputType.Gamepad1;
	end;
end;
function v28.DisconnectInputEvents(p57)
	assert(not u5);
	if p57.inputBeganConn then
		p57.inputBeganConn:Disconnect();
		p57.inputBeganConn = nil;
	end;
	if p57.inputChangedConn then
		p57.inputChangedConn:Disconnect();
		p57.inputChangedConn = nil;
	end;
	if p57.inputEndedConn then
		p57.inputEndedConn:Disconnect();
		p57.inputEndedConn = nil;
	end;
end;
local l__ContextActionService__11 = game:GetService("ContextActionService");
function v28.UnbindContextActions(p58)
	assert(not u5);
	for v51 = 1, #p58.boundContextActions do
		l__ContextActionService__11:UnbindAction(p58.boundContextActions[v51]);
	end;
	p58.boundContextActions = {};
end;
local u12 = v24 or v25;
function v28.Cleanup(p59)
	if p59.pointerActionConn then
		p59.pointerActionConn:Disconnect();
		p59.pointerActionConn = nil;
	end;
	if p59.menuOpenedConn then
		p59.menuOpenedConn:Disconnect();
		p59.menuOpenedConn = nil;
	end;
	if p59.mouseLockToggleConn then
		p59.mouseLockToggleConn:Disconnect();
		p59.mouseLockToggleConn = nil;
	end;
	if p59.gamepadConnectedConn then
		p59.gamepadConnectedConn:Disconnect();
		p59.gamepadConnectedConn = nil;
	end;
	if p59.gamepadDisconnectedConn then
		p59.gamepadDisconnectedConn:Disconnect();
		p59.gamepadDisconnectedConn = nil;
	end;
	if p59.subjectStateChangedConn then
		p59.subjectStateChangedConn:Disconnect();
		p59.subjectStateChangedConn = nil;
	end;
	if p59.viewportSizeChangedConn then
		p59.viewportSizeChangedConn:Disconnect();
		p59.viewportSizeChangedConn = nil;
	end;
	if p59.touchActivateConn then
		p59.touchActivateConn:Disconnect();
		p59.touchActivateConn = nil;
	end;
	p59.turningLeft = false;
	p59.turningRight = false;
	p59.lastCameraTransform = nil;
	p59.lastSubjectCFrame = nil;
	p59.userPanningTheCamera = false;
	p59.rotateInput = Vector2.new();
	if u12 then
		if p59.gamepadPanningCamera then
			p59.gamepadPanningCamera = v10;
		end;
	else
		p59.gamepadPanningCamera = Vector2.new(0, 0);
	end;
	p59.startPos = nil;
	p59.lastPos = nil;
	p59.panBeginLook = nil;
	p59.isRightMouseDown = false;
	p59.isMiddleMouseDown = false;
	p59.fingerTouches = {};
	p59.dynamicTouchInput = nil;
	p59.numUnsunkTouches = 0;
	p59.startingDiff = nil;
	p59.pinchBeginZoom = nil;
	if l__UserInputService__3.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
		l__UserInputService__3.MouseBehavior = Enum.MouseBehavior.Default;
	end;
end;
function v28.ResetInputStates(p60)
	assert(not u5);
	p60.isRightMouseDown = false;
	p60.isMiddleMouseDown = false;
	p60:OnMousePanButtonReleased();
	if l__UserInputService__3.TouchEnabled then
		for v52, v53 in pairs(p60.fingerTouches) do
			p60.fingerTouches[v52] = nil;
		end;
		p60.dynamicTouchInput = nil;
		p60.panBeginLook = nil;
		p60.startPos = nil;
		p60.lastPos = nil;
		p60.userPanningTheCamera = false;
		p60.startingDiff = nil;
		p60.pinchBeginZoom = nil;
		p60.numUnsunkTouches = 0;
	end;
end;
function v28.GetGamepadPan(p61, p62, p63, p64)
	assert(not u5);
	if p64.UserInputType ~= p61.activeGamepad or p64.KeyCode ~= Enum.KeyCode.Thumbstick2 then
		return Enum.ContextActionResult.Pass;
	end;
	if p63 == Enum.UserInputState.Cancel then
		p61.gamepadPanningCamera = v10;
		return;
	end;
	if Vector2.new(p64.Position.X, -p64.Position.Y).magnitude > 0.2 then
		p61.gamepadPanningCamera = Vector2.new(p64.Position.X, -p64.Position.Y);
	else
		p61.gamepadPanningCamera = v10;
	end;
	return Enum.ContextActionResult.Sink;
end;
function v28.DoKeyboardPanTurn(p65, p66, p67, p68)
	assert(not u5);
	if not p65.hasGameLoaded and l__VRService__4.VREnabled then
		return Enum.ContextActionResult.Pass;
	end;
	if p67 == Enum.UserInputState.Cancel then
		p65.turningLeft = false;
		p65.turningRight = false;
		return Enum.ContextActionResult.Sink;
	end;
	if p65.panBeginLook ~= nil or not p65.keyPanEnabled then
		return Enum.ContextActionResult.Pass;
	end;
	if p68.KeyCode == Enum.KeyCode.Left then
		p65.turningLeft = p67 == Enum.UserInputState.Begin;
	elseif p68.KeyCode == Enum.KeyCode.Right then
		p65.turningRight = p67 == Enum.UserInputState.Begin;
	end;
	return Enum.ContextActionResult.Sink;
end;
function v28.DoGamepadZoom(p69, p70, p71, p72)
	assert(not u5);
	if p72.UserInputType ~= p69.activeGamepad then
		return Enum.ContextActionResult.Pass;
	end;
	if p72.KeyCode == Enum.KeyCode.ButtonR3 then
		if p71 == Enum.UserInputState.Begin and p69.distanceChangeEnabled then
			local v54 = p69:GetCameraToSubjectDistance();
			if v54 > 15 then
				p69:SetCameraToSubjectDistance(10);
			elseif v54 > 5 then
				p69:SetCameraToSubjectDistance(0);
			else
				p69:SetCameraToSubjectDistance(20);
			end;
		end;
	elseif p72.KeyCode == Enum.KeyCode.DPadLeft then
		p69.dpadLeftDown = p71 == Enum.UserInputState.Begin;
	elseif p72.KeyCode == Enum.KeyCode.DPadRight then
		p69.dpadRightDown = p71 == Enum.UserInputState.Begin;
	end;
	if p69.dpadLeftDown then
		p69.currentZoomSpeed = 1.04;
	elseif p69.dpadRightDown then
		p69.currentZoomSpeed = 0.96;
	else
		p69.currentZoomSpeed = 1;
	end;
	return Enum.ContextActionResult.Sink;
end;
function v28.DoKeyboardZoom(p73, p74, p75, p76)
	assert(not u5);
	if not p73.hasGameLoaded and l__VRService__4.VREnabled then
		return Enum.ContextActionResult.Pass;
	end;
	if p75 ~= Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Pass;
	end;
	if not p73.distanceChangeEnabled or l__LocalPlayer__1.CameraMode == Enum.CameraMode.LockFirstPerson then
		return Enum.ContextActionResult.Pass;
	end;
	if p76.KeyCode == Enum.KeyCode.I then
		p73:SetCameraToSubjectDistance(p73.currentSubjectDistance - 5);
	elseif p76.KeyCode == Enum.KeyCode.O then
		p73:SetCameraToSubjectDistance(p73.currentSubjectDistance + 5);
	end;
	return Enum.ContextActionResult.Sink;
end;
local l__Value__13 = Enum.ContextActionPriority.Default.Value;
function v28.BindAction(p77, p78, p79, p80, ...)
	assert(not u5);
	table.insert(p77.boundContextActions, p78);
	l__ContextActionService__11:BindActionAtPriority(p78, p79, p80, l__Value__13, ...);
end;
function v28.BindGamepadInputActions(p81)
	assert(not u5);
	p81:BindAction("BaseCameraGamepadPan", function(p82, p83, p84)
		return p81:GetGamepadPan(p82, p83, p84);
	end, false, Enum.KeyCode.Thumbstick2);
	p81:BindAction("BaseCameraGamepadZoom", function(p85, p86, p87)
		return p81:DoGamepadZoom(p85, p86, p87);
	end, false, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadRight, Enum.KeyCode.ButtonR3);
end;
function v28.BindKeyboardInputActions(p88)
	assert(not u5);
	p88:BindAction("BaseCameraKeyboardPanArrowKeys", function(p89, p90, p91)
		return p88:DoKeyboardPanTurn(p89, p90, p91);
	end, false, Enum.KeyCode.Left, Enum.KeyCode.Right);
	p88:BindAction("BaseCameraKeyboardZoom", function(p92, p93, p94)
		return p88:DoKeyboardZoom(p92, p93, p94);
	end, false, Enum.KeyCode.I, Enum.KeyCode.O);
end;
function v28.AdjustTouchSensitivity(p95, p96, p97)
	local v55 = game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame;
	if not v55 then
		return p97;
	end;
	local v56 = v55:ToEulerAnglesYXZ();
	local v57 = 2.1;
	if v5 < v56 and p96.Y < 0 then
		v57 = 2.1 - (1 - (1 - (v56 - v5) / (v4 - v5)) ^ 3) * 1.6;
	elseif v56 < v6 and p96.Y > 0 then
		v57 = 2.1 - (1 - (1 - (v56 - v6) / (v3 - v6)) ^ 3) * 1.6;
	end;
	return Vector2.new(p97.X, p97.Y * v57);
end;
local function u14(p98)
	assert(not u5);
	local v58 = l__LocalPlayer__1:FindFirstChildOfClass("PlayerGui");
	local v59 = v58 and v58:FindFirstChild("TouchGui");
	local v60 = v59 and v59:FindFirstChild("TouchControlFrame");
	local v61 = v60 and v60:FindFirstChild("DynamicThumbstickFrame");
	if not v61 then
		return false;
	end;
	local l__AbsolutePosition__62 = v61.AbsolutePosition;
	local v63 = l__AbsolutePosition__62 + v61.AbsoluteSize;
	if l__AbsolutePosition__62.X <= p98.Position.X and l__AbsolutePosition__62.Y <= p98.Position.Y and p98.Position.X <= v63.X and p98.Position.Y <= v63.Y then
		return true;
	end;
	return false;
end;
function v28.OnTouchBegan(p99, p100, p101)
	assert(not u5);
	if p99.isDynamicThumbstickEnabled and not p101 then
		if p99.dynamicTouchInput ~= nil or not u14(p100) then
			p99.fingerTouches[p100] = p101;
			p99.inputStartPositions[p100] = p100.Position;
			p99.inputStartTimes[p100] = tick();
			p99.numUnsunkTouches = p99.numUnsunkTouches + 1;
			return;
		end;
	else
		return;
	end;
	p99.dynamicTouchInput = p100;
end;
function v28.OnTouchChanged(p102, p103, p104)
	assert(not u5);
	if p102.fingerTouches[p103] == nil then
		if p102.isDynamicThumbstickEnabled then
			return;
		end;
		p102.fingerTouches[p103] = p104;
		if not p104 then
			p102.numUnsunkTouches = p102.numUnsunkTouches + 1;
		end;
	end;
	if p102.numUnsunkTouches == 1 then
		if p102.fingerTouches[p103] == false then
			p102.panBeginLook = p102.panBeginLook or p102:GetCameraLookVector();
			p102.startPos = p102.startPos or p103.Position;
			p102.lastPos = p102.lastPos or p102.startPos;
			p102.userPanningTheCamera = true;
			local v64 = p103.Position - p102.lastPos;
			local v65 = Vector2.new(v64.X, v64.Y * l__UserGameSettings__2:GetCameraYInvertValue());
			if p102.panEnabled then
				p102:AdjustTouchSensitivity(v65, v12);
				p102.rotateInput = p102.rotateInput + p102:InputTranslationToCameraAngleChange(v65, v12);
			end;
			p102.lastPos = p103.Position;
		end;
	else
		p102.panBeginLook = nil;
		p102.startPos = nil;
		p102.lastPos = nil;
		p102.userPanningTheCamera = false;
	end;
	if p102.numUnsunkTouches == 2 then
		local v66 = {};
		for v67, v68 in pairs(p102.fingerTouches) do
			if not v68 then
				table.insert(v66, v67);
			end;
		end;
		if #v66 == 2 then
			local l__magnitude__69 = (v66[1].Position - v66[2].Position).magnitude;
			if not p102.startingDiff or not p102.pinchBeginZoom then
				p102.startingDiff = l__magnitude__69;
				p102.pinchBeginZoom = p102:GetCameraToSubjectDistance();
				return;
			end;
			local v70 = math.clamp(l__magnitude__69 / math.max(0.01, p102.startingDiff), 0.1, 10);
			if p102.distanceChangeEnabled then
				p102:SetCameraToSubjectDistance(p102.pinchBeginZoom / v70);
				return;
			end;
		end;
	else
		p102.startingDiff = nil;
		p102.pinchBeginZoom = nil;
	end;
end;
function v28.OnTouchEnded(p105, p106, p107)
	assert(not u5);
	if p106 == p105.dynamicTouchInput then
		p105.dynamicTouchInput = nil;
		return;
	end;
	if p105.fingerTouches[p106] == false then
		if p105.numUnsunkTouches == 1 then
			p105.panBeginLook = nil;
			p105.startPos = nil;
			p105.lastPos = nil;
			p105.userPanningTheCamera = false;
		elseif p105.numUnsunkTouches == 2 then
			p105.startingDiff = nil;
			p105.pinchBeginZoom = nil;
		end;
	end;
	if p105.fingerTouches[p106] ~= nil and p105.fingerTouches[p106] == false then
		p105.numUnsunkTouches = p105.numUnsunkTouches - 1;
	end;
	p105.fingerTouches[p106] = nil;
	p105.inputStartPositions[p106] = nil;
	p105.inputStartTimes[p106] = nil;
end;
function v28.OnMouse2Down(p108, p109, p110)
	assert(not u5);
	if p110 then
		return;
	end;
	p108.isRightMouseDown = true;
	p108:OnMousePanButtonPressed(p109, p110);
end;
function v28.OnMouse2Up(p111, p112, p113)
	assert(not u5);
	p111.isRightMouseDown = false;
	p111:OnMousePanButtonReleased(p112, p113);
end;
function v28.OnMouse3Down(p114, p115, p116)
	assert(not u5);
	if p116 then
		return;
	end;
	p114.isMiddleMouseDown = true;
	p114:OnMousePanButtonPressed(p115, p116);
end;
function v28.OnMouse3Up(p117, p118, p119)
	assert(not u5);
	p117.isMiddleMouseDown = false;
	p117:OnMousePanButtonReleased(p118, p119);
end;
function v28.OnMouseMoved(p120, p121, p122)
	assert(not u5);
	if not p120.hasGameLoaded and l__VRService__4.VREnabled then
		return;
	end;
	local l__Delta__71 = p121.Delta;
	local v72 = Vector2.new(l__Delta__71.X, l__Delta__71.Y * l__UserGameSettings__2:GetCameraYInvertValue());
	if p120.panEnabled and (p120.startPos and (p120.lastPos and p120.panBeginLook) or (p120.inFirstPerson or (p120.inMouseLockedMode or u10 and u6.getPanning()))) then
		p120.rotateInput = p120.rotateInput + p120:InputTranslationToCameraAngleChange(v72, v13);
	end;
	if p120.startPos and p120.lastPos and p120.panBeginLook then
		p120.lastPos = p120.lastPos + p121.Delta;
	end;
end;
function v28.OnMousePanButtonPressed(p123, p124, p125)
	assert(not u5);
	if p125 then
		return;
	end;
	if not u10 then
		p123:UpdateMouseBehavior();
	end;
	p123.panBeginLook = p123.panBeginLook or p123:GetCameraLookVector();
	p123.startPos = p123.startPos or p124.Position;
	p123.lastPos = p123.lastPos or p123.startPos;
	p123.userPanningTheCamera = true;
end;
function v28.OnMousePanButtonReleased(p126, p127, p128)
	assert(not u5);
	if not u10 then
		p126:UpdateMouseBehavior();
	end;
	if not p126.isRightMouseDown and not p126.isMiddleMouseDown then
		p126.panBeginLook = nil;
		p126.startPos = nil;
		p126.lastPos = nil;
		p126.userPanningTheCamera = false;
	end;
end;
local u15 = require(script.Parent:WaitForChild("CameraUI"));
local u16 = require(script.Parent:WaitForChild("CameraToggleStateController"));
function v28.UpdateMouseBehavior(p129)
	if u10 and p129.isCameraToggle then
		u15.setCameraModeToastEnabled(true);
		u6.enableCameraToggleInput();
		u16(p129.inFirstPerson);
		return;
	end;
	if u10 then
		u15.setCameraModeToastEnabled(false);
		u6.disableCameraToggleInput();
	end;
	if p129.inFirstPerson or p129.inMouseLockedMode then
		l__UserGameSettings__2.RotationType = Enum.RotationType.CameraRelative;
		l__UserInputService__3.MouseBehavior = Enum.MouseBehavior.LockCenter;
		return;
	end;
	l__UserGameSettings__2.RotationType = Enum.RotationType.MovementRelative;
	if not p129.isRightMouseDown and not p129.isMiddleMouseDown then
		l__UserInputService__3.MouseBehavior = Enum.MouseBehavior.Default;
		return;
	end;
	l__UserInputService__3.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition;
end;
function v28.UpdateForDistancePropertyChange(p130)
	p130:SetCameraToSubjectDistance(p130.currentSubjectDistance);
end;
local u17 = require(script.Parent:WaitForChild("ZoomController"));
function v28.SetCameraToSubjectDistance(p131, p132)
	if l__LocalPlayer__1.CameraMode == Enum.CameraMode.LockFirstPerson then
		p131.currentSubjectDistance = 0.5;
		if not p131.inFirstPerson then
			p131:EnterFirstPerson();
		end;
	else
		local v73 = math.clamp(p132, l__LocalPlayer__1.CameraMinZoomDistance, l__LocalPlayer__1.CameraMaxZoomDistance);
		if v73 < 1 then
			p131.currentSubjectDistance = 0.5;
			if not p131.inFirstPerson then
				p131:EnterFirstPerson();
			end;
		else
			p131.currentSubjectDistance = v73;
			if p131.inFirstPerson then
				p131:LeaveFirstPerson();
			end;
		end;
	end;
	u17.SetZoomParameters(p131.currentSubjectDistance, math.sign(p132 - p131.currentSubjectDistance));
	return p131.currentSubjectDistance;
end;
function v28.SetCameraType(p133, p134)
	p133.cameraType = p134;
end;
function v28.GetCameraType(p135)
	return p135.cameraType;
end;
function v28.SetCameraMovementMode(p136, p137)
	p136.cameraMovementMode = p137;
end;
function v28.GetCameraMovementMode(p138)
	return p138.cameraMovementMode;
end;
function v28.SetIsMouseLocked(p139, p140)
	p139.inMouseLockedMode = p140;
	if not u10 then
		p139:UpdateMouseBehavior();
	end;
end;
function v28.GetIsMouseLocked(p141)
	return p141.inMouseLockedMode;
end;
function v28.SetMouseLockOffset(p142, p143)
	p142.mouseLockOffset = p143;
end;
function v28.GetMouseLockOffset(p144)
	return p144.mouseLockOffset;
end;
function v28.InFirstPerson(p145)
	return p145.inFirstPerson;
end;
function v28.EnterFirstPerson(p146)

end;
function v28.LeaveFirstPerson(p147)

end;
function v28.GetCameraToSubjectDistance(p148)
	return p148.currentSubjectDistance;
end;
function v28.GetMeasuredDistanceToFocus(p149)
	local l__CurrentCamera__74 = game.Workspace.CurrentCamera;
	if not l__CurrentCamera__74 then
		return nil;
	end;
	return (l__CurrentCamera__74.CoordinateFrame.p - l__CurrentCamera__74.Focus.p).magnitude;
end;
function v28.GetCameraLookVector(p150)
	return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.lookVector or v1;
end;
function v28.CalculateNewLookCFrameFromArg(p151, p152, p153)
	local v75 = p152 or p151:GetCameraLookVector();
	local v76 = math.asin(v75.y);
	local v77 = Vector2.new(p153.x, (math.clamp(p153.y, -v4 + v76, -v3 + v76)));
	return CFrame.Angles(0, -v77.x, 0) * CFrame.new(v11, v75) * CFrame.Angles(-v77.y, 0, 0);
end;
function v28.CalculateNewLookVectorFromArg(p154, p155, p156)
	return p154:CalculateNewLookCFrameFromArg(p155, p156).lookVector;
end;
function v28.CalculateNewLookVectorVRFromArg(p157, p158)
	local v78 = Vector2.new(p158.x, 0);
	return ((CFrame.Angles(0, -v78.x, 0) * CFrame.new(v11, ((p157:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * v2).unit) * CFrame.Angles(-v78.y, 0, 0)).lookVector * v2).unit;
end;
function v28.CalculateNewLookCFrame(p159, p160)
	assert(not u5);
	local v79 = p160 or p159:GetCameraLookVector();
	local v80 = math.asin(v79.y);
	local v81 = Vector2.new(p159.rotateInput.x, (math.clamp(p159.rotateInput.y, -v4 + v80, -v3 + v80)));
	return CFrame.Angles(0, -v81.x, 0) * CFrame.new(v11, v79) * CFrame.Angles(-v81.y, 0, 0);
end;
function v28.CalculateNewLookVector(p161, p162)
	assert(not u5);
	return p161:CalculateNewLookCFrame(p162).lookVector;
end;
function v28.CalculateNewLookVectorVR(p163)
	assert(not u5);
	local v82 = Vector2.new(p163.rotateInput.x, 0);
	return ((CFrame.Angles(0, -v82.x, 0) * CFrame.new(v11, ((p163:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * v2).unit) * CFrame.Angles(-v82.y, 0, 0)).lookVector * v2).unit;
end;
function v28.GetHumanoid(p164)
	local v83 = l__LocalPlayer__1 and l__LocalPlayer__1.Character;
	if not v83 then
		return nil;
	end;
	local v84 = p164.humanoidCache[l__LocalPlayer__1];
	if v84 and v84.Parent == v83 then
		return v84;
	end;
	p164.humanoidCache[l__LocalPlayer__1] = nil;
	local v85 = v83:FindFirstChildOfClass("Humanoid");
	if v85 then
		p164.humanoidCache[l__LocalPlayer__1] = v85;
	end;
	return v85;
end;
function v28.GetHumanoidPartToFollow(p165, p166, p167)
	if p167 ~= Enum.HumanoidStateType.Dead then
		return p166.Torso;
	end;
	local l__Parent__86 = p166.Parent;
	if not l__Parent__86 then
		return p166.Torso;
	end;
	return l__Parent__86:FindFirstChild("Head") or p166.Torso;
end;
local u18 = require(script.Parent:WaitForChild("CameraUtils"));
function v28.UpdateGamepad(p168)
	local l__gamepadPanningCamera__87 = p168.gamepadPanningCamera;
	if not l__gamepadPanningCamera__87 or not p168.hasGameLoaded and l__VRService__4.VREnabled then
		return v10;
	end;
	local v88 = u18.GamepadLinearToCurve(l__gamepadPanningCamera__87);
	local v89 = tick();
	if v88.X ~= 0 or v88.Y ~= 0 then
		p168.userPanningTheCamera = true;
	elseif v88 == v10 then
		if u12 then
			p168.userPanningTheCamera = false;
			p168.gamepadPanningCamera = false;
		end;
		p168.lastThumbstickRotate = nil;
		if p168.lastThumbstickPos == v10 then
			p168.currentSpeed = 0;
		end;
	end;
	local v90 = 0;
	if p168.lastThumbstickRotate then
		if l__VRService__4.VREnabled then
			p168.currentSpeed = p168.vrMaxSpeed;
		else
			local v91 = (v89 - p168.lastThumbstickRotate) * 10;
			p168.currentSpeed = p168.currentSpeed + p168.maxSpeed * (v91 * v91 / p168.numOfSeconds);
			if p168.maxSpeed < p168.currentSpeed then
				p168.currentSpeed = p168.maxSpeed;
			end;
			if p168.lastVelocity then
				local l__magnitude__92 = ((v88 - p168.lastThumbstickPos) / (v89 - p168.lastThumbstickRotate) - p168.lastVelocity).magnitude;
				if l__magnitude__92 > 12 then
					p168.currentSpeed = p168.currentSpeed * (20 / l__magnitude__92);
					if p168.maxSpeed < p168.currentSpeed then
						p168.currentSpeed = p168.maxSpeed;
					end;
				end;
			end;
		end;
		v90 = l__UserGameSettings__2.GamepadCameraSensitivity * p168.currentSpeed;
		p168.lastVelocity = (v88 - p168.lastThumbstickPos) / (v89 - p168.lastThumbstickRotate);
	end;
	p168.lastThumbstickPos = v88;
	p168.lastThumbstickRotate = v89;
	return Vector2.new(v88.X * v90, v88.Y * v90 * p168.ySensitivity * l__UserGameSettings__2:GetCameraYInvertValue());
end;
function v28.ApplyVRTransform(p169)
	if not l__VRService__4.VREnabled then
		return;
	end;
	local v93 = p169.humanoidRootPart and p169.humanoidRootPart:FindFirstChild("RootJoint");
	if not v93 then
		return;
	end;
	local l__CameraSubject__94 = game.Workspace.CurrentCamera.CameraSubject;
	if not p169.inFirstPerson or not (not l__CameraSubject__94) and not (not l__CameraSubject__94:IsA("VehicleSeat")) then
		v93.C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0);
		return;
	end;
	local v95 = l__VRService__4:GetUserCFrame(Enum.UserCFrame.Head);
	v93.C0 = CFrame.new((v95 - v95.p):vectorToObjectSpace(v95.p)) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0);
end;
function v28.IsInFirstPerson(p170)
	return p170.inFirstPerson;
end;
local l__StarterGui__19 = game:GetService("StarterGui");
function v28.ShouldUseVRRotation(p171)
	if not l__VRService__4.VREnabled then
		return false;
	end;
	if not p171.VRRotationIntensityAvailable and tick() - p171.lastVRRotationIntensityCheckTime < 1 then
		return false;
	end;
	local v96, v97 = pcall(function()
		return l__StarterGui__19:GetCore("VRRotationIntensity");
	end);
	p171.VRRotationIntensityAvailable = v96 and v97 ~= nil;
	p171.lastVRRotationIntensityCheckTime = tick();
	local v98 = v96;
	if v98 then
		v98 = false;
		if v97 ~= nil then
			v98 = v97 ~= "Smooth";
		end;
	end;
	p171.shouldUseVRRotation = v98;
	return p171.shouldUseVRRotation;
end;
function v28.GetVRRotationInput(p172)
	local v99 = v10;
	local v100, v101 = pcall(function()
		return l__StarterGui__19:GetCore("VRRotationIntensity");
	end);
	if not v100 then
		return;
	end;
	local v102 = p172.GamepadPanningCamera or v10;
	local v103 = p172:GetRepeatDelayValue(v101) <= tick() - p172.lastVRRotationTime;
	if p172:GetActivateValue() <= math.abs(v102.x) then
		if v103 or not p172.vrRotateKeyCooldown[Enum.KeyCode.Thumbstick2] then
			local v104 = 1;
			if v102.x < 0 then
				v104 = -1;
			end;
			v99 = v99 + p172:GetRotateAmountValue(v101) * v104;
			p172.vrRotateKeyCooldown[Enum.KeyCode.Thumbstick2] = true;
		end;
	elseif math.abs(v102.x) < p172:GetActivateValue() - 0.1 then
		p172.vrRotateKeyCooldown[Enum.KeyCode.Thumbstick2] = nil;
	end;
	if p172.turningLeft then
		if v103 or not p172.vrRotateKeyCooldown[Enum.KeyCode.Left] then
			v99 = v99 - p172:GetRotateAmountValue(v101);
			p172.vrRotateKeyCooldown[Enum.KeyCode.Left] = true;
		end;
	else
		p172.vrRotateKeyCooldown[Enum.KeyCode.Left] = nil;
	end;
	if p172.turningRight then
		if v103 or not p172.vrRotateKeyCooldown[Enum.KeyCode.Right] then
			v99 = v99 + p172:GetRotateAmountValue(v101);
			p172.vrRotateKeyCooldown[Enum.KeyCode.Right] = true;
		end;
	else
		p172.vrRotateKeyCooldown[Enum.KeyCode.Right] = nil;
	end;
	if v99 ~= v10 then
		p172.lastVRRotationTime = tick();
	end;
	return v99;
end;
function v28.CancelCameraFreeze(p173, p174)
	if not p174 then
		p173.cameraTranslationConstraints = Vector3.new(p173.cameraTranslationConstraints.x, 1, p173.cameraTranslationConstraints.z);
	end;
	if p173.cameraFrozen then
		p173.trackingHumanoid = nil;
		p173.cameraFrozen = false;
	end;
end;
function v28.StartCameraFreeze(p175, p176, p177)
	if not p175.cameraFrozen then
		p175.humanoidJumpOrigin = p176;
		p175.trackingHumanoid = p177;
		p175.cameraTranslationConstraints = Vector3.new(p175.cameraTranslationConstraints.x, 0, p175.cameraTranslationConstraints.z);
		p175.cameraFrozen = true;
	end;
end;
function v28.OnNewCameraSubject(p178)
	if p178.subjectStateChangedConn then
		p178.subjectStateChangedConn:Disconnect();
		p178.subjectStateChangedConn = nil;
	end;
	local v105 = workspace.CurrentCamera and workspace.CurrentCamera.CameraSubject;
	if p178.trackingHumanoid ~= v105 then
		p178:CancelCameraFreeze();
	end;
	if v105 and v105:IsA("Humanoid") then
		p178.subjectStateChangedConn = v105.StateChanged:Connect(function(p179, p180)
			if l__VRService__4.VREnabled and p180 == Enum.HumanoidStateType.Jumping and not p178.inFirstPerson then
				p178:StartCameraFreeze(p178:GetSubjectPosition(), v105);
				return;
			end;
			if p180 ~= Enum.HumanoidStateType.Jumping and p180 ~= Enum.HumanoidStateType.Freefall then
				p178:CancelCameraFreeze(true);
			end;
		end);
	end;
end;
function v28.GetVRFocus(p181, p182, p183)
	local v106 = p181.LastCameraFocus and p182;
	if not p181.cameraFrozen then
		p181.cameraTranslationConstraints = Vector3.new(p181.cameraTranslationConstraints.x, math.min(1, p181.cameraTranslationConstraints.y + 0.42 * p183), p181.cameraTranslationConstraints.z);
	end;
	if p181.cameraFrozen and p181.humanoidJumpOrigin and v106.y < p181.humanoidJumpOrigin.y then
		local v107 = CFrame.new(Vector3.new(p182.x, math.min(p181.humanoidJumpOrigin.y, v106.y + 5 * p183), p182.z));
	else
		v107 = CFrame.new(Vector3.new(p182.x, v106.y, p182.z):lerp(p182, p181.cameraTranslationConstraints.y));
	end;
	if p181.cameraFrozen then
		if p181.inFirstPerson then
			p181:CancelCameraFreeze();
		end;
		if p181.humanoidJumpOrigin and p182.y < p181.humanoidJumpOrigin.y - 0.5 then
			p181:CancelCameraFreeze();
		end;
	end;
	return v107;
end;
function v28.GetRotateAmountValue(p184, p185)
	p185 = p185 or l__StarterGui__19:GetCore("VRRotationIntensity");
	if p185 then
		if p185 == "Low" then
			return v8;
		end;
		if p185 == "High" then
			return v9;
		end;
	end;
	return v10;
end;
function v28.GetRepeatDelayValue(p186, p187)
	p187 = p187 or l__StarterGui__19:GetCore("VRRotationIntensity");
	if p187 then
		if p187 == "Low" then
			return 0.1;
		end;
		if p187 == "High" then
			return 0.4;
		end;
	end;
	return 0;
end;
function v28.Update(p188, p189)
	error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2);
end;
return v28;
