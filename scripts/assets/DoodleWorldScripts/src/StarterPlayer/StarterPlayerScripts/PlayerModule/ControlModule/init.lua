-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
v1.__index = v1;
local l__Players__2 = game:GetService("Players");
local l__RunService__3 = game:GetService("RunService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__Workspace__5 = game:GetService("Workspace");
local l__UserGameSettings__6 = UserSettings():GetService("UserGameSettings");
local v7 = require(script:WaitForChild("Keyboard"));
local v8 = require(script:WaitForChild("Gamepad"));
local v9 = require(script:WaitForChild("DynamicThumbstick"));
local v10, v11 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserMakeThumbstickDynamic");
end);
local v12 = (v10 or v11) and v9 or require(script:WaitForChild("TouchThumbstick"));
local v13 = require(script:WaitForChild("ClickToMoveController"));
local u1 = require(script:WaitForChild("VehicleController"));
local l__Value__2 = Enum.ContextActionPriority.Default.Value;
function v1.new()
	local v14 = setmetatable({}, v1);
	v14.controllers = {};
	v14.activeControlModule = nil;
	v14.activeController = nil;
	v14.touchJumpController = nil;
	v14.moveFunction = l__Players__2.LocalPlayer.Move;
	v14.humanoid = nil;
	v14.lastInputType = Enum.UserInputType.None;
	v14.humanoidSeatedConn = nil;
	v14.vehicleController = nil;
	v14.touchControlFrame = nil;
	v14.vehicleController = u1.new(l__Value__2);
	l__Players__2.LocalPlayer.CharacterAdded:Connect(function(p1)
		v14:OnCharacterAdded(p1);
	end);
	l__Players__2.LocalPlayer.CharacterRemoving:Connect(function(p2)
		v14:OnCharacterRemoving(p2);
	end);
	if l__Players__2.LocalPlayer.Character then
		v14:OnCharacterAdded(l__Players__2.LocalPlayer.Character);
	end;
	l__RunService__3:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p3)
		v14:OnRenderStepped(p3);
	end);
	l__UserInputService__4.LastInputTypeChanged:Connect(function(p4)
		v14:OnLastInputTypeChanged(p4);
	end);
	l__UserGameSettings__6:GetPropertyChangedSignal("TouchMovementMode"):Connect(function()
		v14:OnTouchMovementModeChange();
	end);
	l__Players__2.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function()
		v14:OnTouchMovementModeChange();
	end);
	l__UserGameSettings__6:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function()
		v14:OnComputerMovementModeChange();
	end);
	l__Players__2.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
		v14:OnComputerMovementModeChange();
	end);
	v14.playerGui = nil;
	v14.touchGui = nil;
	v14.playerGuiAddedConn = nil;
	if not l__UserInputService__4.TouchEnabled then
		v14:OnLastInputTypeChanged(l__UserInputService__4:GetLastInputType());
		return v14;
	end;
	v14.playerGui = l__Players__2.LocalPlayer:FindFirstChildOfClass("PlayerGui");
	if not v14.playerGui then
		v14.playerGuiAddedConn = l__Players__2.LocalPlayer.ChildAdded:Connect(function(p5)
			if p5:IsA("PlayerGui") then
				v14.playerGui = p5;
				v14:CreateTouchGuiContainer();
				v14.playerGuiAddedConn:Disconnect();
				v14.playerGuiAddedConn = nil;
				v14:OnLastInputTypeChanged(l__UserInputService__4:GetLastInputType());
			end;
		end);
		return v14;
	end;
	v14:CreateTouchGuiContainer();
	v14:OnLastInputTypeChanged(l__UserInputService__4:GetLastInputType());
	return v14;
end;
function v1.GetMoveVector(p6)
	if not p6.activeController then
		return Vector3.new(0, 0, 0);
	end;
	return p6.activeController:GetMoveVector();
end;
function v1.GetActiveController(p7)
	return p7.activeController;
