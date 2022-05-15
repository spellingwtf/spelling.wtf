-- Decompiled with the Synapse X Luau decompiler.

local v1, v2 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserCameraInputRefactor");
end);
local l__ContextActionService__3 = game:GetService("ContextActionService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__UserGameSettings__5 = UserSettings():GetService("UserGameSettings");
local v6 = require(script.Parent:WaitForChild("ZoomController"));
local l__LocalPlayer__7 = game:GetService("Players").LocalPlayer;
local v8 = math.rad(2);
local v9 = Vector2.new(1, 0.77) * math.rad(0.5);
local v10 = Vector2.new(1, 0.66) * math.rad(1);
local v11 = Vector2.new(1, 0.77) * math.rad(4);
local v12 = Instance.new("BindableEvent");
local v13 = Instance.new("BindableEvent");
local u1 = v12;
l__UserInputService__4.InputBegan:Connect(function(p1, p2)
	if not p2 and p1.UserInputType == Enum.UserInputType.MouseButton2 then
		u1:Fire();
	end;
end);
local u2 = v13;
l__UserInputService__4.InputEnded:Connect(function(p3, p4)
	if p3.UserInputType == Enum.UserInputType.MouseButton2 then
		u2:Fire();
	end;
end);
u1 = nil;
u1 = function(p5)
	return math.sign(p5) * math.clamp((math.exp(2 * ((math.abs(p5) - 0.1) / 0.9)) - 1) / (math.exp(2) - 1), 0, 1);
end;
u2 = function(p6)
	local l__CurrentCamera__14 = workspace.CurrentCamera;
	if not l__CurrentCamera__14 then
		return p6;
	end;
	local v15 = l__CurrentCamera__14.CFrame:ToEulerAnglesYXZ();
	if p6.Y * v15 >= 0 then
		return p6;
	end;
	return Vector2.new(1, (1 - (2 * math.abs(v15) / math.pi) ^ 0.75) * 0.75 + 0.25) * p6;
end;
local v16 = {};
local v17 = Instance.new("BindableEvent");
v16.gamepadZoomPress = v17.Event;
function v16.getPanning()
	for v18, v19 in pairs(l__UserInputService__4:GetMouseButtonsPressed()) do
		if v19.UserInputType == Enum.UserInputType.MouseButton2 then
			return true;
		end;
	end;
	return false;
end;
local u3 = {
	Left = 0, 
	Right = 0, 
	I = 0, 
	O = 0
};
local u4 = {
	Thumbstick2 = Vector2.new()
};
local u5 = {
	Movement = Vector2.new(), 
	Wheel = 0, 
	Pan = Vector2.new(), 
	Pinch = 0, 
	MouseButton2 = 0
};
local u6 = {
	Move = Vector2.new(), 
	Pinch = 0
};
function v16.getRotation()
	return Vector2.new(u3.Right - u3.Left, 0) * v8 + u4.Thumbstick2 * v11 + (u5.Movement + u5.Pan) * v9 + u2(u6.Move) * v10;
end;
function v16.getZoomDelta()
	return (u3.O - u3.I) * 0.1 + (-u5.Wheel + u5.Pinch) * 1 + u6.Pinch * 0.04;
end;
local u7 = nil;
local function u8(p7)
	local v20 = l__LocalPlayer__7:FindFirstChildOfClass("PlayerGui");
	local v21 = v20 and v20:FindFirstChild("TouchGui");
	local v22 = v21 and v21:FindFirstChild("TouchControlFrame");
	local v23 = v22 and v22:FindFirstChild("DynamicThumbstickFrame");
	if not v23 then
		return false;
	end;
	if not v21.Enabled then
		return false;
	end;
	local l__AbsolutePosition__24 = v23.AbsolutePosition;
	local v25 = l__AbsolutePosition__24 + v23.AbsoluteSize;
	local v26 = false;
	if l__AbsolutePosition__24.X <= p7.X then
		v26 = false;
		if l__AbsolutePosition__24.Y <= p7.Y then
			v26 = false;
			if p7.X <= v25.X then
				v26 = p7.Y <= v25.Y;
			end;
		end;
	end;
	return v26;
end;
local u9 = {};
local u10 = 0;
local u11 = nil;
local u12 = nil;
local function u13(p8, p9)
	if u7 == nil and u8(p8.Position) then
		u7 = p8;
		return;
	end;
	if u9[p8] == nil and not p9 then
		u10 = u10 + 1;
	end;
	u9[p8] = p9;
end;
local function u14(p10, p11)
	if p10 == u7 then
		return;
	end;
	if u9[p10] == nil then
		u9[p10] = p11;
		if not p11 then
			u10 = u10 + 1;
		end;
	end;
	if u10 == 1 and u9[p10] == false then
		local l__Delta__27 = p10.Delta;
		u6.Move = Vector2.new(l__Delta__27.X, l__Delta__27.Y);
	end;
	if u10 == 2 then
		local v28 = {};
		for v29, v30 in pairs(u9) do
			if not v30 then
				table.insert(v28, v29);
			end;
		end;
		if #v28 == 2 then
			local l__Magnitude__31 = (v28[1].Position - v28[2].Position).Magnitude;
			if u11 and u12 then
				u6.Pinch = u12 / math.clamp(l__Magnitude__31 / math.max(0.01, u11), 0.1, 10) - v6.GetZoomDistance();
				return;
			else
				u11 = l__Magnitude__31;
				u12 = v6.GetZoomDistance();
				return;
			end;
		end;
	else
		u11 = nil;
		u12 = nil;
	end;
end;
local function u15(p12, p13)
	if p12 == u7 then
		u7 = nil;
		return;
	end;
	if u9[p12] == false and u10 == 2 then
		u11 = nil;
		u12 = nil;
	end;
	if u9[p12] == false then
		u10 = u10 - 1;
	end;
	u9[p12] = nil;
end;
local u16 = v1 or v2;
local u17 = false;
local function u18()
	for v32, v33 in pairs({ u4, u3, u5, u6 }) do
		for v34, v35 in pairs(v33) do
			if type(v35) == "boolean" then
				v33[v34] = false;
			else
				v33[v34] = v33[v34] * 0;
			end;
		end;
	end;
end;
local function u19(p14, p15, p16)
	local l__Position__36 = p16.Position;
	u4[p16.KeyCode.Name] = Vector2.new(u1(l__Position__36.X), -u1(l__Position__36.Y));
end;
local l__Value__20 = Enum.ContextActionPriority.Default.Value;
local function u21(p17, p18, p19)
	local l__Delta__37 = p19.Delta;
	u5.Movement = Vector2.new(l__Delta__37.X, l__Delta__37.Y);
	return Enum.ContextActionResult.Pass;
end;
local function u22(p20, p21, p22)
	if _G.InBuilding then
		u3[p22.KeyCode.Name] = 0;
	end;
	if p21 == Enum.UserInputState.Begin then
		local v38 = 1;
	else
		v38 = 0;
	end;
	u3[p22.KeyCode.Name] = v38;
end;
local function u23(p23, p24, p25)
	if p24 == Enum.UserInputState.Begin then
		v17:Fire();
	end;
end;
local u24 = {};
local function u25(p26, p27)
	if p26.UserInputType == Enum.UserInputType.Touch then
		u13(p26, p27);
	end;
end;
local function u26(p28, p29)
	if p28.UserInputType == Enum.UserInputType.Touch then
		u14(p28, p29);
	end;
end;
local function u27(p30, p31)
	if p30.UserInputType == Enum.UserInputType.Touch then
		u15(p30, p31);
	end;
end;
local function u28(p32, p33, p34, p35)
	if not p35 then
		u5.Wheel = p32;
		u5.Pan = p33 * Vector2.new(1, l__UserGameSettings__5:GetCameraYInvertValue());
		u5.Pinch = p34;
	end;
end;
function v16.setInputEnabled(p36)
	assert(u16);
	if u17 == p36 then
		return;
	end;
	u17 = p36;
	if not u17 then
		l__ContextActionService__3:UnbindAction("RbxCameraThumbstick");
		l__ContextActionService__3:UnbindAction("RbxCameraMouseMove");
		l__ContextActionService__3:UnbindAction("RbxCameraMouseWheel");
		l__ContextActionService__3:UnbindAction("RbxCameraKeypress");
		u18();
		for v39, v40 in pairs(u24) do
			v40:Disconnect();
		end;
		u24 = {};
		return;
	end;
	u18();
	l__ContextActionService__3:BindActionAtPriority("RbxCameraThumbstick", u19, false, l__Value__20, Enum.KeyCode.Thumbstick2);
	l__ContextActionService__3:BindActionAtPriority("RbxCameraMouseMove", u21, false, l__Value__20, Enum.UserInputType.MouseMovement);
	l__ContextActionService__3:BindActionAtPriority("RbxCameraKeypress", u22, false, l__Value__20, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O);
	l__ContextActionService__3:BindAction("RbxCameraGamepadZoom", u23, false, Enum.KeyCode.ButtonR3);
	table.insert(u24, l__UserInputService__4.InputBegan:Connect(u25));
	table.insert(u24, l__UserInputService__4.InputChanged:Connect(u26));
	table.insert(u24, l__UserInputService__4.InputEnded:Connect(u27));
	table.insert(u24, l__UserInputService__4.PointerAction:Connect(u28));
end;
function v16.getInputEnabled()
	return u17;
end;
function v16.resetInputForFrameEnd()
	u5.Movement = Vector2.new();
	u6.Move = Vector2.new();
	u5.Wheel = 0;
	u6.Pinch = 0;
end;
l__UserInputService__4.WindowFocused:Connect(u18);
l__UserInputService__4.WindowFocusReleased:Connect(u18);
local u29 = false;
function v16.getHoldPan()
	return u29;
end;
local u30 = false;
function v16.getTogglePan()
	return u30;
end;
function v16.getPanning()
	return u30 or u29;
end;
function v16.setTogglePan(p37)
	u30 = p37;
end;
local u31 = false;
local u32 = nil;
local u33 = nil;
local l__Event__34 = v12.Event;
local u35 = 0;
local l__Event__36 = v13.Event;
function v16.enableCameraToggleInput()
	if u31 then
		return;
	end;
	u31 = true;
	u29 = false;
	u30 = false;
	if u32 then
		u32:Disconnect();
	end;
	if u33 then
		u33:Disconnect();
	end;
	u32 = l__Event__34:Connect(function()
		u29 = true;
		u35 = tick();
	end);
	u33 = l__Event__36:Connect(function()
		u29 = false;
		if tick() - u35 < 0.3 and (u30 or l__UserInputService__4:GetMouseDelta().Magnitude < 2) then
			u30 = not u30;
		end;
	end);
end;
function v16.disableCameraToggleInput()
	if not u31 then
		return;
	end;
	u31 = false;
	if u32 then
		u32:Disconnect();
		u32 = nil;
	end;
	if u33 then
		u33:Disconnect();
		u33 = nil;
	end;
end;
return v16;
