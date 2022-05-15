-- Decompiled with the Synapse X Luau decompiler.

local l__Players__1 = game:GetService("Players");
local l__CurrentCamera__1 = game.Workspace.CurrentCamera;
local l__math_rad__2 = math.rad;
local u3 = nil;
local l__math_tan__4 = math.tan;
local u5 = nil;
local function v2()
	local l__ViewportSize__3 = l__CurrentCamera__1.ViewportSize;
	u3 = 2 * l__math_tan__4(l__math_rad__2(l__CurrentCamera__1.FieldOfView) / 2);
	u5 = l__ViewportSize__3.X / l__ViewportSize__3.Y * u3;
end;
l__CurrentCamera__1:GetPropertyChangedSignal("FieldOfView"):Connect(v2);
l__CurrentCamera__1:GetPropertyChangedSignal("ViewportSize"):Connect(v2);
v2();
local u6 = l__CurrentCamera__1.NearPlaneZ;
l__CurrentCamera__1:GetPropertyChangedSignal("NearPlaneZ"):Connect(function()
	u6 = l__CurrentCamera__1.NearPlaneZ;
end);
local u7 = {};
local u8 = {};
local u9 = function()
	local v4 = 1;
	u7 = {};
	for v5, v6 in pairs(u8) do
		u7[v4] = v6;
		v4 = v4 + 1;
	end;
end;
local function v7(p1)
	local function v8(p2)
		u8[p1] = p2;
		u9();
	end;
	p1.CharacterAdded:Connect(v8);
	p1.CharacterRemoving:Connect(function()
		u8[p1] = nil;
		u9();
	end);
	if p1.Character then
		v8(p1.Character);
	end;
end;
l__Players__1.PlayerAdded:Connect(v7);
l__Players__1.PlayerRemoving:Connect(function(p3)
	u8[p3] = nil;
	u9();
end);
for v9, v10 in ipairs(l__Players__1:GetPlayers()) do
	v7(v10);
end;
u9();
u8 = nil;
u9 = nil;
l__CurrentCamera__1:GetPropertyChangedSignal("CameraSubject"):Connect(function()
	local l__CameraSubject__11 = l__CurrentCamera__1.CameraSubject;
	if l__CameraSubject__11:IsA("Humanoid") then
		u9 = l__CameraSubject__11.RootPart;
		return;
	end;
	if l__CameraSubject__11:IsA("BasePart") then
		u9 = l__CameraSubject__11;
		return;
	end;
	u9 = nil;
end);
local function u10(p4)
	return 1 - (1 - p4.Transparency) * (1 - p4.LocalTransparencyModifier);
end;
local l__Ray_new__11 = Ray.new;
local function u12(p5, p6)
	for v12 = #p5, p6 + 1, -1 do
		p5[v12] = nil;
	end;
end;
local l__math_huge__13 = math.huge;
local function u14(p7)
	local v13 = false;
	if u10(p7) < 0.25 then
		v13 = p7.CanCollide;
		if v13 then
			v13 = false;
			if u8 ~= (p7:GetRootPart() and p7) then
				v13 = not p7:IsA("TrussPart");
			end;
		end;
	end;
	return v13;