end;
function v1.EnableActiveControlModule(p8)
	if p8.activeControlModule == v13 then
		p8.activeController:Enable(true, l__Players__2.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, p8.touchJumpController);
		return;
	end;
	if not p8.touchControlFrame then
		p8.activeController:Enable(true);
		return;
	end;
	p8.activeController:Enable(true, p8.touchControlFrame);
end;
function v1.Enable(p9, p10)
	if not p9.activeController then
		return;
	end;
	if p10 == nil then
		p10 = true;
	end;
	if p10 then
		p9:EnableActiveControlModule();
		return;
	end;
	p9:Disable();
end;
function v1.Disable(p11)
	if p11.activeController then
		p11.activeController:Enable(false);
		if p11.moveFunction then
			p11.moveFunction(l__Players__2.LocalPlayer, Vector3.new(0, 0, 0), true);
		end;
	end;
end;
local u3 = {
	[Enum.UserInputType.Keyboard] = v7, 
	[Enum.UserInputType.MouseButton1] = v7, 
	[Enum.UserInputType.MouseButton2] = v7, 
	[Enum.UserInputType.MouseButton3] = v7, 
	[Enum.UserInputType.MouseWheel] = v7, 
	[Enum.UserInputType.MouseMovement] = v7, 
	[Enum.UserInputType.Gamepad1] = v8, 
	[Enum.UserInputType.Gamepad2] = v8, 
	[Enum.UserInputType.Gamepad3] = v8, 
	[Enum.UserInputType.Gamepad4] = v8
};
local u4 = nil;
local u5 = {
	[Enum.TouchMovementMode.DPad] = v9, 
	[Enum.DevTouchMovementMode.DPad] = v9, 
	[Enum.TouchMovementMode.Thumbpad] = v9, 
	[Enum.DevTouchMovementMode.Thumbpad] = v9, 
	[Enum.TouchMovementMode.Thumbstick] = v12, 
	[Enum.DevTouchMovementMode.Thumbstick] = v12, 
	[Enum.TouchMovementMode.DynamicThumbstick] = v9, 
	[Enum.DevTouchMovementMode.DynamicThumbstick] = v9, 
	[Enum.TouchMovementMode.ClickToMove] = v13, 
	[Enum.DevTouchMovementMode.ClickToMove] = v13, 
	[Enum.TouchMovementMode.Default] = v9, 
	[Enum.ComputerMovementMode.Default] = v7, 
	[Enum.ComputerMovementMode.KeyboardMouse] = v7, 
	[Enum.DevComputerMovementMode.KeyboardMouse] = v7, 
	[Enum.DevComputerMovementMode.Scriptable] = nil, 
	[Enum.ComputerMovementMode.ClickToMove] = v13, 
	[Enum.DevComputerMovementMode.ClickToMove] = v13
};
function v1.SelectComputerMovementModule(p12)
	if not l__UserInputService__4.KeyboardEnabled and not l__UserInputService__4.GamepadEnabled then
		return nil, false;
	end;
	local l__DevComputerMovementMode__15 = l__Players__2.LocalPlayer.DevComputerMovementMode;
	if l__DevComputerMovementMode__15 == Enum.DevComputerMovementMode.UserChoice then
		local v16 = u3[u4];
		if l__UserGameSettings__6.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v16 == v7 then
			v16 = v13;
		end;
	else
		v16 = u5[l__DevComputerMovementMode__15];
		if not v16 and l__DevComputerMovementMode__15 ~= Enum.DevComputerMovementMode.Scriptable then
			warn("No character control module is associated with DevComputerMovementMode ", l__DevComputerMovementMode__15);
		end;
	end;
	if v16 then
		return v16, true;
	end;
	if l__DevComputerMovementMode__15 == Enum.DevComputerMovementMode.Scriptable then
		return nil, true;
	end;
	return nil, false;
end;
function v1.SelectTouchModule(p13)
	if not l__UserInputService__4.TouchEnabled then
		return nil, false;
	end;
	local l__DevTouchMovementMode__17 = l__Players__2.LocalPlayer.DevTouchMovementMode;
	if l__DevTouchMovementMode__17 == Enum.DevTouchMovementMode.UserChoice then
		local v18 = u5[l__UserGameSettings__6.TouchMovementMode];
	else
		if l__DevTouchMovementMode__17 == Enum.DevTouchMovementMode.Scriptable then
			return nil, true;
		end;
		v18 = u5[l__DevTouchMovementMode__17];
	end;
	return v18, true;
