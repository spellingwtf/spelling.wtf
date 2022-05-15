-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = l__Utilities__1.Class({
		ClassName = "Menu"
	}, function(p2, p3, p4)
		p2.CapsuleType = p3.Capsule;
		p2.Doodle = p3;
		p2.Model = (p1.Services.Storage.Capsules:FindFirstChild(p2.CapsuleType) or p1.Services.Storage.Capsules:FindFirstChild("Basic")):Clone();
		p2.GuiBrick = p2.Model.Enclosed;
		if p3.Name or p3.SpecialCase then
			p2.GuiBrick.Back.DoodleLabel.ImageRectOffset = Vector2.new(300, 0);
			p1.Gui:AnimateSprite(p2.GuiBrick.Back.DoodleLabel, p2.Doodle, true, nil, true);
			p1.Gui:AnimateSprite(p2.GuiBrick.Front.DoodleLabel, p2.Doodle, true, nil, nil);
		end;
		if p4 then
			p2.Model:SetPrimaryPartCFrame(p4.CFrame);
			local v3 = l__Utilities__1:Create("Attachment")({
				Parent = p2.Model.Bottom
			});
			local v4 = l__Utilities__1:Create("Attachment")({
				Parent = p4, 
				Name = "GoalPart", 
				Position = Vector3.new(0, 0, 0)
			});
		end;
		p2.CFrameUpdate = p2.Model.CFrameObject.Changed:Connect(function(p5)
			p2.Model:SetPrimaryPartCFrame(p5);
		end);
		p2:Spin();
		p2.Model.Bottom.Anchored = true;
		if p4 == nil then
			for v5, v6 in pairs(p2.Model:GetDescendants()) do
				if v6:IsA("BasePart") then
					v6.Anchored = false;
				end;
			end;
		end;
		p2.Model.Parent = p1.Fodder;
		return p2;
	end);
	function v2.SetCFrame(p6, p7)
		p6.Model.CFrameObject.Value = p7;
	end;
	function v2.SetParent(p8, p9)
		p8.Model.Parent = p9;
	end;
	function v2.Spin(p10)
		l__Utilities__1.FastSpawn(function()
			local v7 = math.random(5, 8);
			while p10 and p10.Model:FindFirstChild("Enclosed") and p10.Model.Enclosed:FindFirstChild("Weld") do
				p10.Model.Enclosed:FindFirstChild("Weld").C1 = p10.Model.Enclosed:FindFirstChild("Weld").C1 * CFrame.Angles(0, math.rad(v7), 0);
				l__Utilities__1.Halt(0.025);			
			end;
		end);
	end;
	function v2.Destroy(p11)
		p11.Model:Destroy();
		setmetatable(p11, nil);
	end;
	return v2;
end;
