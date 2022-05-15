-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
v1.__index = v1;
local v2 = require(script.CameraShakeInstance);
v1.CameraShakeInstance = v2;
v1.Presets = require(script.CameraShakePresets);
local u1 = Vector3.new();
function v1.new(p1, p2)
	assert(type(p1) == "number", "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)");
	assert(type(p2) == "function", "Callback must be a function");
	return setmetatable({
		_running = false, 
		_renderName = "CameraShaker", 
		_renderPriority = p1, 
		_posAddShake = u1, 
		_rotAddShake = u1, 
		_camShakeInstances = {}, 
		_removeInstances = {}, 
		_callback = p2
	}, v1);
end;
local l__debug_profilebegin__2 = debug.profilebegin;
local l__debug_profileend__3 = debug.profileend;
function v1.Start(p3)
	if p3._running then
		return;
	end;
	p3._running = true;
	local l___callback__4 = p3._callback;
	game:GetService("RunService"):BindToRenderStep(p3._renderName, p3._renderPriority, function(p4)
		l__debug_profilebegin__2("CameraShakerUpdate");
		local v3 = p3:Update(p4);
		l__debug_profileend__3();
		l___callback__4(v3);
	end);
end;
function v1.Stop(p5)
	if not p5._running then
		return;
	end;
	game:GetService("RunService"):UnbindFromRenderStep(p5._renderName);
	p5._running = false;
end;
local l__CameraShakeState__5 = v2.CameraShakeState;
local l__CFrame_new__6 = CFrame.new;
local l__CFrame_Angles__7 = CFrame.Angles;
local l__math_rad__8 = math.rad;
function v1.Update(p6, p7)
	local v4 = u1;
	local v5 = u1;
	local l___camShakeInstances__6 = p6._camShakeInstances;
	for v7 = 1, #l___camShakeInstances__6 do
		local v8 = l___camShakeInstances__6[v7];
		local v9 = v8:GetState();
		if v9 == l__CameraShakeState__5.Inactive and v8.DeleteOnInactive then
			p6._removeInstances[#p6._removeInstances + 1] = v7;
		elseif v9 ~= l__CameraShakeState__5.Inactive then
			v4 = v4 + v8:UpdateShake(p7) * v8.PositionInfluence;
			v5 = v5 + v8:UpdateShake(p7) * v8.RotationInfluence;
		end;
	end;
	for v10 = #p6._removeInstances, 1, -1 do
		table.remove(l___camShakeInstances__6, p6._removeInstances[v10]);
		p6._removeInstances[v10] = nil;
	end;
	return l__CFrame_new__6(v4) * l__CFrame_Angles__7(0, l__math_rad__8(v5.Y), 0) * l__CFrame_Angles__7(l__math_rad__8(v5.X), 0, l__math_rad__8(v5.Z));
end;
function v1.Shake(p8, p9)
	local v11 = false;
	if type(p9) == "table" then
		v11 = p9._camShakeInstance;
	end;
	assert(v11, "ShakeInstance must be of type CameraShakeInstance");
	p8._camShakeInstances[#p8._camShakeInstances + 1] = p9;
	return p9;
end;
function v1.ShakeSustain(p10, p11)
	local v12 = false;
	if type(p11) == "table" then
		v12 = p11._camShakeInstance;
	end;
	assert(v12, "ShakeInstance must be of type CameraShakeInstance");
	p10._camShakeInstances[#p10._camShakeInstances + 1] = p11;
	p11:StartFadeIn(p11.fadeInDuration);
	return p11;
end;
local u9 = Vector3.new(0.15, 0.15, 0.15);
local u10 = Vector3.new(1, 1, 1);
function v1.ShakeOnce(p12, p13, p14, p15, p16, p17, p18)
	local v13 = v2.new(p13, p14, p15, p16);
	v13.PositionInfluence = typeof(p17) == "Vector3" and p17 or u9;
	v13.RotationInfluence = typeof(p18) == "Vector3" and p18 or u10;
	p12._camShakeInstances[#p12._camShakeInstances + 1] = v13;
	return v13;
end;
function v1.StartShake(p19, p20, p21, p22, p23, p24)
	local v14 = v2.new(p20, p21, p22);
	v14.PositionInfluence = typeof(p23) == "Vector3" and p23 or u9;
	v14.RotationInfluence = typeof(p24) == "Vector3" and p24 or u10;
	v14:StartFadeIn(p22);
	p19._camShakeInstances[#p19._camShakeInstances + 1] = v14;
	return v14;
end;
function v1.Destroy(p25)
	p25:Stop();
	p25 = nil;
end;
return v1;
