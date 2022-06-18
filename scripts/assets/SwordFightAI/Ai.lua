local v1 = {};

local v4 = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/SwordFightAI/FindBestAngle.lua"))()
if typeof(v4) == "table" then
	for v5, v6 in pairs(v4) do
		v1[v5] = v6;
	end;
else
	v1["FindBestAngle"] = v4;
end;

local v4 = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/SwordFightAI/Util.lua"))()
if typeof(v4) == "table" then
	for v5, v6 in pairs(v4) do
		v1[v5] = v6;
	end;
else
	v1["Util"] = v4;
end;

Grips = {
	Up = CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0), 
	Out = CFrame.new(0, 0, -1.70000005, 0, 1, 0, 1, -0, 0, 0, 0, -1)
};
local function u1(p1, p2)
	return math.sqrt((p1.X - p2.X) ^ 2 + (p1.Z - p2.Z) ^ 2);
end;
local function u2(p3, p4)
	return CFrame.lookAt(p3, p4 - Vector3.new(0, p4.Y - p3.Y, 0)) * CFrame.Angles(0, math.rad(17.5), 0);
end;
return function(p5)
	local l__Humanoid__7 = p5.Humanoid;
	local l__PrimaryPart__8 = p5.PrimaryPart;
	local v9 = p5:FindFirstChildOfClass("Tool");
	if not v9 then
		while true do
			v9 = p5:FindFirstChildOfClass("Tool");
			wait();
			if v9 then
				break;
			end;		
		end;
	end;
	local v10 = 0;
	local v11 = 0;
	local v12 = 0;
	local v13 = false;
	while p5.PrimaryPart and l__Humanoid__7.Health > 0 do
		v10 = v10 + game:GetService("RunService").RenderStepped:Wait();
		local v14 = v1.GetClosestEnemy(p5);
		if v14 then
			local v15 = v1.GetClosestPart(v9.Handle.Position, v14);
			local v16 = v14:FindFirstChildOfClass("Tool");
			local v17 = false;
			if v16 and v16.Grip == Grips.Out then
				if v13 == false then
					v12 = v10;
				end;
				v13 = true;
			end;
			if v9.Grip ~= Grips.Out then
				v17 = true;
			end;
			local v18 = v14.Humanoid.Health < p5.Humanoid.Health;
			local v19 = u1(p5.PrimaryPart.Position, v14.PrimaryPart.Position);
			local v20 = v1.GetDistance(p5, v14);
			local v21 = math.abs(v14.PrimaryPart.Position.Y - p5.PrimaryPart.Position.Y) < 3;
			local l__Position__22 = v14.PrimaryPart.Position;
			if v13 and v17 and v21 and v20 > 6 and v16 then
				p5:SetPrimaryPartCFrame(u2(l__PrimaryPart__8.Position, v16.Handle.Position + v14.PrimaryPart.CFrame.LookVector * v16.Handle.Size.Y * 2.2));
			else
				if v9.Parent ~= p5 then
					v9.Equip:FireServer();
				end;
				v9.Parent = p5;
				p5:SetPrimaryPartCFrame(CFrame.lookAt(l__PrimaryPart__8.Position, v15.Position - Vector3.new(0, v15.Position.Y - l__PrimaryPart__8.Position.Y, 0)) * CFrame.Angles(0, math.rad(17.5), 0));
				local v23 = 0;
				local v24 = v23;
				for v25 = 1, 10 do
					v23 = v23 + v1.FindBestAngle(p5, v14, v16);
					if v24 == v23 then
						if v18 then
							local v26 = v23 + math.random(-10, 10);
						else
							v26 = v23 + math.random(-2, 2);
						end;
						p5:SetPrimaryPartCFrame(CFrame.lookAt(l__PrimaryPart__8.Position, v15.Position - Vector3.new(0, v15.Position.Y - l__PrimaryPart__8.Position.Y, 0)) * CFrame.Angles(0, math.rad(17.5 + v26), 0));
						break;
					end;
					v24 = v23;
					p5:SetPrimaryPartCFrame(CFrame.lookAt(l__PrimaryPart__8.Position, v15.Position - Vector3.new(0, v15.Position.Y - l__PrimaryPart__8.Position.Y, 0)) * CFrame.Angles(0, math.rad(17.5 + v23), 0));
				end;
			end;
			local v27 = ((p5.PrimaryPart.Position - v14.PrimaryPart.Position).Unit - v14.Humanoid.MoveDirection).Magnitude < 1;
			if v13 then
				local v28 = 8;
			else
				v28 = 7;
			end;
			if v27 then
				local v29 = 2;
			else
				v29 = 0;
			end;
			local v30 = v28 + v29;
			if v9.Enabled and v9.Grip == Grips.Up then
				v11 = v10;
			end;
			if v16 and not v16.Enabled and v10 - v12 > 0.1 and not (v10 - v12 < 0.2) and v10 - v11 > 0.05 then
				v30 = v30 - 2;
			end;
			if v10 - v11 > 0.5 then
				v30 = v30 + 2;
			end;
			if v19 < 15 then
				v9.Use:FireServer();
			end;
			if v20 > 8 and p5.Humanoid.Health < v14.Humanoid.Health then
				v30 = v30 + 10;
			end;
			local v31 = -v14.PrimaryPart.CFrame.RightVector;
			if v18 and v21 then
				v31 = v31 * 3;
				v30 = 2;
			end;
			if v1.SideCast(v14) or v9.Grip == Grips.Up then
				v31 = Vector3.new(0, 0, 0);
			end;
			local v32 = l__Position__22 - (l__Position__22 - l__PrimaryPart__8.Position).Unit * v30 + v31;
			if v18 then

			end;
			if v20 < v30 then
				if v1.GetRetreatDirection(p5, v14, 10) and v27 then
					l__Humanoid__7:MoveTo((v1.GetRetreatDirection(p5, v14, 100)));
				else
					l__Humanoid__7:MoveTo(v32);
				end;
			else
				l__Humanoid__7:MoveTo(v32);
			end;
		end;	
	end;
end;
