-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local u1 = {
		DoorInfo = {
			LabDoor = {
				Open = "6495321810", 
				Closed = "6495179335", 
				Sound = "9171777374", 
				Loop = "6495349766", 
				Volume = 5, 
				WalkIn = true
			}, 
			HouseDoor1 = {
				Open = 8463301722, 
				Sound = 212709219, 
				Loop = 8463432831, 
				Volume = 5
			}, 
			HouseDoor2 = {
				Open = 8624812137, 
				Sound = 212709219, 
				Loop = 8624831293, 
				Volume = 5, 
				WalkIn = true
			}, 
			StationDoor = {
				Open = "8587829187", 
				Sound = "8587808798", 
				Loop = "8587834044", 
				Volume = 5, 
				WalkIn = true
			}, 
			CabinDoor1 = {
				Open = "9048083451", 
				Loop = "9048099707", 
				Sound = 212709219, 
				WalkIn = true, 
				Camera = true
			}, 
			HelpCenterDoors = {
				Open = "9171705542", 
				Loop = "9171711701", 
				Sound = "9171777374", 
				Volume = 1, 
				WalkIn = true
			}, 
			CaveDoor = {
				Open = "9434715086", 
				Loop = "9434722018", 
				Sound = "9171777374", 
				Volume = 1, 
				WalkIn = nil
			}
		}
	};
	local function u2(p2, p3, p4)
		local v1 = nil;
		local v2 = Instance.new("Animation");
		v2.AnimationId = "rbxassetid://" .. p3.Open;
		local v3 = Instance.new("AnimationController");
		v3.Parent = p2;
		local v4 = Instance.new("Animator");
		v4.Parent = v3;
		local v5 = Instance.new("Animation");
		v5.AnimationId = "rbxassetid://" .. p3.Loop;
		local v6 = v4:LoadAnimation(v2);
		local v7 = v4:LoadAnimation(v5);
		if not p4 then
			p1.Sound:PlayId(p3.Sound, 1, p3.Volume);
		end;
		v6:Play();
		v6.Stopped:wait();
		v7:Play();
		if p3.WalkIn then
			v1 = p1.p.Character;
			v1.Humanoid.WalkSpeed = 6;
			if p2:FindFirstChild("ActualGoalPart") then
				v1.Humanoid:MoveTo(p2.ActualGoalPart.Position);
				return;
			end;
			if not p2:FindFirstChild("GoalPart") then
				if p2:FindFirstChild("MainPart") then
					v1.Humanoid:MoveTo(p2.MainPart.Position);
				end;
				return;
			end;
		else
			return;
		end;
		v1.Humanoid:MoveTo(p2.GoalPart.Position);
	end;
	function u1.CaveDoor(p5)
		local v8 = u1.DoorInfo[p5.DoorType.Value];
		if v8 and p5.AlreadyOpen.Value == false then
			p5.AlreadyOpen.Value = true;
			u2(p5, v8, true);
		end;
	end;
	local u3 = false;
	function u1.Fall(p6)
		if not u3 then
			u3 = true;
			p1.Controls:ToggleWalk(false);
			p1.Gui:FadeToBlack();
			p1.p.Character.HumanoidRootPart.CFrame = p1.CurrentChunk:FindFirstChild(p6.Fall.Value).CFrame;
			p1.Controls:ToggleWalk(true);
			p1.Gui:FadeFromBlack();
			u3 = false;
		end;
	end;
	function u1.AutomaticDoorOpen(p7, p8)
		local v9 = Instance.new("AnimationController");
		v9.Parent = p7;
		local v10 = Instance.new("Animator");
		v10.Parent = v9;
		local v11 = Instance.new("Animation");
		v11.AnimationId = "rbxassetid://" .. u1.DoorInfo[p8].Loop;
		v10:LoadAnimation(v11):Play();
	end;
	function u1.BasicTeleport(p9)
		if not u3 then
			u3 = true;
			p1.Controls:ToggleWalk(false);
			p1.Sound:Play("RunSuccess");
			p1.Gui:FadeToBlack();
			p1.p.Character.HumanoidRootPart.CFrame = p1.CurrentChunk:FindFirstChild(p9.BasicTeleport.Value).CFrame;
			p1.Controls:ToggleWalk(true);
			p1.Gui:FadeFromBlack();
			u3 = false;
		end;
	end;
	local l__Utilities__4 = p1.Utilities;
	function u1.AutoOpenDoor(p10)
		local v12 = u1.DoorInfo[p10.DoorType.Value];
		if v12 then
			u3 = true;
			if v12.Time then
				l__Utilities__4.Halt(v12.Time);
			end;
			u2(p10, v12);
			u3 = false;
		end;
	end;
	local function u5(p11)
		local v13 = p1:GetProgression();
		if not p11 then
			return true;
		end;
		if v13 and v13[p11.Switch.Value] then
			return true;
		end;
		return false;
	end;
	function u1.NoDoor(p12)
		if p12:FindFirstChild("Requirement") and not p1:GetProgression()[p12.Requirement.Value] then
			return;
		end;
		if p12:FindFirstChild("ChunkTeleport") and p12:FindFirstChild("TouchLeave") and not u3 then
			u3 = true;
			local v14 = false;
			local l__LockedDoor__15 = p12:FindFirstChild("LockedDoor");
			p1.Controls:ToggleWalk(false);
			local l__Value__16 = p12.ChunkTeleport.Value;
			if not u5(l__LockedDoor__15) then
				p1.Controls:ToggleWalk(false);
				p1.Dialogue:SaySimple(l__LockedDoor__15.Message.Value, nil);
				p1.Controls:WalkToPosition(p1.CurrentChunk[l__LockedDoor__15.Fail.Value].Position, 12, true, true, 3);
				p1.Controls:ToggleWalk(true);
				u3 = false;
				v14 = true;
			elseif p12:FindFirstChild("WalkTo") then
				p1.Camera:SetScriptable();
				p1.Sound:Play("RunSuccess");
				p1.Controls:WalkTo(p12.WalkTo.Value, 12);
			else
				p1.Sound:PlayId("212709219", 1, 5);
			end;
			if v14 == false then
				p1.p.Character.HumanoidRootPart.Anchored = true;
				p1.ClientDatabase:PDSEvent("ChangeLocation", l__Value__16);
				p1.ClientDatabase:PDSEvent("UpdateDoor", p12.Name);
				local l__Music__17 = p12:FindFirstChild("Music");
				local v18 = nil;
				if l__Music__17 then
					v18 = l__Music__17.Value;
				end;
				p1.DataManager.Chunk.new(p1, l__Value__16, p12.TouchLeave.Value, nil, nil, p12.Name, {
					Music = v18
				});
				u3 = false;
			end;
		end;
	end;
	function u1.DoorOpen(p13)
		local l__Character__19 = p1.p.Character;
		if p13:FindFirstChild("ChunkTeleport") and p13:FindFirstChild("DoorType") and not u3 then
			local l__LockedDoor__20 = p13:FindFirstChild("LockedDoor");
			u3 = true;
			local v21 = u1.DoorInfo[p13.DoorType.Value];
			local v22 = p13:FindFirstChild("SpecificSpot") and p13.SpecificSpot.Value or "Entrance";
			if not u5(l__LockedDoor__20) then
				p1.Controls:ToggleWalk(false);
				p1.Dialogue:SaySimple(l__LockedDoor__20.Message.Value, nil);
				p1.Controls:WalkToPosition(p1.CurrentChunk[l__LockedDoor__20.Fail.Value].Position, 12, true, true, 3);
				p1.Controls:ToggleWalk(true);
				u3 = false;
				return;
			end;
			if v21 then
				p1.Controls:ToggleWalk(false);
				if v21.Time then
					l__Utilities__4.Halt(v21.Time);
				end;
				u2(p13, v21);
				p1.ClientDatabase:PDSEvent("UpdateDoor", p13.Name);
				local l__Music__23 = p13:FindFirstChild("Music");
				local v24 = nil;
				if l__Music__23 then
					v24 = l__Music__23.Value;
				end;
				p1.DataManager.Chunk.new(p1, p13.ChunkTeleport.Value, v22, nil, nil, p13.Name, {
					Music = v24
				});
				u3 = false;
			end;
		end;
	end;
	function u1.Upstairs(p14)
		local l__Character__25 = p1.p.Character;
		if p14:FindFirstChild("UpstairGoal") and not u3 then
			u3 = true;
			p1.Controls:ToggleWalk(false);
			l__Character__25.Humanoid.WalkSpeed = 6;
			l__Character__25.Humanoid:MoveTo(p14.UpstairGoal.Value);
			l__Utilities__4.Halt(0.6);
			p1.Gui:FadeToBlack();
			l__Utilities__4.Halt(0.35);
			l__Character__25.PrimaryPart.CFrame = p14.UpstairPos.Value + Vector3.new(0, 2, 0);
			p1.Gui:FadeFromBlack();
			l__Character__25.Humanoid.WalkSpeed = 16;
			p1.Controls:ToggleWalk(true);
			u3 = false;
		end;
	end;
	function u1.UpstairsCabin(p15)
		local l__Character__26 = p1.p.Character;
		if p15:FindFirstChild("UpstairsPath") and not u3 then
			u3 = true;
			p1.Controls:ToggleWalk(false);
			local l__Value__27 = p15:FindFirstChild("UpstairsPath").Value;
			l__Character__26.Humanoid.WalkSpeed = 12;
			if p15:FindFirstChild("Requirement") and not p1:GetProgression()[p15.Requirement.Value] then
				p1.Dialogue:SaySimple(p15.RequirementText.Value, nil);
				l__Utilities__4.Halt(0.1);
				p1.Controls:WalkTo(p1.CurrentChunk[p15.FailCheck.Value].CFrame, 12, true, true);
			else
				if l__Value__27:FindFirstChild("Failure") then
					p1.Controls:WalkToPosition(l__Value__27.Failure.Position, 12, true, true, 3);
				end;
				p1.Controls:WalkToPosition(l__Value__27.WalkToSpot1.Position, 12, true, true, 4.5);
				p1.Camera.SetCutscene(true, "NoCamera");
				p1.Controls:WalkToPosition(l__Value__27.WalkToSpot2.Position, 12, true, true, 4.5);
				p1.Gui:FadeToBlack();
				if p15:FindFirstChild("MusicChange") then
					p1.Music:PlaySong(p15.MusicChange.Value);
				end;
				p1.Camera.SetCutscene(nil, "NoCamera");
				l__Character__26.PrimaryPart.CFrame = p1.CurrentChunk[p15.GoalPart.Value].CFrame + Vector3.new(0, 2, 0);
				l__Utilities__4.Halt(0.35);
				p1.Gui:FadeFromBlack();
			end;
			if _G.ToggleRun then
				local v28 = 24;
			else
				v28 = 16;
			end;
			l__Character__26.Humanoid.WalkSpeed = v28;
			p1.Controls:ToggleWalk(true);
			u3 = false;
		end;
	end;
	function u1.Teleport(p16)
		if p16:FindFirstChild("LocalizedPart") and not u3 then
			u3 = true;
			p1.Controls:ToggleWalk(false);
			p1.Gui:FadeToBlack();
			if p16:FindFirstChild("MusicChange") then
				p1.Music:PlaySong(p16.MusicChange.Value);
			end;
			p1.p.Character.PrimaryPart.CFrame = p1.CurrentChunk[p16.LocalizedPart.Value].CFrame + Vector3.new(0, 2, 0);
			l__Utilities__4.Halt(0.35);
			p1.Gui:FadeFromBlack();
			p1.Controls:ToggleWalk(true);
			u3 = false;
		end;
	end;
	local u6 = nil;
	p1.Network:BindEvent("UpdateChests", function(p17)
		u6 = p17;
	end);
	function p1.GetOpenedChests(p18)
		if u6 == nil then
			u6 = p1.ClientDatabase:PDSFunc("GetOpenedChests", true);
		end;
		return u6;
	end;
	function u1.Chest(p19)
		local v29 = p19.Name:match("%d+");
		if p1:GetOpenedChests()[v29] then
			local v30 = p1.Services.Storage.OpenChest:Clone();
			v30:SetPrimaryPartCFrame(p19.PrimaryPart.CFrame);
		else
			v30 = p1.Services.Storage.ClosedChest:Clone();
			v30:SetPrimaryPartCFrame(p19.PrimaryPart.CFrame);
		end;
		v30.Name = v29;
		v30.Parent = p1.CurrentChunk.Chests;
		p19:Destroy();
	end;
	local function u7(p20)
		p1.Controls:ToggleWalk(false);
		p1.p.Character.HumanoidRootPart.CFrame = CFrame.new(p20.HumanoidRootPart.Position + Vector3.new(0, 2, 0) + p20.Helper.CFrame.lookVector * 3, p20.Helper.Position);
	end;
	function u1.OpenChest(p21)
		if not u3 then
			u3 = true;
			u7(p21);
			local v31 = Instance.new("AnimationController", p21);
			local v32 = v31:LoadAnimation(p1.Services.Storage:WaitForChild("OpenChestAnim"));
			local v33 = v31:LoadAnimation(p1.Services.Storage.PermaOpenChest);
			p1.p.Character.Humanoid:LoadAnimation(p1.Services.Storage.PlayerOpenChest):Play();
			v32:Play();
			p1.Sound:Play("ChestOpen");
			v32.Stopped:Connect(function()
				v33:Play();
				p1.Dialogue:SaySimple((p1.ClientDatabase:PDSFunc("OpenChest", p21.Name)));
				p1.Controls:ToggleWalk(true);
				u3 = false;
			end);
		end;
	end;
	return u1;
end;
