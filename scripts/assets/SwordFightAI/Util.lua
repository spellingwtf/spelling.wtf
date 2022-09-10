-- Script GUID: {B0935656-A6F7-4BF0-8F02-E8D141EA51A9}
-- Decompiled with the Synapse X Luau decompiler.

local Players = game:GetService("Players")


local function getPlayerFromCharacter(character)
	for _, player in pairs(game:GetService("Players"):GetPlayers()) do
		if player.Character == character then
			return player
		end
	end
end

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
		local RightAppendage = p3:FindFirstChild("Right Arm") or p3:FindFirstChild("RightHand")
		return (RightAppendage.Position - p3).Magnitude;
	end, 
	GetClosestEnemy = function(p4)
		local v2 = nil;
		local v3 = math.huge;
		for i, v in pairs(Players:GetChildren()) do
			if v.Character then
				local v5 = v.Character
				if v5 ~= p4 and v5.PrimaryPart ~= nil and v5:FindFirstChildWhichIsA("Humanoid") ~= nil and v.Team ~= getPlayerFromCharacter(p4).Team then
					local l__Magnitude__6 = (v5.PrimaryPart.Position - p4.PrimaryPart.Position).Magnitude;
					if l__Magnitude__6 < v3 then
						v3 = l__Magnitude__6;
						v2 = v5;
					end;
				end;
			end
		end
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
				if v10.Name == "Right Arm" or v10.Name == "RightHand" then
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
		local characters = {}
		for i, v in pairs(Players:GetChildren()) do
			if v.Character and v.Character.PrimaryPart ~= nil then
				table.insert(characters, v)
			end
		end
		v14.FilterDescendantsInstances = characters;
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
		local characters = {}
		for i, v in pairs(Players:GetChildren()) do
			if v.Character and v.Character.PrimaryPart ~= nil then
				table.insert(characters, v)
			end
		end
		v21.FilterDescendantsInstances = characters
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
