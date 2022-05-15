-- Decompiled with the Synapse X Luau decompiler.

local l__Players__1 = game:GetService("Players");
local v2 = {};
v2.__index = v2;
local l__GameSettings__1 = UserSettings().GameSettings;
function v2.new()
	local v3 = setmetatable({}, v2);
	v3.isMouseLocked = false;
	v3.savedMouseCursor = nil;
	v3.boundKeys = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift };
	v3.mouseLockToggledEvent = Instance.new("BindableEvent");
	local v4 = script:FindFirstChild("BoundKeys");
	if not v4 or not v4:IsA("StringValue") then
		if v4 then
			v4:Destroy();
		end;
		v4 = Instance.new("StringValue");
		v4.Name = "BoundKeys";
		v4.Value = "LeftShift,RightShift";
		v4.Parent = script;
	end;
	if v4 then
		v4.Changed:Connect(function(p1)
			v3:OnBoundKeysObjectChanged(p1);
		end);
		v3:OnBoundKeysObjectChanged(v4.Value);
	end;
	l__GameSettings__1.Changed:Connect(function(p2)
		if p2 == "ControlMode" or p2 == "ComputerMovementMode" then
			v3:UpdateMouseLockAvailability();
		end;
	end);
	l__Players__1.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function()
		v3:UpdateMouseLockAvailability();
	end);
	l__Players__1.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
		v3:UpdateMouseLockAvailability();
	end);
	v3:UpdateMouseLockAvailability();
	return v3;
end;
function v2.GetIsMouseLocked(p3)
	return p3.isMouseLocked;
end;
function v2.GetBindableToggleEvent(p4)
	return p4.mouseLockToggledEvent.Event;
end;
function v2.GetMouseLockOffset(p5)
	local l__CameraOffset__5 = script:FindFirstChild("CameraOffset");
	if l__CameraOffset__5 and l__CameraOffset__5:IsA("Vector3Value") then
		return l__CameraOffset__5.Value;
	end;
	if l__CameraOffset__5 then
		l__CameraOffset__5:Destroy();
	end;
	local v6 = Instance.new("Vector3Value");
	v6.Name = "CameraOffset";
	v6.Value = Vector3.new(1.75, 0, 0);
	v6.Parent = script;
	if v6 and v6.Value then
		return v6.Value;
	end;
	return Vector3.new(1.75, 0, 0);
end;
function v2.UpdateMouseLockAvailability(p6)
	local v7 = l__Players__1.LocalPlayer.DevEnableMouseLock and (l__GameSettings__1.ControlMode == Enum.ControlMode.MouseLockSwitch and (l__GameSettings__1.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove and l__Players__1.LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable));
	if v7 ~= p6.enabled then
		p6:EnableMouseLock(v7);
	end;
end;
function v2.OnBoundKeysObjectChanged(p7, p8)
	p7.boundKeys = {};
	local v8, v9, v10 = string.gmatch(p8, "[^%s,]+");
	while true do
		local v11 = v8(v9, v10);
		if not v11 then
			break;
		end;
		for v12, v13 in pairs(Enum.KeyCode:GetEnumItems()) do
			if v11 == v13.Name then
				p7.boundKeys[#p7.boundKeys + 1] = v13;
				break;
			end;
		end;	
	end;
	p7:UnbindContextActions();
	p7:BindContextActions();
end;
local l__mouse__2 = l__Players__1.LocalPlayer:GetMouse();
function v2.OnMouseLockToggled(p9)
	p9.isMouseLocked = not p9.isMouseLocked;
	if p9.isMouseLocked then
		local l__CursorImage__14 = script:FindFirstChild("CursorImage");
		if l__CursorImage__14 and l__CursorImage__14:IsA("StringValue") and l__CursorImage__14.Value then
			p9.savedMouseCursor = l__mouse__2.Icon;
			l__mouse__2.Icon = l__CursorImage__14.Value;
		else
			if l__CursorImage__14 then
				l__CursorImage__14:Destroy();
			end;
			local v15 = Instance.new("StringValue");
			v15.Name = "CursorImage";
			v15.Value = "rbxasset://textures/MouseLockedCursor.png";
			v15.Parent = script;
			p9.savedMouseCursor = l__mouse__2.Icon;
			l__mouse__2.Icon = "rbxasset://textures/MouseLockedCursor.png";
		end;
	elseif p9.savedMouseCursor then
		l__mouse__2.Icon = p9.savedMouseCursor;
		p9.savedMouseCursor = nil;
	end;
	p9.mouseLockToggledEvent:Fire();
end;
function v2.DoMouseLockSwitch(p10, p11, p12, p13)
	if p12 ~= Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Pass;
	end;
	p10:OnMouseLockToggled();
	return Enum.ContextActionResult.Sink;
end;
local l__ContextActionService__3 = game:GetService("ContextActionService");
local l__Value__4 = Enum.ContextActionPriority.Default.Value;
function v2.BindContextActions(p14)
	l__ContextActionService__3:BindActionAtPriority("MouseLockSwitchAction", function(p15, p16, p17)
		return p14:DoMouseLockSwitch(p15, p16, p17);
	end, false, l__Value__4, unpack(p14.boundKeys));
end;
function v2.UnbindContextActions(p18)
	l__ContextActionService__3:UnbindAction("MouseLockSwitchAction");
end;
function v2.IsMouseLocked(p19)
	return p19.enabled and p19.isMouseLocked;
end;
function v2.EnableMouseLock(p20, p21)
	if p21 ~= p20.enabled then
		p20.enabled = p21;
		if p20.enabled then
			p20:BindContextActions();
			return;
		end;
		if l__mouse__2.Icon ~= "" then
			l__mouse__2.Icon = "";
		end;
		p20:UnbindContextActions();
		if p20.isMouseLocked then
			p20.mouseLockToggledEvent:Fire();
		end;
		p20.isMouseLocked = false;
	end;
end;
return v2;
