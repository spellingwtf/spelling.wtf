-- Script GUID: {2EE47153-142D-4EFB-ABCD-6ED196A771F6}
-- Decompiled with the Synapse X Luau decompiler.

local function u1(p1, p2)
	local RightAppendage = p1["Right Arm"] or p1.RightHand
	return (RightAppendage.Position - p2).Magnitude;
end;
return function(p3, p4, p5)
	local v1 = RaycastParams.new();
	v1.FilterType = Enum.RaycastFilterType.Blacklist;
	v1.FilterDescendantsInstances = { p3, workspace.Filter, p5, table.unpack(p4.Humanoid:GetAccessories()), workspace.Map };
	local v2 = {};
	local RightAppendage = p3["Right Arm"] or p3.RightHand
	table.insert(v2, { workspace:Raycast(RightAppendage.Position, p3.PrimaryPart.CFrame.LookVector * 10, v1), 0 });
	table.insert(v2, { workspace:Raycast(RightAppendage.Position, (p3.PrimaryPart.CFrame * CFrame.Angles(0, -math.rad(1), 0)).LookVector.Unit * 10, v1), -1 });
	table.insert(v2, { workspace:Raycast(RightAppendage.Position, (p3.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(1), 0)).LookVector.Unit * 10, v1), 1 });
	table.insert(v2, { workspace:Raycast(RightAppendage.Position, (p3.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(2), 0)).LookVector.Unit * 10, v1), 2 });
	table.insert(v2, { workspace:Raycast(RightAppendage.Position, (p3.PrimaryPart.CFrame * CFrame.Angles(0, -math.rad(2), 0)).LookVector.Unit * 10, v1), -2 });
	workspace.Filter:ClearAllChildren();
	local v3 = math.huge;
	local v4 = 0;
	for v5, v6 in pairs(v2) do
		if v6[1] then
			local v7 = u1(p3, v6[1].Position);
			if v7 < v3 then
				v3 = v7;
				v4 = v6[2];
				local l__Position__8 = v6.Position;
			end;
		end;
	end;
	return v4;
end;