end;
local function u15(p8, p9, p10, p11)
	debug.profilebegin("queryPoint");
	p10 = p10 + u6;
	local v14 = p8 + p9 * p10;
	local v15 = l__math_huge__13;
	local v16 = l__math_huge__13;
	local v17 = p8;
	while true do
		local v18, v19 = workspace:FindPartOnRayWithIgnoreList(l__Ray_new__11(v17, v14 - v17), u7, false, true);
		if v18 then
			if u14(v18) then
				local v20 = { v18 };
				local l__Magnitude__21 = (v19 - p8).Magnitude;
				if workspace:FindPartOnRayWithWhitelist(l__Ray_new__11(v14, v19 - v14), v20, true) then
					local v22 = false;
					if p11 then
						v22 = workspace:FindPartOnRayWithWhitelist(l__Ray_new__11(p11, v14 - p11), v20, true) or workspace:FindPartOnRayWithWhitelist(l__Ray_new__11(v14, p11 - v14), v20, true);
					end;
					if v22 then
						v16 = l__Magnitude__21;
					elseif p10 < v15 then
						v15 = l__Magnitude__21;
					end;
				else
					v16 = l__Magnitude__21;
				end;
			end;
			u7[#u7 + 1] = v18;
			v17 = v19 - p9 * 0.001;
		end;
		if v16 < l__math_huge__13 then
			break;
		end;
		if not v18 then
			break;
		end;	
	end;
	u12(u7, #u7);
	debug.profileend();
	return v15 - u6, v16 - u6;
end;
local function u16(p12, p13)
	local v23 = #u7;
	while true do
		local v24, v25 = workspace:FindPartOnRayWithIgnoreList(l__Ray_new__11(p12, p13), u7, false, true);
		if v24 then
			if v24.CanCollide then
				u12(u7, v23);
				return v25, true;
			end;
			u7[#u7 + 1] = v24;
		end;
		if not v24 then
			break;
		end;	
	end;
	u12(u7, v23);
	return p12 + p13, false;
end;
local l__math_min__17 = math.min;
local u18 = { Vector2.new(0.4, 0), Vector2.new(-0.4, 0), Vector2.new(0, -0.4), Vector2.new(0, 0.4), Vector2.new(0, 0.2) };
local function u19(p14, p15)
	debug.profilebegin("queryViewport");
	local l__p__26 = p14.p;
	local l__rightVector__27 = p14.rightVector;
	local l__upVector__28 = p14.upVector;
	local v29 = -p14.lookVector;
	local l__ViewportSize__30 = l__CurrentCamera__1.ViewportSize;
	local v31 = l__math_huge__13;
	local v32 = l__math_huge__13;
	for v33 = 0, 1 do
		local v34 = l__rightVector__27 * ((v33 - 0.5) * u5);
		for v35 = 0, 1 do
			local v36, v37 = u15(l__p__26 + u6 * (v34 + l__upVector__28 * ((v35 - 0.5) * u3)), v29, p15, l__CurrentCamera__1:ViewportPointToRay(l__ViewportSize__30.x * v33, l__ViewportSize__30.y * v35).Origin);
			if v37 < v31 then
				v31 = v37;
			end;
			if v36 < v32 then
				v32 = v36;
			end;
		end;
	end;
	debug.profileend();
	return v32, v31;
end;
local function u20(p16, p17, p18)
	debug.profilebegin("testPromotion");
	local l__p__38 = p16.p;
	local l__rightVector__39 = p16.rightVector;
	local l__upVector__40 = p16.upVector;
	local v41 = -p16.lookVector;
	debug.profilebegin("extrapolate");
	for v42 = 0, l__math_min__17(1.25, p18.rotVelocity.magnitude + (u16(l__p__38, p18.posVelocity * 1.25) - l__p__38).Magnitude / p18.posVelocity.magnitude), 0.0625 do
		local v43 = p18.extrapolate(v42);
		if p17 <= u15(v43.p, -v43.lookVector, p17) then
			return false;
		end;
	end;
	debug.profileend();
	debug.profilebegin("testOffsets");
	for v44, v45 in ipairs(u18) do
		local v46 = u16(l__p__38, l__rightVector__39 * v45.x + l__upVector__40 * v45.y);
		if u15(v46, (l__p__38 + v41 * p17 - v46).Unit, p17) == l__math_huge__13 then
			return false;
		end;
	end;
	debug.profileend();
	debug.profileend();
	return true;
end;
return function(p19, p20, p21)
	debug.profilebegin("popper");
	u8 = u9 and u9:GetRootPart() or u9;
	local v47 = p20;
	local v48, v49 = u19(p19, p20);
	if v49 < v47 then
		v47 = v49;
	end;
	if v48 < v47 and u20(p19, p20, p21) then
		v47 = v48;
	end;
	u8 = nil;
	debug.profileend();
	return v47;
end;
