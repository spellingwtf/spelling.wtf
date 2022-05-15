-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = false;
	local function u2(p2)
		if u1 and not p2 then
			return;
		end;
		if u1 and p2 then
			return u1[tostring(p2)];
		end;
		local v2 = p1.ClientDatabase:PDSFunc("GetTrainersBeaten");
		u1 = v2;
		if not p2 then
			return;
		end;
		return v2[tostring(p2)];
	end;
	local v3 = l__Utilities__1.Class({
		ClassName = "NPC"
	}, function(p3, p4)
		p3.Model = p4;
		p3.Model:WaitForChild("HumanoidRootPart");
		p3.hrpcf = p4.HumanoidRootPart.CFrame;
		p3.hrp = p4.HumanoidRootPart;
		p3.Human = p4.Humanoid;
		p3.Human.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
		p3.Exists = true;
		if p4:FindFirstChild("Trainer") then
			p3.Defeated = u2(p4.Trainer.Value);
		end;
		p3:SetCharacter();
		p3:DisableStates();
		p3:Interact();
		p3:Animate();
		return p3;
	end);
	local u3 = nil;
	function v3.SetCharacter(p5)
		u3 = game.Players.LocalPlayer.Character;
	end;
	function v3.FindPart(p6, p7)
		return p6.Model:FindFirstChild(p7);
	end;
	function v3.TweenFront(p8)
		p1.Camera:Tween(l__Utilities__1:GetFront(p8.Model.HumanoidRootPart, 3) + Vector3.new(0, 1.75, 0), 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		p8:RotateToCamera();
	end;
	local l__Tween__4 = p1.Tween;
	function v3.MoveToWait(p9, p10, p11, p12)
		p9.Waiting = true;
		local v4 = 0;
		while p9.Waiting do
			if not p9.Looking then
				p9:LookAt(p10.p);
			end;
			v4 = v4 + 1;
			if (p10.p - p9.hrp.Position).magnitude <= 3.5 or v4 > 30000 then
				p9.Waiting = false;
			end;
			l__Utilities__1.Halt(0.033);		
		end;
		p11:Stop();
		if not p12 then
			l__Tween__4:PlayTween(p9.hrp, {
				CFrame = p10
			}, true, 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			l__Utilities__1.Halt(0.35);
		end;
	end;
	function v3.WalkTo(p13, p14, p15, p16, p17)
		if p16 == nil then
			p16 = 8748449688;
		end;
		p13.Human.AutoRotate = true;
		p13.hrp.Anchored = false;
		l__Utilities__1.Halt(0.1);
		local v5 = p13:PlayAnim(p16);
		p13.Human.WalkSpeed = p15 and 16;
		l__Utilities__1.Halt(0.1);
		p13.Human:MoveTo(p14.p);
		p13:MoveToWait(p14, v5, p17);
		p13.hrp.Anchored = true;
	end;
	function v3.MakeIcon(p18)
		if p18.Icon then
			p18.Icon:Destroy();
		end;
		p18.Icon = p1.Services.ReplicatedStorage.Guis.TrainerBattle:Clone();
		p18.Icon.Parent = p18.Model.HumanoidRootPart;
	end;
	local u5 = { "HumanoidRootPart", "Head", "LowerTorso" };
	function v3.Raycast(p19)
		for v6, v7 in pairs(u5) do
			local v8 = p19.Model:FindFirstChild(v7);
			if v8 then
				local l__Position__9 = v8.Position;
				local v10, v11 = workspace:FindPartOnRayWithIgnoreList(Ray.new(l__Position__9, (CFrame.new(l__Position__9 + v8.CFrame.lookVector, l__Position__9).p - l__Position__9).unit * 400), { p19.Model });
				if v10:IsDescendantOf(u3) and not v10:FindFirstChild("Follower") then
					return true;
				end;
			end;
		end;
		return false;
	end;
	function v3.AttachCapsule(p20, p21)
		p20.Capsule = p1.Capsule.new({}, p21, String);
		p20.Capsule:SetParent(p20.Model);
		p20.Motor6D = Instance.new("Motor6D", p20.Capsule.Model.Bottom);
		p20.Motor6D.Name = "RightHand";
		p20.Motor6D.Part0 = p20.Model.RightHand;
		p20.Motor6D.Part1 = p20.Capsule.Model.Bottom;
		local v12 = Instance.new("Animation", p20.Motor6D);
		v12.AnimationId = "http://www.roblox.com/asset/?id=4632555088";
		p20.CapsuleAnimTrack = p20.Model.Humanoid:LoadAnimation(v12);
		p20.CapsuleAnimTrack:Play();
	end;
	function v3.Interact(p22)
		if p22.Model:FindFirstChild("Interact") then
			p22.Table = require(p22.Model:FindFirstChild("Interact"))(p1, p22);
			if p22.Table.RunAtRunTime then
				p22.Table:RunAtRunTime(p1, p22);
			end;
			if not p22.Table.NoLook then
				p22:Look();
			end;
			function p22.Event()
				if not p22 or p22.Destroyed then
					return;
				end;
				if p1.Battle.CurrentBattle or p1.Battle.RequestBattle then
					return;
				end;
				p22.Active = true;
				if p22:PlayerBehindCheck() and not p22.Table.NoRotate and (not p22.Table.CutsceneCheck or not p22.Table.CutsceneCheck()) then
					p22:Rotate();
				end;
				p1.Dialogue:Talk(p22.Table, p22);
				p22.Active = false;
				if p22 and not p22.Destroyed and not p22.Moved then
					p22:ReturnOldPos();
				end;
			end;
			return;
		end;
		if p22.Model:FindFirstChild("Trainer") then
			local l__Value__13 = p22.Model.Trainer.Value;
			p22.Trainer = true;
			p22.Defeated = p22.Defeated or u2(l__Value__13);
			local u6 = p1.Trainers.Battles[l__Value__13].Class .. " " .. p1.Trainers.Battles[l__Value__13].Name;
			local u7 = p1.Trainers.Battles[l__Value__13];
			function p22.Event()
				if not p1.Battle.CurrentBattle and not p1.Battle.RequestBattle then
					p1.TrainerEncounter = true;
					p22.Active = true;
					p22:Rotate();
					local v14 = p22:ConvertText(l__Value__13);
					p1.Battle.RequestBattle = true;
					p1.Controls:ToggleWalk(false);
					p1.Gui:SayText(u6, v14[1], p22);
					if not p22.Defeated then
						local v15, v16 = p1.Battle:TrainerBattle(l__Value__13, p22.Model);
						if not u7.Music then
							p1.Music:PlaySong("BattleTheme1");
						else
							p1.Music:PlaySong(u7.Music);
						end;
						local v17 = v15:Wait();
						p22.Defeated = v17;
						if v17 ~= true then
							p1.Menu:Invisible();
							p1.Wipeout[v16].func();
						end;
					end;
					p1.TrainerEncounter = nil;
					p1.Battle.RequestBattle = nil;
					p22.Active = false;
				end;
			end;
			l__Utilities__1.FastSpawn(function()
				while p22 and p22.Model and p22.Model.PrimaryPart and not p22.Defeated do
					if not p22:PlayerBehindCheck() and not p22.Defeated and not p22.Active and not p1.Battle.CurrentBattle and not p1.Battle.RequestBattle and p1.Loaded then
						if p22:Raycast() then
							p1.TrainerEncounter = true;
							if not u7.Music then
								p1.Music:PlaySong("BattleTheme1");
							else
								p1.Music:PlaySong(u7.Music);
							end;
							p1.Controls:ToggleWalk(false);
							p22.Active = true;
							l__Utilities__1.Halt(0.5);
							l__Utilities__1.FastSpawn(function()
								p22:Rotate();
							end);
							p1.Cursor:SetTalking(true);
							p1.Camera:Scriptable(p1.Camera:GetCF());
							p1.Battle.RequestBattle = true;
							p1.Controls:ToggleWalk(false);
							local v18 = p22:PlayAnim("Wave");
							p22:TweenFront();
							l__Utilities__1.Halt(0.6);
							v18:Stop();
							p1.Gui:SayText(u6, p22:ConvertText(l__Value__13)[1]);
							p1.Controls:ToggleWalk(false);
							local v19, v20 = p1.Battle:TrainerBattle(l__Value__13, p22.Model);
							local v21 = v19:Wait();
							p1.TrainerEncounter = nil;
							p1.Cursor:SetTalking(false);
							if v21 ~= true then
								p1.Menu:Invisible();
								p1.Wipeout[v20].func();
							end;
							p22.Defeated = v21;
							p22.Active = false;
							p1.Battle.RequestBattle = nil;
							return;
						end;
					elseif p22.Defeated then
						p22.Active = false;
						return;
					end;
					p1.Services.RunService.RenderStepped:wait();				
				end;
			end);
		end;
	end;
	function v3.Say(p23, p24, p25)
		p1.Dialogue:SaySimple(p24, p23, p25 or p23.Model.Name);
	end;
	function v3.ConvertText(p26, p27)
		local v22 = p1.Trainers.Battles[p27];
		return p26.Defeated and v22.BeatenInteract or v22.Interact;
	end;
	function v3.DisableStates(p28)
		for v23, v24 in pairs({ Enum.HumanoidStateType.Climbing, Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Flying, Enum.HumanoidStateType.Freefall, Enum.HumanoidStateType.Seated, Enum.HumanoidStateType.Jumping, Enum.HumanoidStateType.Landed, Enum.HumanoidStateType.PlatformStanding, Enum.HumanoidStateType.Swimming, Enum.HumanoidStateType.Ragdoll, Enum.HumanoidStateType.GettingUp }) do
			p28.Human:SetStateEnabled(v24, false);
		end;
		p28.Human:SetStateEnabled(Enum.HumanoidStateType.Dead, true);
		p28.Human:SetStateEnabled(Enum.HumanoidStateType.Running, true);
		p28.Human:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true);
	end;
	function v3.PlayAnim(p29, p30)
		local v25 = p29.Human:LoadAnimation(l__Utilities__1:Create("Animation")({
			AnimationId = p1.MiscDB.Animations[p30] and "http:/www.roblox.com/asset/?id=" .. p1.MiscDB.Animations[p30].Id or "http:/www.roblox.com/asset/?id=" .. p30, 
			Parent = p29.NPCModel
		}));
		v25:Play();
		return v25;
	end;
	function v3.Distance(p31)
		if not p31.Model.PrimaryPart then
			return 0;
		end;
		return (u3.PrimaryPart.Position - p31.Model.PrimaryPart.Position).magnitude;
	end;
	function v3.PlayerBehindCheck(p32)
		if not p32.Model and not p32.Model.PrimaryPart then
			return true;
		end;
		if p32.Model.PrimaryPart and not p32.Model.PrimaryPart:IsDescendantOf(game) then
			return true;
		end;
		if not u3 or not u3:FindFirstChild("HumanoidRootPart") or not p32.Model.PrimaryPart then
			return false;
		end;
		if p32.Model.PrimaryPart.CFrame.lookVector:Dot(u3.PrimaryPart.Position - p32.Model.PrimaryPart.CFrame.Position) < 0 then
			return true;
		end;
		return false;
	end;
	function v3.BlueTeleportFade(p33, p34)
		p33.AllParts = {};
		for v26, v27 in pairs(p33.Model:GetDescendants()) do
			if v27:IsA("BasePart") then
				local v28 = nil;
				if v27:IsA("MeshPart") then
					v28 = v27.TextureID;
				end;
				p33.AllParts[v27] = {
					BrickColor = v27.BrickColor, 
					TextureId = v28, 
					Transparency = v27.Transparency
				};
			elseif v27:IsA("BodyColors") then
				p33.AllParts[v27] = {
					HeadColor3 = v27.HeadColor3, 
					LeftArmColor3 = v27.LeftArmColor3, 
					LeftLegColor3 = v27.LeftLegColor3, 
					RightArmColor3 = v27.RightArmColor3, 
					RightLegColor3 = v27.RightLegColor3, 
					TorsoColor3 = v27.TorsoColor3
				};
			elseif v27:IsA("Decal") then
				p33.AllParts[v27] = {
					Transparency = v27.Transparency
				};
			end;
		end;
		local l__Color__29 = BrickColor.new("Cyan").Color;
		local v30 = p34 and 1.5;
		for v31, v32 in pairs(p33.AllParts) do
			if v31:IsA("BasePart") then
				if v31:IsA("MeshPart") then
					v31.TextureID = "";
				end;
				l__Tween__4:PlayTween(v31, {
					Transparency = 1, 
					Color = l__Color__29
				}, true, v30, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			elseif v31:IsA("BodyColors") then
				l__Tween__4:PlayTween(v31, {
					HeadColor3 = l__Color__29, 
					LeftArmColor3 = l__Color__29, 
					LeftLegColor3 = l__Color__29, 
					RightArmColor3 = l__Color__29, 
					RightLegColor3 = l__Color__29, 
					TorsoColor3 = l__Color__29
				}, true, v30 / 3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			elseif v31:IsA("Decal") then
				l__Tween__4:PlayTween(v31, {
					Transparency = 1
				}, true, v30, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			end;
		end;
		l__Utilities__1.Halt(v30 + 0.5);
	end;
	function v3.BlueTeleportFadeIn(p35)
		if not p35.AllParts then
			return;
		end;
		for v33, v34 in pairs(p35.AllParts) do
			if v33:IsA("BasePart") then
				if v33:IsA("MeshPart") then
					v33.TextureID = v34.TextureId;
				end;
				l__Tween__4:PlayTween(v33, {
					Transparency = v34.Transparency, 
					Color = v34.BrickColor.Color
				}, true, 1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			elseif v33:IsA("BodyColors") then
				l__Tween__4:PlayTween(v33, v34, true, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			elseif v33:IsA("Decal") then
				l__Tween__4:PlayTween(v33, {
					Transparency = v34.Transparency
				}, true, 1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			end;
		end;
		l__Utilities__1.Halt(2);
		p35.AllParts = nil;
	end;
	function v3.ImmediateTeleport(p36)
		for v35, v36 in pairs(p36.AllParts) do
			if v35:IsA("BasePart") then
				if v35:IsA("MeshPart") then
					v35.TextureID = v36.TextureId;
				end;
				v35.Transparency = v36.Transparency;
				v35.Color = v36.BrickColor.Color;
			elseif v35:IsA("BodyColors") then
				for v37, v38 in pairs(v36) do
					v35[v37] = v38;
				end;
			elseif v35:IsA("Decal") then
				v35.Transparency = v36.Transparency;
			end;
		end;
		p36.AllParts = nil;
	end;
	function v3.Disappear(p37)
		for v39 = 1, 10 do
			for v40, v41 in pairs(p37.Model:GetDescendants()) do
				if v41:IsA("BasePart") then
					v41.Transparency = v41.Transparency + 0.1;
				end;
			end;
			l__Utilities__1.Halt(0.1);
		end;
		p37.Exists = nil;
		p37:Destroy();
	end;
	local l__CFrame_new__8 = CFrame.new;
	local l__CFrame_Angles__9 = CFrame.Angles;
	local l__math_asin__10 = math.asin;
	function v3.Look(p38, p39)
		local l__Neck__42 = p38.Model:FindFirstChild("Neck", true);
		local u11 = p39 and 12;
		local l__C0__12 = l__Neck__42.C0;
		l__Utilities__1.FastSpawn(function()
			while p38 and p38.Model and u3 and not p38.Looking do
				u3 = game.Players.LocalPlayer.Character;
				if u3 and u3:FindFirstChild("HumanoidRootPart") then
					local v43 = (CFrame.new(p38.hrp.Position, u3.PrimaryPart.Position):inverse() * p38.hrp.CFrame).lookVector * -1;
					local l__Y__44 = l__Neck__42.C0.Y;
					if l__Neck__42 and p38.Exists and p38:Distance() < u11 and not p38:PlayerBehindCheck() and not p38.InterruptLook then
						if not p38.AlreadyLooking then
							p38.AlreadyLooking = true;
							p1.Tween:MakeTween(l__Neck__42, {
								C0 = l__CFrame_new__8(0, l__Y__44, 0) * l__CFrame_Angles__9(0, -l__math_asin__10(v43.x), 0) * l__CFrame_Angles__9(l__math_asin__10(v43.y), 0, 0)
							}, true, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
							l__Utilities__1.Halt(0.35);
						else
							l__Neck__42.C0 = l__CFrame_new__8(0, l__Y__44, 0) * l__CFrame_Angles__9(0, -l__math_asin__10(v43.x), 0) * l__CFrame_Angles__9(l__math_asin__10(v43.y), 0, 0);
						end;
					elseif p38.AlreadyLooking or p38.InterruptLook then
						p1.Tween:MakeTween(l__Neck__42, {
							C0 = l__C0__12
						}, true, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
						l__Utilities__1.Halt(0.35);
						p38.AlreadyLooking = nil;
					end;
				end;
				p1.Services.RunService.Stepped:wait();			
			end;
			if p38 and p38.Model then
				p1.Tween:MakeTween(l__Neck__42, {
					C0 = l__C0__12
				}, true, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			end;
		end);
	end;
	function v3.LookAt(p40, p41)
		local l__Neck__45 = p40.Model:FindFirstChild("Neck", true);
		local l__Y__13 = l__Neck__45.C0.Y;
		local u14 = (CFrame.new(p40.hrp.Position, p41):inverse() * p40.hrp.CFrame).lookVector * -1;
		l__Utilities__1.FastSpawn(function()
			p1.Tween:MakeTween(l__Neck__45, {
				C0 = l__CFrame_new__8(0, l__Y__13, 0) * l__CFrame_Angles__9(0, -l__math_asin__10(u14.x), 0) * l__CFrame_Angles__9(l__math_asin__10(u14.y), 0, 0)
			}, true, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			l__Utilities__1.Halt(0.35);
			p40.AlreadyLooking = true;
		end);
	end;
	function v3.ReturnOldPos(p42)
		if p42.Return then
			p1.Tween:TweenCFrame(p42.Model.HumanoidRootPart, p42.Return, true, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
			p42.Return = nil;
		end;
	end;
	function v3.RotateTo(p43, p44)
		if p43.Model:FindFirstChild("HumanoidRootPart") then
			local l__Position__46 = p43.Model.HumanoidRootPart.Position;
			p43.InterruptLook = true;
			if not p43.Return then
				p43.Return = p43.Model.HumanoidRootPart.CFrame;
			end;
			p1.Tween:TweenCFrame(p43.Model.HumanoidRootPart, CFrame.new(l__Position__46, Vector3.new(p44.X, l__Position__46.Y, p44.Z)), true, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
			l__Utilities__1.Halt(0.5);
			p43.InterruptLook = nil;
		end;
	end;
	function v3.RotateToCamera(p45)
		local l__p__47 = workspace.CurrentCamera.CFrame.p;
		local l__Position__48 = p45.Model.HumanoidRootPart.Position;
		p45.Model.HumanoidRootPart.CFrame = CFrame.new(l__Position__48, Vector3.new(l__p__47.X, l__Position__48.Y, l__p__47.Z));
	end;
	function v3.Teleport(p46, p47)
		l__Utilities__1.Halt(0.15);
		p46.hrp.CFrame = p47;
		p46.Moved = true;
	end;
	function v3.Rotate(p48)
		if p48.Model:FindFirstChild("HumanoidRootPart") then
			local l__Position__49 = p48.Model.HumanoidRootPart.Position;
			p48.InterruptLook = true;
			if not p48.Return then
				p48.Return = p48.Model.HumanoidRootPart.CFrame;
			end;
			local l__Character__50 = game.Players.LocalPlayer.Character;
			if l__Character__50 then
				local l__Position__51 = l__Character__50.HumanoidRootPart.Position;
				p1.Tween:TweenCFrame(p48.Model.HumanoidRootPart, CFrame.new(l__Position__49, Vector3.new(l__Position__51.X, l__Position__49.Y, l__Position__51.Z)), true, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
				l__Utilities__1.Halt(0.5);
				p48.InterruptLook = nil;
			end;
		end;
	end;
	function v3.Animate(p49)
		local l__Model__52 = p49.Model;
		if not l__Model__52 then
			return;
		end;
		local l__hrp__53 = p49.hrp;
		if not l__hrp__53 then
			return;
		end;
		local v54 = {};
		for v55, v56 in pairs(l__hrp__53:GetConnectedParts(true)) do
			v54[v56] = true;
		end;
		local l__Head__57 = l__Model__52:FindFirstChild("Head");
		for v58, v59 in pairs(l__Model__52:GetChildren()) do
			if v59:IsA("BasePart") and v59 ~= l__hrp__53 then
				if not v54[v59] then
					pcall(function()
						l__Utilities__1:Create("Weld")({
							Part0 = l__Head__57, 
							Part1 = v59, 
							C1 = v59.CFrame:inverse() * l__Head__57.CFrame, 
							Parent = l__Head__57
						});
					end);
				end;
				if v59.Name ~= l__Head__57 then
					v59.Anchored = false;
				end;
			end;
		end;
		l__hrp__53.Anchored = true;
		if p49.Table and p49.Table.Idle then
			p49.IdleAnim = p49:PlayAnim(p49.Table.Idle);
		elseif p49.Idle then
			p49.IdleAnim = p49:PlayAnim(p49.Idle);
		else
			p49.IdleAnim = p49:PlayAnim("DefaultIdle");
		end;
		p49.Animated = true;
	end;
	function v3.SetCollisions(p50, p51)
		for v60, v61 in pairs(p50.Model:GetDescendants()) do
			if v61:IsA("BasePart") then
				game:GetService("PhysicsService"):SetPartCollisionGroup(v61, p51);
			end;
		end;
	end;
	function v3.Destroy(p52)
		if p52.Model then
			p52.Model:Destroy();
		end;
		p52.Model = nil;
		for v62, v63 in pairs(p52) do
			p52[v62] = nil;
		end;
		p52.Destroyed = true;
		setmetatable(p52, nil);
		p52 = nil;
	end;
	function v3.SetLoadFalse(p53)
		u1 = false;
	end;
	return v3;
end;
