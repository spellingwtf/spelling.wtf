-- Decompiled with the Synapse X Luau decompiler.

local u1 = Random.new();
function RandomVectorOffsetBetween(p1, p2, p3)
	return (CFrame.lookAt(Vector3.new(), p1) * CFrame.Angles(0, 0, u1:NextNumber(0, 2 * math.pi)) * CFrame.Angles(math.acos(u1:NextNumber(math.cos(p3), math.cos(p2))), 0, 0)).LookVector;
end;
local v1 = {};
v1.__index = v1;
local u2 = require(script.Parent.LightningBolt);
local u3 = require(script.Parent.LightningSparks);
local l__os_clock__4 = os.clock;
local u5 = {};
function v1.new(p4, p5, p6, p7, p8, p9)
	local v2 = setmetatable({}, v1);
	v2.Size = p5 and 1;
	v2.NumBolts = p6 and 14;
	v2.Color = p7 or ColorSequence.new(Color3.new(1, 0, 0), Color3.new(0, 0, 1));
	v2.BoltColor = p8 or Color3.new(0.3, 0.3, 1);
	v2.UpVector = p9 or Vector3.new(0, 1, 0);
	local v3 = Instance.new("Part");
	v3.Name = "LightningExplosion";
	v3.Anchored = true;
	v3.CanCollide = false;
	v3.Locked = true;
	v3.CastShadow = false;
	v3.Transparency = 1;
	v3.Size = Vector3.new(0.05, 0.05, 0.05);
	v3.CFrame = CFrame.lookAt(p4 + Vector3.new(0, 0.5, 0), p4 + Vector3.new(0, 0.5, 0) + v2.UpVector) * CFrame.lookAt(Vector3.new(), Vector3.new(0, 1, 0)):inverse();
	v3.Parent = workspace.CurrentCamera;
	local v4 = Instance.new("Attachment");
	v4.Parent = v3;
	v4.CFrame = CFrame.new();
	local v5 = game.ReplicatedStorage.Stuff.ExplosionBrightspot:Clone();
	local v6 = game.ReplicatedStorage.Stuff.GlareEmitter:Clone();
	local v7 = game.ReplicatedStorage.Stuff.PlasmaEmitter:Clone();
	local v8 = math.clamp(v2.Size, 0, 1);
	v6.Size = NumberSequence.new(30 * v8);
	v7.Size = NumberSequence.new(18 * v8);
	v7.Speed = NumberRange.new(100 * v8);
	v5.Parent = v4;
	v6.Parent = v4;
	v7.Parent = v4;
	local l__Color__9 = v2.Color;
	if typeof(l__Color__9) == "Color3" then
		v6.Color = ColorSequence.new(l__Color__9);
		v7.Color = ColorSequence.new(l__Color__9);
		local v10, v11, v12 = Color3.toHSV(l__Color__9);
		v5.Color = ColorSequence.new(Color3.fromHSV(v10, 0.5, v12));
	else
		v6.Color = l__Color__9;
		v7.Color = l__Color__9;
		local l__Keypoints__13 = l__Color__9.Keypoints;
		for v14 = 1, #l__Keypoints__13 do
			local v15, v16, v17 = Color3.toHSV(l__Keypoints__13[v14].Value);
			l__Keypoints__13[v14] = ColorSequenceKeypoint.new(l__Keypoints__13[v14].Time, Color3.fromHSV(v15, 0.5, v17));
		end;
		v5.Color = ColorSequence.new(l__Keypoints__13);
	end;
	v5.Enabled = true;
	v6.Enabled = true;
	v7.Enabled = true;
	local v18 = {};
	for v19 = 1, v2.NumBolts do
		local v20 = {};
		local v21 = {};
		v20.WorldPosition = v4.WorldPosition;
		v20.WorldAxis = RandomVectorOffsetBetween(v2.UpVector, math.rad(65), math.rad(80));
		v21.WorldPosition = v4.WorldPosition + v20.WorldAxis * u1:NextNumber(20, 40) * 1.4 * v8;
		v21.WorldAxis = RandomVectorOffsetBetween(-v2.UpVector, math.rad(70), math.rad(110));
		local v22 = u2.new(v20, v21, 10);
		v22.AnimationSpeed = 0;
		v22.Color = v2.BoltColor;
		v22.PulseLength = 0.8;
		v22.ColorOffsetSpeed = 20;
		v22.Frequency = 3;
		v22.MinRadius = 0;
		v22.MaxRadius = 4 * v8;
		v22.FadeLength = 0.4;
		v22.PulseSpeed = 5;
		v22.MinThicknessMultiplier = 0.7;
		v22.MaxThicknessMultiplier = 1;
		local v23 = u3.new(v22);
		v23.MinDistance = 7.5;
		v23.MaxDistance = 10;
		v22.Velocity = (v21.WorldPosition - v20.WorldPosition).Unit * 0.1 * v8;
		v18[#v18 + 1] = v22;
	end;
	v2.Bolts = v18;
	v2.Attachment = v4;
	v2.Part = v3;
	v2.StartT = l__os_clock__4();
	v2.RefIndex = #u5 + 1;
	u5[v2.RefIndex] = v2;
	return v2;
end;
function v1.Destroy(p10)
	u5[p10.RefIndex] = nil;
	p10.Part:Destroy();
	for v24 = 1, #p10.Bolts do
		p10.Bolts[v24] = nil;
	end;
	p10 = nil;
end;
game:GetService("RunService").Heartbeat:Connect(function()
	for v25, v26 in pairs(u5) do
		local v27 = l__os_clock__4() - v26.StartT;
		local l__Attachment__28 = v26.Attachment;
		if v27 < 0.7 then
			if v27 > 0.2 then
				l__Attachment__28.ExplosionBrightspot.Enabled = false;
				l__Attachment__28.GlareEmitter.Enabled = false;
				l__Attachment__28.PlasmaEmitter.Enabled = false;
			end;
			for v29 = 1, #v26.Bolts do
				local v30 = v26.Bolts[v29];
				v30.Attachment1.WorldPosition = v30.Attachment1.WorldPosition + v30.Velocity;
			end;
		else
			v26:Destroy();
		end;
	end;
end);
return v1;