end;
local function u6(p14, p15)
	local l__CurrentCamera__19 = l__Workspace__5.CurrentCamera;
	if not l__CurrentCamera__19 then
		return p15;
	end;
	if p14:GetState() == Enum.HumanoidStateType.Swimming then
		return l__CurrentCamera__19.CFrame:VectorToWorldSpace(p15);
	end;
	local v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31 = l__CurrentCamera__19.CFrame:GetComponents();
	if v28 < 1 and v28 > -1 then
		local v32 = v31;
		local v33 = v25;
	else
		v32 = v23;
		v33 = -v24 * math.sign(v28);
	end;
	local v34 = math.sqrt(v32 * v32 + v33 * v33);
	return Vector3.new((v32 * p15.x + v33 * p15.z) / v34, 0, (v32 * p15.z - v33 * p15.x) / v34);
end;
function v1.OnRenderStepped(p16, p17)
	if p16.activeController and p16.activeController.enabled and p16.humanoid then
		p16.activeController:OnRenderStepped(p17);
		local v35 = p16.activeController:GetMoveVector();
		local v36 = p16.activeController:IsMoveVectorCameraRelative();
		local v37 = p16:GetClickToMoveController();
		if p16.activeController ~= v37 then
			if v35.magnitude > 0 then
				v37:CleanupPath();
			else
				v37:OnRenderStepped(p17);
				v35 = v37:GetMoveVector();
				v36 = v37:IsMoveVectorCameraRelative();
			end;
		end;
		if p16.vehicleController then
			local v38, v39 = p16.vehicleController:Update(v35, v36, p16.activeControlModule == v8);
			v35 = v38;
		end;
		if v36 then
			v35 = u6(p16.humanoid, v35);
		end;
		p16.moveFunction(l__Players__2.LocalPlayer, v35, false);
		p16.humanoid.Jump = p16.activeController:GetIsJumping() or p16.touchJumpController and p16.touchJumpController:GetIsJumping();
	end;
end;
function v1.OnHumanoidSeated(p18, p19, p20)
	if p19 then
		if p20 and p20:IsA("VehicleSeat") then
			if not p18.vehicleController then
				p18.vehicleController = p18.vehicleController.new(l__Value__2);
			end;
			p18.vehicleController:Enable(true, p20);
			return;
		end;
	elseif p18.vehicleController then
		p18.vehicleController:Enable(false, p20);
	end;
end;
function v1.OnCharacterAdded(p21, p22)
	p21.humanoid = p22:FindFirstChildOfClass("Humanoid");
	while not p21.humanoid do
		p22.ChildAdded:wait();
		p21.humanoid = p22:FindFirstChildOfClass("Humanoid");	
	end;
	if p21.touchGui then
		p21.touchGui.Enabled = true;
	end;
	if p21.humanoidSeatedConn then
		p21.humanoidSeatedConn:Disconnect();
		p21.humanoidSeatedConn = nil;
	end;
	p21.humanoidSeatedConn = p21.humanoid.Seated:Connect(function(p23, p24)
		p21:OnHumanoidSeated(p23, p24);
	end);
end;
function v1.OnCharacterRemoving(p25, p26)
	p25.humanoid = nil;
	if p25.touchGui then
		p25.touchGui.Enabled = false;
	end;
