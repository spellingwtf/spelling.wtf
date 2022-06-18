-- Script GUID: {B0935656-A6F7-4BF0-8F02-E8D141EA51A9}
-- Decompiled with the Synapse X Luau decompiler.

return {
	VisualizePosition = function(p1)
		local v1 = Instance.new("Part");
		v1.Position = p1;
		v1.CanCollide = false;
		v1.Parent = workspace.Filter;
		v1.Size = Vector3.new(0.1, 0.1, 0.1);
		v1.Anchored = true;
	end, 
	GetDist = function(p2, p3)
		return (p2["Right Arm"].Position - p3).Magnitude;
	end, 
	GetClosestEnemy = function(p4)
		local v2 = nil;
		local v3 = math.huge;
		for v4, v5 in pairs(workspace.ActivePlayers:GetChildren()) do
			if v5 ~= p4 then
				local l__Magnitude__6 = (v5.PrimaryPart.Position - p4.PrimaryPart.Position).Magnitude;
				if l__Magnitude__6 < v3 then
					v3 = l__Magnitude__6;
					v2 = v5;
				end;
			end;
		end;
		return v2;
	end, 
	GetDistance = function(p5, p6)
		return (p5.PrimaryPart.Position - p6.PrimaryPart.Position).Magnitude;
	end, 
	GetClosestPart = function(p7, p8)
		local v7 = nil;
		local v8 = math.huge;
		for v9, v10 in pairs(p8:GetChildren()) do
			if v10:IsA("BasePart") then
				local v11 = Vector3.new(0, 0, 0);
				if v10.Name == "Right Arm" then
					v11 = p8.PrimaryPart.CFrame.LookVector * 3;
				end;
				local l__Magnitude__12 = (p7 - (v10.Position + v11)).Magnitude;
				if l__Magnitude__12 < v8 then
					v8 = l__Magnitude__12;
					v7 = v10;
				end;
			end;
		end;
		return v7;
	end, 
	GetRetreatDirection = function(p9, p10, p11)
		local v13 = p9.PrimaryPart.Position - p10.PrimaryPart.Position;
		local v14 = RaycastParams.new();
		v14.FilterType = Enum.RaycastFilterType.Blacklist;
		v14.FilterDescendantsInstances = { workspace.ActivePlayers };
		local v15 = -135;
		local v16 = 0;
		local v17 = nil;
		for v18 = 1, 10 do
			local v19 = workspace:Raycast(p9.PrimaryPart.Position, (CFrame.lookAt(p9.PrimaryPart.Position, p9.PrimaryPart.Position + v13) * CFrame.Angles(0, math.rad(v15), 0)).LookVector * p11, v14);
			if v19 then
				local l__Magnitude__20 = (v19.Position - p10.PrimaryPart.Position).Magnitude;
				if v16 < l__Magnitude__20 then
					v17 = v19.Position;
					v16 = l__Magnitude__20;
				end;
			end;
			v15 = v15 + 27;
		end;
		return v17;
	end, 
	SideCast = function(p12)
		local v21 = RaycastParams.new();
		v21.FilterType = Enum.RaycastFilterType.Blacklist;
		v21.FilterDescendantsInstances = { workspace.ActivePlayers };
		local v22 = 0;
		for v23 = 1, 10 do
			local v24 = workspace:Raycast(p12.PrimaryPart.Position, (p12.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(v22), 0)).LookVector * 8, v21);
			v22 = v22 + 36;
			if v24 then
				return v24;
			end;
		end;
	end
};
