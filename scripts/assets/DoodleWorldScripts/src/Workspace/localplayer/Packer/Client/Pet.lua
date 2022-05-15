-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local v2 = l__Utilities__1.Class({
		ClassName = "Pet"
	}, function(p2)
		if p1.Settings:Get("DoodleFollow") == "Off" then
			return;
		end;
		p2.Character = p2.Player.Character or p2.Player.CharacterAdded:Wait();
		p2.Character.Humanoid.Died:Connect(function()
			p2:Destroy();
		end);
		p2.MoveDirection = Vector3.new(0, 0, 0);
		if not u1[p2.Player] then
			u1[p2.Player] = p2.Player.CharacterAdded:Connect(function(p3)
				p2.Character = p3;
				p2.Character:WaitForChild("HumanoidRootPart");
				p2.HRP = p2.Character.HumanoidRootPart;
				p2:Create();
			end);
		end;
		p2.HRP = p2.Character.HumanoidRootPart;
		p2:Create();
		return p2;
	end);
	function v2.Update(p4, p5)
		p4.Doodle = p5;
		p4:Create();
	end;
	local u2 = {};
	function v2.Destroy(p6)
		if u2[p6.Player] then
			u2[p6.Player]:Destroy();
		end;
	end;
	function v2.ActualDestroy(p7)
		p7:Destroy();
		setmetatable(p7, nil);
	end;
	function v2.DestroyAll(p8)
		for v3, v4 in pairs(u2) do
			v4:Destroy();
		end;
	end;
	function v2.Create(p9)
		p9:Destroy();
		if p1.Settings:Get("DoodleFollow") == "Off" then
			return;
		end;
		if not p9.HRP then
			p9.Character = p9.Player.Character or p9.Player.CharacterAdded:wait();
			p9.HRP = p9.Character.HumanoidRootPart;
		end;
		local v5 = p1.DoodleInfo[p9.Doodle.RealName or p9.Doodle.Name];
		local v6 = math.max(3.77, (v5.ExceptionHeight or v5.Height) / 11) * p9.Doodle.Size;
		local l__Flying__7 = p1.DoodleInfo[p9.Doodle.RealName or p9.Doodle.Name].Flying;
		local l__Floating__8 = p1.DoodleInfo[p9.Doodle.RealName or p9.Doodle.Name].Floating;
		if (not l__Flying__7 or not Vector3.new(0, 5, 0)) and (not l__Floating__8 or not Vector3.new(0, 2.5, 0)) then
			local v9 = Vector3.new(0, 0, 0);
		end;
		if not p9.Player.Character then
			local v10 = p9.Player.CharacterAdded:wait();
		end;
		local v11 = l__Utilities__1:Create("Part")({
			Name = p9.Doodle.Name, 
			Size = Vector3.new(1E-05, v6, v6), 
			CanCollide = false, 
			Transparency = 1, 
			Position = p9.HRP.Position, 
			Massless = true, 
			CanTouch = false
		});
		local v12 = l__Utilities__1:Create("Attachment")({
			Parent = v11
		});
		local v13 = l__Utilities__1:Create("Attachment")({
			Parent = p9.HRP, 
			Name = "GoalPart", 
			Position = Vector3.new(0, 0, 0)
		});
		local v14 = l__Utilities__1:Create("AlignPosition")({
			Attachment0 = v12, 
			Attachment1 = v13, 
			MaxForce = 2500, 
			Parent = v11
		});
		local v15 = l__Utilities__1:Create("AlignOrientation")({
			Parent = v11, 
			Name = "RotatePet", 
			Attachment0 = v12, 
			Attachment1 = v13, 
			MaxTorque = 0, 
			Responsiveness = 5
		});
		for v16, v17 in pairs(p1.GuiObjs.Follow:GetChildren()) do
			v17:Clone().Parent = v11;
		end;
		local v18 = Instance.new("IntValue");
		v18.Name = "Follower";
		v18.Parent = v11;
		v11.Parent = p9.Player.Character;
		p1.Gui:AnimateSprite(v11.RightLabel.DoodleLabel, p9.Doodle, true, nil, true);
		p1.Gui:AnimateSprite(v11.LeftLabel.DoodleLabel, p9.Doodle, true, nil, nil);
		if l__Flying__7 or l__Floating__8 then
			v11.RightLabel.DropShadow:Destroy();
			v11.LeftLabel.DropShadow:Destroy();
		end;
		u2[p9.Player] = v11;
		if l__Flying__7 then
			local v19 = 5;
		elseif l__Floating__8 then
			v19 = 2.5;
		else
			v19 = false;
		end;
		if l__Flying__7 then
			local v20 = 7;
		elseif l__Floating__8 then
			v20 = 5;
		else
			v20 = false;
		end;
		if l__Flying__7 then
			local v21 = 5;
		elseif l__Floating__8 then
			v21 = 2.5;
		else
			v21 = false;
		end;
		local u3 = v21;
		local u4 = true;
		local u5 = nil;
		l__Utilities__1.FastSpawn(function()
			while p9.Player:IsDescendantOf(game) and p9.Player.Character and p9.Player.Character:FindFirstChild("Humanoid") and v11:IsDescendantOf(game) do
				local v22 = l__Utilities__1.FindFloorRecurse(l__Utilities__1.GetBehind(p9.Character, 3 + v6 / 1.5).p, { p9.Character, workspace.Terrain });
				local v23 = l__Utilities__1.FindFloorRecurse(p9.HRP.CFrame.p, { p9.Character });
				if p1.Settings:Get("DoodleFollow") ~= "Rotate" then
					v15.Mode = Enum.OrientationAlignmentMode.TwoAttachment;
					v15.MaxTorque = 5000;
				elseif v15.Mode ~= Enum.OrientationAlignmentMode.OneAttachment then
					v15.Mode = Enum.OrientationAlignmentMode.OneAttachment;
					v15.MaxTorque = 0;
				end;
				if p9.Character.Humanoid.MoveDirection.X ~= 0 then
					p9.MoveDirection = p9.Character.Humanoid.MoveDirection;
				end;
				if v22 and v23 and p9.Player.Character.Humanoid:GetState() == Enum.HumanoidStateType.Running then
					local v24 = Vector3.new(0, 0, 0);
					if u3 then
						if u4 then
							u3 = u3 + math.random(10, 18) / 100;
						else
							u3 = u3 - math.random(10, 18) / 100;
						end;
						v24 = Vector3.new(0, u3, 0);
						if u3 <= v19 then
							u4 = true;
						elseif v20 <= u3 then
							u4 = false;
						end;
					end;
					v13.WorldPosition = Vector3.new(v22.X, v23.Y, v22.Z) + Vector3.new(0, v11.Size.Y / 2, 0) + v24;
				end;
				if p1.Settings:Get("DoodleFollow") == "Rotate" then
					local l__p__25 = p1.Camera:GetCF().p;
					local v26 = CFrame.new(v11.Position, Vector3.new(l__p__25.X, v11.Position.Y, l__p__25.Z));
					local v27 = (l__p__25 - v26.lookVector * -1).magnitude <= (l__p__25 - v26.lookVector).magnitude;
					local v28 = (l__p__25 - v26.rightVector).magnitude <= (l__p__25 - v26.rightVector * -1).magnitude;
					local v29 = math.acos((p9.HRP.CFrame.LookVector * -1):Dot((l__p__25 - p9.HRP.Position).unit));
					if not u5 or not (math.deg(v29) <= 45) and not (math.deg(v29) >= 135) then
						if not v27 and v28 then
							u5 = 90;
							if p9.MoveDirection.Z > 0 then
								u5 = -90;
							end;
						elseif not v27 and not v28 then
							u5 = 90;
							if p9.MoveDirection.X < 0 then
								u5 = -90;
							end;
						elseif v27 and not v28 then
							u5 = -90;
							if p9.MoveDirection.Z > 0 then
								u5 = 90;
							end;
						elseif v27 and v28 then
							u5 = -90;
							if p9.MoveDirection.X < 0 then
								u5 = 90;
							end;
						end;
					end;
					local v30, v31, v32 = (v26 * CFrame.Angles(0, math.rad(u5), 0)):ToOrientation();
					v15.CFrame = CFrame.fromOrientation(v30, v31, v32) + v11.Position;
					v11.CFrame = CFrame.fromOrientation(v30, v31, v32) + v11.Position;
				end;
				l__Utilities__1.Halt(0.05);			
			end;
		end);
	end;
	game.Players.PlayerRemoving:Connect(function(p10)
		if u1[p10] then
			u1[p10]:Disconnect();
		end;
	end);
	return v2;
end;