end;
local u7 = require(script:WaitForChild("TouchJump"));
local u8 = require(script:WaitForChild("TouchRun"));
function v1.SwitchToController(p27, p28)
	if not p28 then
		if p27.activeController then
			p27.activeController:Enable(false);
		end;
		p27.activeController = nil;
		p27.activeControlModule = nil;
		return;
	end;
	if not p27.controllers[p28] then
		p27.controllers[p28] = p28.new(l__Value__2);
	end;
	if p27.activeController ~= p27.controllers[p28] then
		local v40 = nil;
		local v41 = nil;
		local v42 = nil;
		local v43 = nil;
		local v44 = nil;
		local v45 = nil;
		local v46 = nil;
		local v47 = nil;
		if p27.activeController then
			p27.activeController:Enable(false);
		end;
		p27.activeController = p27.controllers[p28];
		p27.activeControlModule = p28;
		if p27.touchControlFrame then
			p27.activeController:Enable(true, p27.touchControlFrame);
		elseif p27.activeControlModule == v13 then
			p27.activeController:Enable(true, l__Players__2.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice);
		else
			p27.activeController:Enable(true);
		end;
		if p27.touchControlFrame then
			if p27.activeControlModule == v12 or p27.activeControlModule == v13 or p27.activeControlModule == v9 then
				if not p27.controllers[u7] then
					p27.controllers[u7] = u7.new();
				end;
				p27.touchJumpController = p27.controllers[u7];
				p27.touchJumpController:Enable(true, p27.touchControlFrame);
				if not p27.controllers[u8] then
					p27.controllers[u8] = u8.new();
				end;
				p27.touchRunController = p27.controllers[u8];
				p27.touchRunController:Enable(true, p27.touchControlFrame);
				return;
			end;
			v40 = "touchJumpController";
			v41 = p27;
			v42 = v40;
			v43 = v41[v42];
			v44 = v43;
			if v44 then
				p27.touchJumpController:Enable(false);
			end;
			local v48 = "touchRunController";
			v45 = p27;
			v46 = v48;
			local v49 = v45[v46];
			v47 = v49;
			if v47 then
				p27.touchRunController:Enable(false);
			end;
		else
			v40 = "touchJumpController";
			v41 = p27;
			v42 = v40;
			v43 = v41[v42];
			v44 = v43;
			if v44 then
				p27.touchJumpController:Enable(false);
			end;
			v48 = "touchRunController";
			v45 = p27;
			v46 = v48;
			v49 = v45[v46];
			v47 = v49;
			if v47 then
				p27.touchRunController:Enable(false);
			end;
		end;
	end;
end;
function v1.OnLastInputTypeChanged(p29, p30)
	if u4 == p30 then
		warn("LastInputType Change listener called with current type.");
	end;
	u4 = p30;
	if u4 == Enum.UserInputType.Touch then
		local v50, v51 = p29:SelectTouchModule();
		if v51 then
			while not p29.touchControlFrame do
				wait();			
			end;
			p29:SwitchToController(v50);
			return;
		end;
	elseif u3[u4] ~= nil then
		local v52 = p29:SelectComputerMovementModule();
		if v52 then
			p29:SwitchToController(v52);
		end;
	end;
end;
function v1.OnComputerMovementModeChange(p31)
	local v53, v54 = p31:SelectComputerMovementModule();
	if v54 then
		p31:SwitchToController(v53);
	end;
end;
function v1.OnTouchMovementModeChange(p32)
	local v55, v56 = p32:SelectTouchModule();
	if v56 then
		while not p32.touchControlFrame do
			wait();		
		end;
		p32:SwitchToController(v55);
	end;
end;
function v1.CreateTouchGuiContainer(p33)
	if p33.touchGui then
		p33.touchGui:Destroy();
	end;
	p33.touchGui = Instance.new("ScreenGui");
	p33.touchGui.Name = "TouchGui";
	p33.touchGui.ResetOnSpawn = false;
	p33.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	p33.touchGui.Enabled = p33.humanoid ~= nil;
	p33.touchControlFrame = Instance.new("Frame");
	p33.touchControlFrame.Name = "TouchControlFrame";
	p33.touchControlFrame.Size = UDim2.new(1, 0, 1, 0);
	p33.touchControlFrame.BackgroundTransparency = 1;
	p33.touchControlFrame.Parent = p33.touchGui;
	p33.touchGui.Parent = p33.playerGui;
end;
function v1.GetClickToMoveController(p34)
	if not p34.controllers[v13] then
		p34.controllers[v13] = v13.new(l__Value__2);
	end;
	return p34.controllers[v13];
end;
return v1.new();
