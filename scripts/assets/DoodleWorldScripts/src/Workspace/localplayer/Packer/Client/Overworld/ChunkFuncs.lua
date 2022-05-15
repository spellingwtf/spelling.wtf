-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {};
	local v2 = {};
	local u1 = nil;
	local l__Utilities__2 = p1.Utilities;
	local function u3(p2, p3)
		for v3, v4 in pairs(p2:GetChildren()) do
			if v4:IsA("ParticleEmitter") then
				v4.Enabled = p3;
			end;
		end;
	end;
	v2[1] = function()
		local v5, v6 = p1:GetProgression();
		if v5["28"] then
			return;
		end;
		while u1 == "014_GraphiteLodge" do
			local v7 = p1.Controls:GetHRP();
			if u1 ~= "014_GraphiteLodge" then
				break;
			end;
			if v7 then
				if l__Utilities__2:GetDistPosition(30, v7.Position, p1.CurrentChunk.House1Exit.Position) then
					if p1.Music:GetCurrentSong() == "SummersCircle" then
						p1.Music:PlaySong("Protostar", true);
					end;
					u3(p1.CurrentChunk.MusicNoteParticles, true);
				elseif not l__Utilities__2:GetDistPosition(30, v7.Position, p1.CurrentChunk.House1Exit.Position) then
					if p1.Music:GetCurrentSong() == "Protostar" then
						p1.Music:PlaySong("SummersCircle", true);
					end;
					u3(p1.CurrentChunk.MusicNoteParticles, false);
				end;
			end;
			l__Utilities__2.Halt(1);
			if u1 ~= "014_GraphiteLodge" then
				break;
			end;		
		end;
	end;
	v1["014_GraphiteLodge"] = v2;
	v1["016_LodgeInteriors"] = { function()
			local v8 = Vector3.new(4, 4, 4);
			local l__TweenService__9 = game:GetService("TweenService");
			local v10 = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
			local l__BoomBox__11 = p1.CurrentChunk.NPC:FindFirstChild("BoomBox");
			if not l__BoomBox__11 then
				return;
			end;
			local l__Mesh__12 = l__BoomBox__11.BoomBox.Mesh;
			local v13 = l__TweenService__9:Create(l__Mesh__12, v10, {
				Scale = v8 * 1.2
			});
			local v14 = l__TweenService__9:Create(l__Mesh__12, v10, {
				Scale = v8
			});
			while u1 == "016_LodgeInteriors" do
				v13:Play();
				l__Utilities__2.Halt(0.5);
				if u1 ~= "016_LodgeInteriors" then
					break;
				end;
				v14:Play();
				l__Utilities__2.Halt(0.5);
				if u1 ~= "016_LodgeInteriors" then
					break;
				end;			
			end;
		end };
	v1["019_LouisCult"] = { function()
			while u1 == "019_LouisCult" do
				for v15, v16 in pairs(p1.CurrentChunk.LouisEyes:GetChildren()) do
					v16.CFrame = CFrame.new(v16.Position, p1.p.Character.Head.Position);
				end;
				l__Utilities__2.Halt(0.05);			
			end;
		end };
	function v1.UpdateCurrentChunk(p4, p5)
		u1 = p5;
	end;
	v1["022_ForestMaze"] = { function()
			if not _G.ForestMazeDone and not p1:GetProgression()["46"] then
				for v17, v18 in pairs(p1.CurrentChunk.Bridges:GetDescendants()) do
					if v18:IsA("BasePart") then
						v18.Transparency = 1;
						v18.CanCollide = false;
					end;
				end;
			end;
		end, function()
			local l__Prox__19 = p1.CurrentChunk.Prompt.Prox;
			local u4 = p1:GetProgression();
			l__Prox__19.Triggered:Connect(function(p6)
				if u4["48"] then
					p1.Dialogue:SaySimple("Why would you go back there?");
					p1.Controls:ToggleWalk(true);
					return;
				end;
				l__Prox__19.MaxActivationDistance = 0;
				p1.Gui:FadeToBlack();
				p1.DataManager.Chunk.new(p1, "023_FirstKey", "Entrance", true, true);
				p1.ClientDatabase:PDSEvent("Unanchor");
				p1.ClientDatabase:PDSEvent("UpdateObjective", 29);
				p1.Gui:FadeFromBlack();
				p1.Gui:AreaPopup("Graphite Temple");
			end);
		end };
	v1["023_FirstKey"] = { function()
			_G.ForestMazeDone = true;
			local l__Prox__20 = p1.CurrentChunk.Prompt.Prox;
			l__Prox__20.Triggered:Connect(function(p7)
				l__Prox__20.MaxActivationDistance = 0;
				p1.Gui:FadeToBlack();
				p1.DataManager.Chunk.new(p1, "022_ForestMaze", "FromTemple", true, true);
				p1.ClientDatabase:PDSEvent("Unanchor");
				p1.Gui:FadeFromBlack();
				p1.Gui:AreaPopup("Graphite Maze");
			end);
		end };
	p1.p.Chatted:Connect(function(p8)
		if u1 == "018_CrystalCaverns" and p8:lower() == "louis" and p1.CurrentChunk:FindFirstChild("CaveDoor") then
			p1.GeometryInfo.CaveDoor(p1.CurrentChunk:FindFirstChild("CaveDoor"));
		end;
	end);
	return v1;
end;
