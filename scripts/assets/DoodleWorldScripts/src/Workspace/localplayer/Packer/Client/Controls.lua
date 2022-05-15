-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {
		GetHumanoid = function(p2)
			return (game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:wait()):FindFirstChild("Humanoid");
		end, 
		GetChar = function(p3)
			return game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:wait();
		end, 
		GetHRP = function(p4)
			return (game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:wait()):FindFirstChild("HumanoidRootPart");
		end
	};
	function v1.ToggleMobile(p5, p6)
		if p1.pgui then
			local l__TouchGui__2 = p1.pgui:FindFirstChild("TouchGui");
			if l__TouchGui__2 then
				l__TouchGui__2:FindFirstChild("TouchControlFrame").Visible = p6;
			end;
		end;
	end;
	local l__StarterGui__3 = game:GetService("StarterGui");
	local l__RunService__4 = game:GetService("RunService");
	function v1.EnableReset(p7, p8)
		pcall(function()
			if p8 ~= true then
				game:GetService("StarterGui"):SetCore("ResetButtonCallback", false);
				p1.ResetEnabled = nil;
				return;
			end;
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", p1.ResetBindable);
			p1.ResetEnabled = true;
		end);
	end;
	local l__Utilities__1 = p1.Utilities;
	local l__Tween__2 = p1.Tween;
	function v1.MoveToWait(p9, p10, p11, p12)
		local v5 = v1:GetHRP();
		v1.Waiting = true;
		local v6 = 0;
		p12 = p12 and 3;
		local v7 = typeof(p10) == "CFrame" and p10.p or p10;
		local v8 = Vector3.new(v7.X, v5.Position.Y, v7.Z);
		v1:GetHumanoid().MoveToFinished:Connect(function()
			v1.Waiting = false;
		end);
		while v1.Waiting do
			v6 = v6 + 1;
			if (v8 - v5.Position).magnitude <= p12 or v6 > 300 then
				v1.Waiting = false;
			end;
			l__Utilities__1.Halt(0.033);		
		end;
		if not p11 then
			l__Tween__2:PlayTween(v5, {
				CFrame = p10
			}, true, 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			l__Utilities__1.Halt(0.35);
		end;
	end;
	function v1.Rotate(p13, p14)
		local v9 = v1:GetHRP();
		local l__Position__10 = v9.Position;
		p1.Tween:TweenCFrame(v9, CFrame.new(l__Position__10, Vector3.new(p14.X, l__Position__10.Y, p14.Z)), true, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
	end;
	function v1.AutoRotate(p15, p16)
		v1:GetHumanoid().AutoRotate = p16;
	end;
	function v1.WalkToPosition(p17, p18, p19, p20, p21, p22)
		local v11 = v1:GetHumanoid();
		local v12 = v1:GetHRP();
		v11:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
		v12.Anchored = false;
		local v13 = p19;
		if not v13 then
			if _G.ToggleRun then
				v13 = 24;
			else
				v13 = 16;
			end;
		end;
		v11.WalkSpeed = v13;
		v11:MoveTo(p18);
		v1:MoveToWait(p18, p20, p22);
		v11:SetStateEnabled(Enum.HumanoidStateType.Climbing, true);
		if not p21 then
			v11.WalkSpeed = 0;
			v12.Anchored = true;
		end;
	end;
	function v1.WalkTo(p23, p24, p25, p26, p27, p28)
		local v14 = v1:GetHumanoid();
		local v15 = v1:GetHRP();
		v14:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
		v15.Anchored = false;
		local v16 = p25;
		if not v16 then
			if _G.ToggleRun then
				v16 = 24;
			else
				v16 = 16;
			end;
		end;
		v14.WalkSpeed = v16;
		v14:MoveTo(p24.p);
		v1:MoveToWait(p24, p26, p28);
		v14:SetStateEnabled(Enum.HumanoidStateType.Climbing, true);
		if not p27 then
			v14.WalkSpeed = 0;
			v15.Anchored = true;
		end;
	end;
	local u3 = {};
	function v1.BlueTeleportFade(p29)
		u3 = {};
		for v17, v18 in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if v18:IsA("BasePart") then
				local v19 = nil;
				if v18:IsA("MeshPart") then
					v19 = v18.TextureID;
				end;
				u3[v18] = {
					BrickColor = v18.BrickColor, 
					TextureId = v19, 
					Transparency = v18.Transparency
				};
			elseif v18:IsA("BodyColors") then
				u3[v18] = {
					HeadColor3 = v18.HeadColor3, 
					LeftArmColor3 = v18.LeftArmColor3, 
					LeftLegColor3 = v18.LeftLegColor3, 
					RightArmColor3 = v18.RightArmColor3, 
					RightLegColor3 = v18.RightLegColor3, 
					TorsoColor3 = v18.TorsoColor3
				};
			elseif v18:IsA("Decal") then
				u3[v18] = {
					Transparency = v18.Transparency
				};
			end;
		end;
		local l__Color__20 = BrickColor.new("Cyan").Color;
		for v21, v22 in pairs(u3) do
			if v21:IsA("BasePart") then
				if v21:IsA("MeshPart") then
					v21.TextureID = "";
				end;
				l__Tween__2:PlayTween(v21, {
					Transparency = 1, 
					Color = l__Color__20
				}, true, 1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			elseif v21:IsA("BodyColors") then
				l__Tween__2:PlayTween(v21, {
					HeadColor3 = l__Color__20, 
					LeftArmColor3 = l__Color__20, 
					LeftLegColor3 = l__Color__20, 
					RightArmColor3 = l__Color__20, 
					RightLegColor3 = l__Color__20, 
					TorsoColor3 = l__Color__20
				}, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			elseif v21:IsA("Decal") then
				l__Tween__2:PlayTween(v21, {
					Transparency = 1
				}, true, 1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			end;
		end;
		l__Utilities__1.Halt(2);
	end;
	function v1.ImmediateTeleport(p30)
		for v23, v24 in pairs(u3) do
			if v23:IsA("BasePart") then
				if v23:IsA("MeshPart") then
					v23.TextureID = v24.TextureId;
				end;
				v23.Transparency = v24.Transparency;
				v23.Color = v24.BrickColor.Color;
			elseif v23:IsA("BodyColors") then
				for v25, v26 in pairs(v24) do
					v23[v25] = v26;
				end;
			elseif v23:IsA("Decal") then
				v23.Transparency = v24.Transparency;
			end;
		end;
		u3 = nil;
	end;
	function v1.ToggleWalk(p31, p32, p33)
		local v27 = v1:GetHumanoid();
		if not v27 then
			return;
		end;
		v1:ToggleMobile(p32);
		v1:EnableReset(p32);
		if p32 ~= true then
			if p32 == false then
				if not p33 then
					p1.Menu:Disable();
				end;
				p1.ControlObj:Disable();
				v27.WalkSpeed = 0;
			end;
			return;
		end;
		if not p33 then
			p1.Menu:Enable();
		end;
		p1.ControlObj:Enable(true);
		if _G.ToggleRun then
			local v28 = 24;
		else
			v28 = 16;
		end;
		v27.WalkSpeed = v28;
		p1.ClientDatabase:PDSEvent("ToggleBusy", false);
	end;
	function v1.PlayAnim(p34, p35)
		local v29 = v1:GetHumanoid();
		local v30 = v29:LoadAnimation(l__Utilities__1:Create("Animation")({
			AnimationId = p1.MiscDB.Animations[p35] and "http:/www.roblox.com/asset/?id=" .. p1.MiscDB.Animations[p35].Id or "http:/www.roblox.com/asset/?id=" .. p35, 
			Parent = v29
		}));
		v30:Play();
		return v30;
	end;
	function v1.SetupControls(p36)
		p1.Cursor = p1.Cursor.new();
		p1.PlayerModule = require(p1.p.PlayerScripts.PlayerModule);
		p1.ControlObj = p1.PlayerModule:GetControls();
	end;
	local u4 = nil;
	game:GetService("UserInputService").InputBegan:connect(function(p37)
		local v31 = v1:GetHumanoid();
		if not v31 then
			return;
		end;
		if v31:IsDescendantOf(game) and p37.KeyCode == Enum.KeyCode.LeftShift and v31.WalkSpeed ~= 0 and not p1.InCutscene then
			_G.PlayerRunning = true;
			u4 = "Up";
			v31.WalkSpeed = 24;
		end;
	end);
	function v1.AttachCapsule(p38, p39, p40)
		local l__Character__32 = p1.p.Character;
		local v33 = p1.Capsules.new(p39, p40);
		v33:SetParent(l__Character__32);
		local v34 = Instance.new("Motor6D", v33.Model.Bottom);
		v34.Name = "RightHand";
		v34.Part0 = l__Character__32.RightHand;
		v34.Part1 = v33.Model.Bottom;
		local v35 = Instance.new("Animation", p38.Motor6D);
		v35.AnimationId = "http://www.roblox.com/asset/?id=4632555088";
		p38.Model.Humanoid:LoadAnimation(v35):Play();
	end;
	function v1.Teleport(p41, p42)
		local v36 = v1:GetHRP();
		if v36 then
			v36.CFrame = p42;
		end;
	end;
	game:GetService("UserInputService").InputEnded:connect(function(p43)
		local v37 = v1:GetHumanoid();
		if not v37 then
			return;
		end;
		if p1.p.Character:IsDescendantOf(game) and p43.KeyCode == Enum.KeyCode.LeftShift and v37.WalkSpeed ~= 0 and not p1.InCutscene then
			_G.PlayerRunning = false;
			u4 = "Up";
			v37.WalkSpeed = 16;
		end;
	end);
	return v1;
end;
