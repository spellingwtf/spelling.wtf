-- Decompiled with the Synapse X Luau decompiler.

local u1 = {
	UpdateQueue = table.create(10)
};
local l__RunService__2 = game:GetService("RunService");
local u3 = Vector3.new(0, 0.1, 0);
function u1.Init(p1, p2)
	u1.Lifetime = p2.Lifetime and 3;
	u1.Direction = p2.Direction or Vector3.new(1, 0, 0);
	u1.Speed = p2.Speed and 6;
	if u1.UpdateConnection then
		u1.UpdateConnection:Disconnect();
		u1.UpdateConnection = nil;
	end;
	for v1, v2 in ipairs(u1.UpdateQueue) do
		v2.Attachment0:Destroy();
		v2.Attachment1:Destroy();
		v2.Trail:Destroy();
	end;
	table.clear(u1.UpdateQueue);
	u1.LastSpawned = os.clock();
	local u4 = 1 / (p2.SpawnRate and 25);
	u1.UpdateConnection = l__RunService__2.Heartbeat:Connect(function()
		local v3 = os.clock();
		if _G.InBuilding or _G.NoWind then
			return;
		end;
		if u4 < v3 - u1.LastSpawned then
			u1:Create();
			u1.LastSpawned = v3;
		end;
		debug.profilebegin("Wind Lines");
		for v4, v5 in ipairs(u1.UpdateQueue) do
			local v6 = v3 - v5.StartClock;
			if v5.Lifetime <= v6 then
				v5.Attachment0:Destroy();
				v5.Attachment1:Destroy();
				v5.Trail:Destroy();
				local v7 = #u1.UpdateQueue;
				u1.UpdateQueue[v4] = u1.UpdateQueue[v7];
				u1.UpdateQueue[v7] = nil;
			else
				v5.Trail.MaxLength = 20 - 20 * (v6 / v5.Lifetime);
				local v8 = (v3 + v5.Seed) * (v5.Speed * 0.2);
				local l__Position__9 = v5.Position;
				v5.Attachment0.WorldPosition = (CFrame.new(l__Position__9, l__Position__9 + v5.Direction) * CFrame.new(0, 0, v5.Speed * -v6)).Position + Vector3.new(math.sin(v8) * 0.5, math.sin(v8) * 0.8, math.sin(v8) * 0.5);
				v5.Attachment1.WorldPosition = v5.Attachment0.WorldPosition + u3;
			end;
		end;
		debug.profileend();
	end);
end;
function u1.Cleanup(p3)
	if u1.UpdateConnection then
		u1.UpdateConnection:Disconnect();
		u1.UpdateConnection = nil;
	end;
	for v10, v11 in ipairs(u1.UpdateQueue) do
		v11.Attachment0:Destroy();
		v11.Attachment1:Destroy();
		v11.Trail:Destroy();
	end;
	table.clear(u1.UpdateQueue);
end;
local u5 = {};
local u6 = workspace:FindFirstChildOfClass("Terrain");
function u1.Create(p4, p5)
	debug.profilebegin("Add Wind Line");
	p5 = p5 or u5;
	local v12 = p5.Position or workspace.CurrentCamera.CFrame * CFrame.Angles(math.rad(math.random(-30, 70)), math.rad(math.random(-80, 80)), 0) * CFrame.new(0, 0, math.random(200, 600) * -0.1).Position;
	local v13 = p5.Speed or u1.Speed;
	if v13 <= 0 then
		return;
	end;
	local v14 = Instance.new("Attachment");
	local v15 = Instance.new("Attachment");
	local v16 = Instance.new("Trail");
	v16.Attachment0 = v14;
	v16.Attachment1 = v15;
	v16.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(0.2, 1), NumberSequenceKeypoint.new(0.8, 1), NumberSequenceKeypoint.new(1, 0.3) });
	v16.Transparency = NumberSequence.new(0.7);
	v16.FaceCamera = true;
	v16.Parent = v14;
	v14.WorldPosition = v12;
	v15.WorldPosition = v12 + u3;
	u1.UpdateQueue[#u1.UpdateQueue + 1] = {
		Attachment0 = v14, 
		Attachment1 = v15, 
		Trail = v16, 
		Lifetime = (p5.Lifetime or u1.Lifetime) + math.random(-10, 10) * 0.1, 
		Position = v12, 
		Direction = p5.Direction or u1.Direction, 
		Speed = v13 + math.random(-10, 10) * 0.1, 
		StartClock = os.clock(), 
		Seed = math.random(1, 1000) * 0.1
	};
	v14.Parent = u6;
	v15.Parent = u6;
	debug.profileend();
end;
return u1;
