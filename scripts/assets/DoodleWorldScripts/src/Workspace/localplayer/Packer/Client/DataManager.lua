-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	p1.LoadedGeometry = l__Utilities__1.Signal();
	local v2 = {};
	function p1.ChunkEdit(p2, p3)
		local v3 = p1:GetProgression();
		if p3:FindFirstChild("Temp") then
			for v4, v5 in pairs(p3.Temp:GetChildren()) do
				local v6 = v5.Name:split(",");
				local v7 = v6[1];
				if v6[3] == "Reverse" and v3[v7] and tonumber(v6[2]) <= v3[v7] then
					v5:Destroy();
				end;
			end;
		end;
	end;
	local u1 = {
		RegionData = nil
	};
	local u2 = nil;
	local u3 = nil;
	local u4 = nil;
	local function u5(p4)
		local v8 = {};
		if p4.Encounters then
			for v9, v10 in pairs(p4.Encounters) do
				for v11, v12 in pairs(v10) do
					v8[v12.Name] = -v12.Chances;
				end;
			end;
		end;
		return v8;
	end;
	local function u6(p5, p6)
		local v13 = p1.GuiObjs.Sign:Clone();
		p1.Gui:ChangeText(v13.Background.Route, u1.RegionData.String);
		v13.Adornee = p5.Signage;
		local l__Scroll__14 = v13.Background.Scroll;
		local v15 = 0;
		local v16 = 0;
		for v17, v18 in pairs(p6) do
			v15 = v15 + 1;
			local v19 = p1.GuiObjs.SignDoodle:Clone();
			v19.Image = p1.DoodleInfo[v17].FrontSprite;
			v19.LayoutOrder = v18;
			v19.Parent = l__Scroll__14;
			if u2[tostring(p1.DoodleInfo[v17].Num)] and u2[tostring(p1.DoodleInfo[v17].Num)] >= 2 then
				v19.ImageColor3 = Color3.fromRGB(255, 255, 255);
				v16 = v16 + 1;
			end;
		end;
		local l__Progress__20 = v13.Background.Progress;
		if v15 > 0 then
			local v21 = v16 / v15;
		else
			v21 = 0;
		end;
		p1.Gui:ChangeText(l__Progress__20.Title, "Doodlepedia Progress: " .. v16 .. " / " .. v15);
		l__Progress__20.Clipping.Size = UDim2.new(v21, 0, 1, 0);
		v13.Parent = p1.pgui;
		local l__AbsoluteSize__22 = v13.Background.ScrollActualSize.AbsoluteSize;
		l__Scroll__14.UIGridLayout.CellSize = UDim2.new(0, l__AbsoluteSize__22.Y / 2 - 5, 0, l__AbsoluteSize__22.Y / 2 - 5);
		l__Scroll__14.CanvasSize = UDim2.new(0, 0, 0, l__Scroll__14.UIGridLayout.AbsoluteContentSize.Y);
		return v13;
	end;
	local function u7()
		if u3 then
			u3:Destroy();
		end;
		if u4 then
			u4:Destroy();
		end;
		if p1.CurrentChunk and p1.CurrentChunk:FindFirstChild("RouteSign") then
			local l__RouteSign__23 = p1.CurrentChunk:FindFirstChild("RouteSign");
			local l__Signage__24 = l__RouteSign__23.Signage;
			u3 = u6(l__RouteSign__23, (u5(u1.RegionData)));
			u4 = u3:Clone();
			u4.Face = Enum.NormalId.Back;
			u4.Parent = p1.pgui;
		end;
		if u1.RegionData.Reward then
			local v25 = nil;
			local l__Type__26 = u1.RegionData.Reward.Type;
			v25 = u1.RegionData.Reward.Number;
			local v27 = nil;
			if l__Type__26 == "Color" then
				p1.ColorAnim.Create(u3.Background.Label.Reward, v25);
				p1.ColorAnim.Create(u4.Background.Label.Reward, v25);
				v27 = p1.Colors.GetColorName(v25) .. " color";
			elseif l__Type__26 == "Title" then
				v27 = p1.Titles[v25] .. " title";
			end;
			if v27 then
				p1.Gui:ChangeText(u3.Background.Label.Reward, v27);
				p1.Gui:ChangeText(u4.Background.Label.Reward, v27);
				local l__TextBounds__28 = u3.Background.Label.Reward.TextBounds;
				local l__TextBounds__29 = u3.Background.Label.TextBounds;
				u3.Background.Label.Reward.Size = UDim2.new(0, l__TextBounds__28.X, 1, 0);
				u4.Background.Label.Reward.Size = UDim2.new(0, l__TextBounds__28.X, 1, 0);
				u3.Background.Label.Size = UDim2.new(0, l__TextBounds__29.X, 0.1, 0);
				u4.Background.Label.Size = UDim2.new(0, l__TextBounds__29.X, 0.1, 0);
			else
				p1.Gui:ChangeText(u3.Background.Label.Reward, "");
				p1.Gui:ChangeText(u4.Background.Label.Reward, "");
			end;
			p1.ClientDatabase:PDSFunc("CompletionRewardCheck", u1.RegionData.ChunkName);
		end;
	end;
	p1.Network:BindEvent("UpdateDoodlepedia", function(p7)
		u2 = p7;
		u7();
	end);
	u1.Chunk = {};
	local u8 = nil;
	local function u9(p8)
		local v30 = p1:GetProgression();
		if p8:FindFirstChild("ReverseRequirements") then
			local l__ReverseRequirements__31 = p8.ReverseRequirements;
			local l__Value__32 = l__ReverseRequirements__31.EventName.Value;
			if v30[l__Value__32] and l__ReverseRequirements__31.Flag.Value <= v30[l__Value__32] then
				return false;
			end;
			if not p8:FindFirstChild("Requirements") then
				return true;
			end;
			if p8:FindFirstChild("Requirements") then
				local l__Requirements__33 = p8.Requirements;
				local l__Value__34 = l__Requirements__33.EventName.Value;
				if v30[l__Value__34] and l__Requirements__33.Flag.Value <= v30[l__Value__34] then
					return true;
				else
					return false;
				end;
			end;
		end;
		if not p8:FindFirstChild("Requirements") then
			return true;
		end;
		local l__Requirements__35 = p8.Requirements;
		local l__Value__36 = l__Requirements__35.EventName.Value;
		if v30[l__Value__36] and l__Requirements__35.Flag.Value <= v30[l__Value__36] then
			return true;
		end;
		return false;
	end;
	local function u10(p9, p10)
		return Region3.new(Vector3.new(math.min(p9.X, p10.X), math.min(p9.Y, p10.Y), math.min(p9.Z, p10.Z)), (Vector3.new(math.max(p9.X, p10.X), math.max(p9.Y, p10.Y), math.max(p9.Z, p10.Z))));
	end;
	u1.Chunk.new = function(p11, p12, p13, p14, p15, p16, p17)
		local v37 = tick();
		local v38 = p17 or {};
		local l__Character__39 = p1.p.Character;
		if not u2 then
			u2 = p1.ClientDatabase:PDSFunc("GetDoodlepedia");
		end;
		if p14 == nil then
			p1.Gui:FadeToBlack();
		end;
		if p12 == nil then
			p12 = "Chunk_001";
		end;
		l__Character__39.HumanoidRootPart.Anchored = true;
		p1.Overworld.ChunkFuncs:UpdateCurrentChunk(p12);
		if p1.CurrentChunk then
			p1.CurrentChunk:Destroy();
		end;
		if p1.CurrentNPCs then
			for v40, v41 in pairs(p1.CurrentNPCs) do
				if v41.Destroy then
					v41:Destroy();
				else
					p1.CurrentNPCs[v41] = nil;
				end;
			end;
		end;
		p1.CurrentNPCs = {};
		p1.NPC:SetLoadFalse();
		local v42, v43 = p1.Network:get("RequestChunk", p12, p13, p12);
		u1.RegionData = v43;
		p1.CurrentChunk = v42.Map:Clone();
		p1.CurrentChunk.Parent = workspace;
		if p1.pgui:FindFirstChild("ChunkRequest") then
			p1.Network:post("DeleteMap", v42.Folder);
		end;
		u8 = p12;
		l__Utilities__1.Halt(0.2);
		p1:ChunkEdit(p1.CurrentChunk);
		workspace.Fodder:ClearAllChildren();
		workspace.Terrain:Clear();
		if p1.CurrentChunk.Name == "001_Chunk" and p1:GetProgression().GetStarter ~= 2 then
			p1.Cutscene:Arrow("001_Chunk", Vector3.new(680.542, -262.269, 62.239));
		end;
		p1.CurrentChunk.Parent = workspace;
		if v38.Music then
			p1.Music:PlaySong(v38.Music, true);
		else
			p1.Music:PlaySong(u1.RegionData.Music, true);
		end;
		if p1.Settings:Get("DisableLighting") ~= true then
			p1.Lighting:Apply(u1.RegionData.Lighting);
		else
			p1.Lighting:Apply("Default");
		end;
		l__Utilities__1.Halt(1);
		while true do
			l__Utilities__1.Halt(0.033);
			if p1.CurrentChunk.Parent == workspace then
				break;
			end;		
		end;
		if p1.CurrentChunk:FindFirstChild("NPC") then
			p1.NPCHolder = p1.CurrentChunk:FindFirstChild("NPC");
			p1.CurrentNPCs = {};
			for v44, v45 in pairs(p1.CurrentChunk.NPC:GetChildren()) do
				l__Utilities__1.Halt();
				if u9(v45) then
					p1.CurrentNPCs[v45] = p1.NPC.new({}, v45);
				else
					v45:Destroy();
				end;
			end;
		end;
		if p1.CurrentChunk:FindFirstChild("Interactables") then
			for v46, v47 in pairs(p1.CurrentChunk.Interactables:GetChildren()) do
				if v47.Name == "Multiple-Box" then
					local v48 = v47:GetChildren();
					v48[math.random(#v48)].Name = "SupahBox";
					for v49, v50 in pairs(v47:GetChildren()) do
						if v50:IsA("Model") then
							local v51 = (v47:FindFirstChild("Interact") or p1.Services.ReplicatedStorage.Extra:FindFirstChild("BoxInteract")):Clone();
							v51.Name = "Interact";
							v51.Parent = v50;
							local v52 = {};
							local u11 = require(v51)(p1, v50);
							function v52.Event()
								p1.Dialogue:Talk(u11, v50);
							end;
							p1.CurrentNPCs[v50] = v52;
							v50.Parent = p1.NPCHolder;
						end;
					end;
				elseif v47:FindFirstChild("Interact") then
					local v53 = require(v47:FindFirstChild("Interact"))(p1, v47);
					if u9(v47) then
						local v54 = {};
						function v54.Event()
							p1.Dialogue:Talk(v53, v47);
						end;
						p1.CurrentNPCs[v47] = v54;
						v47.Parent = p1.NPCHolder;
					else
						v47:Destroy();
					end;
				end;
			end;
		end;
		if p1.CurrentChunk:FindFirstChild("Chests") then
			for v55, v56 in pairs(p1.CurrentChunk.Chests:GetChildren()) do
				p1.GeometryInfo.Chest(v56);
			end;
		end;
		local l__mouse__57 = p1.p:GetMouse();
		workspace.TargetFilter.MapParts:ClearAllChildren();
		if p1.CurrentChunk:FindFirstChild("InvisWalls") then
			p1.CurrentChunk.InvisWalls.Parent = workspace.TargetFilter.MapParts;
		end;
		l__mouse__57.TargetFilter = workspace.TargetFilter;
		if p1.CurrentChunk:FindFirstChild("Water") then
			for v58, v59 in pairs(p1.CurrentChunk.Water:GetChildren()) do
				workspace.Terrain:FillBlock(v59.CFrame, v59.Size, Enum.Material.Water);
				v59:Destroy();
			end;
		end;
		p1.CurrentChunk = p1.CurrentChunk;
		p1.CurrentDoors = nil;
		if p1.CurrentChunk:FindFirstChild("Doors") then
			p1.CurrentDoors = p1.CurrentChunk.Doors;
		end;
		if p1.CurrentChunk:FindFirstChild("AutoOpen") then
			for v60, v61 in pairs(p1.CurrentChunk.AutoOpen:GetChildren()) do
				p1.GeometryInfo.AutomaticDoorOpen(v61, v61:FindFirstChild("AutoOpen").Value);
			end;
		end;
		if p1.CurrentChunk:FindFirstChild("DoodleOverworld") then
			for v62, v63 in pairs(p1.CurrentChunk.DoodleOverworld:GetChildren()) do
				if u9(v63) then
					p1.Overworld:CreatePetAtLocation({
						Name = v63.Name
					}, v63.CFrame, v63:FindFirstChild("NoShadow"), v63:FindFirstChild("NoFollow"), v63:FindFirstChild("Flipped"));
					v63:Destroy();
				else
					v63:Destroy();
				end;
			end;
		end;
		if p1.CurrentChunk:FindFirstChild("Temporary") then
			for v64, v65 in pairs(p1.CurrentChunk.Temporary:GetChildren()) do
				if not u9(v65) then
					v65:Destroy();
				end;
			end;
		end;
		u7();
		p1.LoadedGeometry:Fire();
		local v66 = p1.Cutscene:CheckOnEnterCutscenes(p12, p16);
		if not v66 then
			local l__Main__67 = workspace.SpawnBox.Main;
			for v68, v69 in pairs((workspace:FindPartsInRegion3WithWhiteList(u10(l__Main__67.Position + Vector3.new(l__Main__67.Size.X / 2, l__Main__67.Size.Y / 2, l__Main__67.Size.Z / 2), l__Main__67.Position + Vector3.new(l__Main__67.Size.X / 2, l__Main__67.Size.Y / 2, l__Main__67.Size.Z / 2) * -1), { l__Character__39 }, math.huge))) do
				if v69 == l__Character__39.HumanoidRootPart then
					l__Character__39.PrimaryPart.CFrame = p1.CurrentChunk[p1.DataManager.RegionData.Entrance].CFrame + Vector3.new(0, 2, 0);
					break;
				end;
			end;
		end;
		local v70 = p1.Controls:GetHumanoid();
		_G.NoWind = p1.DataManager.RegionData.NoWind;
		_G.NoRain = p1.DataManager.RegionData.NoRain;
		if p1.DataManager.RegionData.InBuilding then
			if game.Lighting:FindFirstChild("RainClouds") then
				game.Lighting:FindFirstChild("RainClouds"):Destroy();
			end;
			_G.InBuilding = true;
			p1.Overworld:RainStop();
			p1.Overworld:Toggle();
			v70.JumpPower = 0;
			game.ReplicatedStorage.InBuilding:Clone().Parent = game.Lighting;
			p1.Camera:Overhead();
		else
			if game.Lighting:FindFirstChild("InBuilding") then
				game.Lighting:FindFirstChild("InBuilding"):Destroy();
			end;
			if p1.StoryWeather == "ThunderousRain" and p1.DataManager.RegionData.NoWind == nil and p1.DataManager.RegionData.NoRain == nil then
				p1.Overworld:RandomBoltSpot();
				p1.Overworld:Rain();
				p1.Overworld:Cloudy(true);
			else
				p1.Overworld:RainStop();
				p1.Overworld:Cloudy(false);
			end;
			_G.InBuilding = nil;
			p1.Overworld:Toggle();
			p1.Camera:NotOverhead();
			p1.Camera:NewChunkPov();
			v70.JumpPower = 35;
		end;
		p1.Network:post("ChangeChunk");
		local v71 = tick();
		while true do
			local v72 = l__Utilities__1.FindFloor(CFrame.new(l__Character__39.HumanoidRootPart.Position), { l__Character__39 });
			l__Utilities__1.Halt(0.1);
			if v72 then
				break;
			end;
			if tick() - v71 > 10 then
				break;
			end;		
		end;
		if tick() - v71 > 10 then
			print("Took longer than 10 seconds to load map... yikes. Error maybe? Or lag?");
		end;
		if p1.Overworld.ChunkFuncs[p12] then
			for v73, v74 in pairs(p1.Overworld.ChunkFuncs[p12]) do
				if typeof(v74) == "function" then
					l__Utilities__1.FastSpawn(function()
						v74();
					end);
				end;
			end;
		end;
		if p1.TestMode then
			print(string.format("%s , %.2f", p12, tick() - v37));
		end;
		if v66 then
			p1.ClientDatabase:PDSEvent("ToggleCutscene", true);
			p1.Social.PlayerVisibility(false);
			p1.InCutscene = true;
			p1.Overworld:Toggle(true);
			_G.ActuallyReady = true;
			v66();
			p1.ClientDatabase:PDSEvent("ToggleCutscene", false);
			p1.InCutscene = nil;
			p1.Overworld:Toggle();
			p1.Social.PlayerVisibility(true);
		elseif not p15 then
			l__Utilities__1.MapCheckBelow();
			p1.ClientDatabase:PDSEvent("Unanchor");
			p1.Controls:ToggleWalk(true);
		end;
		l__Utilities__1.Halt(0.5);
		if not p15 and not v66 then
			p1.Camera:Cancel();
			p1.Gui:FadeFromBlack();
		end;
		if p1.DataManager.RegionData.String and not p15 and not v66 then
			p1.Gui:AreaPopup(p1.DataManager.RegionData.String, p1.DataManager.RegionData.SongName);
		end;
	end;
	local function v75(p18)
		local v76 = {};
		p18:WaitForChild("Humanoid");
		local u12 = true;
		p18.Humanoid.Died:Connect(function(p19)
			u12 = false;
			wait(0.25);
			p1.Gui:FadeToBlack();
		end);
		p18:WaitForChild("HumanoidRootPart");
		for v77, v78 in pairs(p18:GetDescendants()) do
			if v78:IsA("BasePart") and v78.Name ~= "Handle" and not v78:FindFirstChild("Follower") then
				table.insert(v76, v78);
				v78.Touched:Connect(function(p20)
					if p18.Humanoid.Health <= 0 or p1.InCutscene then
						return;
					end;
					if not (not p1.RunningCutscene) or not (not p1.Battle.CurrentBattle) or p1.Battle.RequestBattle then
						return;
					end;
					if not table.find(v76, p20) and p1.CurrentDoors then
						for v79, v80 in pairs(p1.CurrentDoors:GetChildren()) do
							if p20:IsDescendantOf(v80) then
								p1.GeometryInfo.DoorOpen(v80);
								return;
							end;
						end;
					end;
					if p20:FindFirstChild("BasicTeleport") then
						p1.GeometryInfo.BasicTeleport(p20);
						return;
					end;
					if p20:FindFirstChild("Fall") then
						p1.GeometryInfo.Fall(p20);
						return;
					end;
					if p20:FindFirstChild("LocalizedPart") then
						p1.GeometryInfo.Teleport(p20);
						return;
					end;
					if p20:FindFirstChild("UpstairsPath") then
						p1.GeometryInfo.UpstairsCabin(p20);
						return;
					end;
					if p20:FindFirstChild("UpstairGoal") then
						p1.GeometryInfo.Upstairs(p20);
						return;
					end;
					if p20:FindFirstChild("TouchLeave") then
						p1.GeometryInfo.NoDoor(p20);
						return;
					end;
					if p20.Parent:FindFirstChild("ChestLoad") then
						if p1:GetOpenedChests()[p20.Parent.Name] then
							return;
						else
							p1.GeometryInfo.OpenChest(p20.Parent);
							return;
						end;
					end;
					if p20.Parent.Name == "Cutscene" and not p1.Battle.CurrentBattle then
						local v81 = p1.Cutscene:CheckTouchedCutscenes(p20);
						if v81 then
							p1.ClientDatabase:PDSEvent("ToggleCutscene", true);
							p1.Social.PlayerVisibility(false);
							p1.InCutscene = true;
							p1.Overworld:Toggle();
							v81(p20);
							p1.InCutscene = nil;
							p1.Overworld:Toggle();
							p1.ClientDatabase:PDSEvent("ToggleCutscene", false);
							p1.Social.PlayerVisibility(true);
							return;
						end;
					elseif p20.Name == "AreaPopup" then
						local l__Value__82 = p20.Area.Value;
						if u8 ~= l__Value__82 then
							u8 = l__Value__82;
							p1.ClientDatabase:PDSEvent("ChangeLocation", l__Value__82);
							p1.DataManager.RegionData = p1.Network:get("RequestChunkInfo", l__Value__82);
							u7();
							if p1.DataManager.RegionData.String then
								p1.Music:PlaySong(u1.RegionData.Music, true);
								p1.Gui:AreaPopup(p1.DataManager.RegionData.String, p1.DataManager.RegionData.SongName);
							end;
						end;
					end;
				end);
			end;
		end;
	end;
	p1.ResetBindable = Instance.new("BindableEvent");
	p1.ResetBindable.Event:connect(function()
		l__Utilities__1.Halt(0.1);
		if not p1.ResetEnabled then
			return;
		end;
		local l__Character__83 = p1.p.Character;
		l__Character__83.Humanoid.WalkSpeed = 0;
		p1.Gui:FadeToBlack();
		if p1.DataManager.RegionData.InBuilding then
			l__Character__83.Humanoid.JumpPower = 0;
		end;
		if p1.DataManager.RegionData.ResetToDifferentChunk then
			l__Utilities__1.FastSpawn(function()
				p1.DataManager.Chunk.new(p1, p1.DataManager.RegionData.ResetToDifferentChunk, "Entrance", true, true);
			end);
			p1.LoadedGeometry:Wait();
			l__Character__83.PrimaryPart.CFrame = l__Character__83.PrimaryPart.CFrame + Vector3.new(0, 2, 0);
			p1.ClientDatabase:PDSEvent("Unanchor");
			p1.Controls:ToggleWalk(true);
		else
			l__Character__83.PrimaryPart.CFrame = p1.CurrentChunk[p1.DataManager.RegionData.Entrance].CFrame + Vector3.new(0, 2, 0);
		end;
		p1.Gui:FadeFromBlack();
		if _G.ToggleRun then
			local v84 = 24;
		else
			v84 = 16;
		end;
		l__Character__83.Humanoid.WalkSpeed = v84;
	end);
	v75(game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:wait());
	game.Players.LocalPlayer.CharacterAdded:Connect(function(p21)
		v75(p21);
		if p1.DataManager.RegionData.InBuilding then
			p21.Humanoid.JumpPower = 0;
		end;
		if p1.DataManager.RegionData.ResetToDifferentChunk then
			l__Utilities__1.FastSpawn(function()
				p1.DataManager.Chunk.new(p1, p1.DataManager.RegionData.ResetToDifferentChunk, "Entrance", true, true);
			end);
			p1.LoadedGeometry:Wait();
			p21.PrimaryPart.CFrame = p21.PrimaryPart.CFrame + Vector3.new(0, 2, 0);
			p1.ClientDatabase:PDSEvent("Unanchor");
			p1.Controls:ToggleWalk(true);
		else
			p21.PrimaryPart.CFrame = p1.CurrentChunk[p1.DataManager.RegionData.Entrance].CFrame + Vector3.new(0, 2, 0);
		end;
		p1.Gui:FadeFromBlack();
	end);
	return u1;
end;
