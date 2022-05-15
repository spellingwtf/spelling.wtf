-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {};
	local v2 = require(script.Rain);
	local v3 = require(script.LightningSparks);
	local v4 = require(script.LightningExplosion);
	local l__Utilities__1 = p1.Utilities;
	local u2 = {};
	local u3 = {};
	local v5 = Instance.new("Attachment");
	v5.Parent = workspace.Terrain;
	local v6 = v5:Clone();
	v6.Parent = workspace.Terrain;
	local u4 = nil;
	local u5 = nil;
	function v1.RandomBoltSpot(p2)
		if u4 then
			return;
		end;
		u4 = true;
		l__Utilities__1.FastSpawn(function()
			while p1.StoryWeather == "ThunderousRain" and u4 do
				local v7 = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:wait();
				l__Utilities__1.Halt(6);
				if u5 and not p1.InCutscene and not _G.InBuilding and not p1.InEvo and v7:FindFirstChild("HumanoidRootPart") then
					if math.random(1, 2) == 1 then
						local v8 = 1;
					else
						v8 = -1;
					end;
					if math.random(1, 2) == 1 then
						local v9 = 1;
					else
						v9 = -1;
					end;
					local v10 = l__Utilities__1.FindFloor(CFrame.new(v7.HumanoidRootPart.Position + Vector3.new(math.random(10, 30) * v8, 0, math.random(10, 30) * v9)), {});
					if v10 then
						p2:CreateLightningBolt(v10, true);
					end;
				end;			
			end;
			u4 = false;
		end);
	end;
	function v1.GetWeather(p3)
		if u5 and not _G.InBuilding then
			return "Rain";
		end;
		return nil;
	end;
	local u6 = require(script.LightningBolt);
	local u7 = 20 * math.tan(math.pi / 6) * 4 / 3;
	function v1.CreateLightningBolt(p4, p5, p6)
		v5.WorldPosition = p5;
		v6.WorldPosition = v5.WorldPosition + Vector3.new(0, 100, 0);
		local v11 = u6.new(v6, v5, 16);
		v11.CurveSize0 = u7;
		v11.CurveSize1 = u7;
		v11.Color = Color3.fromRGB(0, 85, 255);
		v11.AnimationSpeed = 5;
		v11.Thickness = 1;
		v11.MaxRadius = 3.4;
		v11.MinThicknessMultiplier = 1;
		v11.MaxThicknessMultiplier = 1;
		v11.ColorOffsetSpeed = 4;
		v11.Frequency = 0.6;
		v11.PulseSpeed = 2;
		if p6 == nil then
			p1.Sound:PlayId(2890763474, 1, 3);
		end;
		l__Utilities__1.Halt(0.5);
		local v12 = v3.new(v11, 40);
		v12.MinSpeed = 4;
		v12.MaxSpeed = 9;
		v12.MinDistance = 3;
		v12.MaxDistance = 6;
		v12.MinPartsPerSpark = 9;
		v12.MaxPartsPerSpark = 11;
		local v13 = v4.new(v5.WorldPosition, 0.01, nil, Color3.fromRGB(0, 85, 255), Color3.fromRGB(0, 85, 255));
		l__Utilities__1.Halt(0.5);
		v12:Destroy();
		v11:Destroy();
		v13:Destroy();
	end;
	function v1.RainStop(p7)
		l__Utilities__1.FastSpawn(function()
			u5 = false;
			v2:Disable();
		end);
	end;
	function v1.Rain(p8)
		l__Utilities__1.FastSpawn(function()
			u5 = true;
			v2:Enable();
			v2:SetSpeedRatio(1);
			v2:SetCollisionMode(v2.CollisionMode.Function, function(p9)
				if p9.Name == "!Border" or p9.Name == "Hill" then
					return false;
				end;
				if p9.Transparency == 1 then
					return false;
				end;
				return true;
			end);
		end);
	end;
	function v1.Cloudy(p10, p11)
		if p11 == true then
			game.ReplicatedStorage.RainClouds:Clone().Parent = game.Lighting;
		end;
	end;
	local u8 = nil;
	local l__Network__9 = p1.Network;
	local function u10()
		local v14 = p1.ClientDatabase:PDSFunc("GetCurrentLeads");
		for v15, v16 in pairs(game.Players:GetPlayers()) do
			l__Utilities__1.FastSpawn(function()
				if v14[v16.Name] and not p1.InCutscene and not _G.InBuilding then
					u2[v16.Name] = v14[v16.Name];
					if not u3[v16.Name] then
						u3[v16.Name] = p1.Pet.new({
							Doodle = v14[v16.Name], 
							Player = v16
						});
						return;
					end;
					if u3[v16.Name] and u3[v16.Name].Update then
						u3[v16.Name]:Update(v14[v16.Name]);
					end;
				end;
			end);
		end;
	end;
	function v1.Start(p12)
		u8 = p1.Settings:Get("DoodleFollow");
		l__Network__9:BindEvent("UpdateLead", function(p13)
			for v17, v18 in pairs(game.Players:GetPlayers()) do
				if p13[v18.Name] and (p13[v18.Name].Name ~= nil and not p1.InCutscene) and not _G.InBuilding and (not u2[v18.Name] or p13[v18.Name].ID ~= u2[v18.Name].ID or p13[v18.Name].Name ~= u2[v18.Name].Name or p13[v18.Name].Skin ~= u2[v18.Name].Skin) then
					u2[v18.Name] = p13[v18.Name];
					if not u3[v18.Name] then
						u3[v18.Name] = p1.Pet.new({
							Doodle = p13[v18.Name], 
							Player = v18
						});
					elseif u3[v18.Name] and u3[v18.Name].Update then
						u3[v18.Name]:Update(p13[v18.Name]);
					end;
				end;
			end;
		end);
		u10();
	end;
	function v1.Toggle(p14)
		u8 = p1.Settings:Get("DoodleFollow");
		if u8 ~= "Off" and p1.InCutscene ~= true and not _G.InBuilding then
			p1.Pet:DestroyAll();
			u10();
			return;
		end;
		p1.Pet:DestroyAll();
	end;
	function v1.CreatePetAtLocation(p15, p16, p17, p18, p19, p20)
		local v19 = p1.DoodleInfo[p16.RealName or p16.Name];
		local v20 = math.max(3.77, (v19.ExceptionHeight or v19.Height) / 11) * (p16.Size and 1);
		local v21 = l__Utilities__1:Create("Part")({
			Name = p16.Name, 
			Size = Vector3.new(v20, v20, 0.0001), 
			CanCollide = false, 
			Transparency = 1, 
			Position = p17.p, 
			Massless = true, 
			Anchored = true
		});
		for v22, v23 in pairs(p1.GuiObjs.Follow:GetChildren()) do
			local v24 = v23:Clone();
			v24.Parent = v21;
			if p18 and v24:FindFirstChild("DropShadow") then
				v24.DropShadow:Destroy();
			end;
		end;
		if not p18 then
			local v25 = l__Utilities__1.FindFloorRecurse(p17.p + Vector3.new(0, 5, 0), { v21, workspace.Terrain });
			if v25 == nil then
				v21.CFrame = p17;
			else
				v21.Position = v25 + Vector3.new(0, v21.Size.Y / 2, 0);
			end;
		end;
		v21.RightLabel.Face = Enum.NormalId.Front;
		v21.LeftLabel.Face = Enum.NormalId.Back;
		if p20 then
			v21.RightLabel.Face = v21.LeftLabel.Face;
			v21.LeftLabel.Face = v21.RightLabel.Face;
		end;
		v21.Parent = workspace.Fodder;
		p1.Gui:AnimateSprite(v21.RightLabel.DoodleLabel, p16, true, nil, true);
		p1.Gui:AnimateSprite(v21.LeftLabel.DoodleLabel, p16, true, nil, nil);
		if p19 == nil then
			l__Utilities__1.FastSpawn(function()
				while v21:IsDescendantOf(game) do
					local l__p__26 = p1.Camera:GetCF().p;
					v21.CFrame = CFrame.new(v21.Position, Vector3.new(l__p__26.X, v21.Position.Y, l__p__26.Z));
					l__Utilities__1.Halt(0.05);				
				end;
			end);
		end;
		return v21;
	end;
	game.Players.PlayerRemoving:Connect(function(p21)
		u2[p21.Name] = nil;
		if u3[p21.Name] and u3[p21.Name].ActualDestroy then
			u3[p21.Name]:ActualDestroy();
			u3[p21.Name] = nil;
		end;
	end);
	v1.ChunkFuncs = require(script.ChunkFuncs)(p1);
	return v1;
end;
