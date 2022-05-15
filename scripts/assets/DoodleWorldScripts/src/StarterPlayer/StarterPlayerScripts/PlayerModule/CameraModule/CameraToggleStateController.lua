-- Decompiled with the Synapse X Luau decompiler.

local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__UserGameSettings__3 = UserSettings():GetService("UserGameSettings");
local v4 = l__Players__1.LocalPlayer;
if not v4 then
	l__Players__1:GetPropertyChangedSignal("LocalPlayer"):Wait();
	v4 = l__Players__1.LocalPlayer;
end;
local l__mouse__5 = v4:GetMouse();
local v6 = require(script.Parent:WaitForChild("CameraInput"));
local v7 = require(script.Parent:WaitForChild("CameraUI"));
local v8 = tick();
v7.setCameraModeToastEnabled(false);
local u1 = false;
local u2 = false;
local u3 = v8;
local u4 = false;
local u5 = false;
return function(p1)
	local v9 = v6.getTogglePan();
	if p1 and v9 ~= u1 then
		u2 = true;
	end;
	if u1 ~= v9 or tick() - u3 > 3 then
		local v10 = v9 and tick() - u3 < 3;
		v7.setCameraModeToastOpen(v10);
		if v9 then
			u2 = false;
		end;
		u3 = tick();
		u1 = v9;
	end;
	if p1 ~= u4 then
		if p1 then
			u5 = v6.getTogglePan();
			v6.setTogglePan(true);
		elseif not u2 then
			v6.setTogglePan(u5);
		end;
	end;
	if p1 then
		if v6.getTogglePan() then
			l__mouse__5.Icon = "rbxasset://textures/Cursors/CrossMouseIcon.png";
			l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.LockCenter;
			l__UserGameSettings__3.RotationType = Enum.RotationType.CameraRelative;
		else
			l__mouse__5.Icon = "";
			l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.Default;
			l__UserGameSettings__3.RotationType = Enum.RotationType.CameraRelative;
		end;
	elseif v6.getTogglePan() then
		l__mouse__5.Icon = "rbxasset://textures/Cursors/CrossMouseIcon.png";
		l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.LockCenter;
		l__UserGameSettings__3.RotationType = Enum.RotationType.MovementRelative;
	elseif v6.getHoldPan() then
		l__mouse__5.Icon = "";
		l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition;
		l__UserGameSettings__3.RotationType = Enum.RotationType.MovementRelative;
	else
		l__mouse__5.Icon = "";
		l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.Default;
		l__UserGameSettings__3.RotationType = Enum.RotationType.MovementRelative;
	end;
	u4 = p1;
end;
