-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {};
	local u1 = nil;
	local l__CurrentCamera__2 = game.Workspace.CurrentCamera;
	function v1.Scriptable(p2, p3, p4)
		if not p4 then
			u1 = l__CurrentCamera__2.CFrame;
		end;
		l__CurrentCamera__2.CameraType = Enum.CameraType.Scriptable;
		l__CurrentCamera__2.CFrame = p3;
	end;
	function v1.GetCurrentCamera(p5)
		return l__CurrentCamera__2;
	end;
	function v1.SavePosition(p6)
		u1 = l__CurrentCamera__2.CFrame;
	end;
	function v1.MakeNewShaker(p7)
		if p1.CameraShakerInstance then
			p1.CameraShakerInstance:Destroy();
		end;
		p1.CameraShakerInstance = p1.CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p8)
			l__CurrentCamera__2.CFrame = l__CurrentCamera__2.CFrame * p8;
		end);
	end;
	function v1.Earthquake(p9)
		v1:MakeNewShaker();
		p1.CameraShakerInstance:Start();
		p1.CameraShakerInstance:ShakeSustain(p1.CameraShaker.Presets.Earthquake);
	end;
	function v1.Bump(p10)
		v1:MakeNewShaker();
		p1.CameraShakerInstance:Start();
		p1.CameraShakerInstance:Shake(p1.CameraShaker.Presets.Bump);
	end;
	function v1.Vibration(p11)
		v1:MakeNewShaker();
		p1.CameraShakerInstance:Start();
		p1.CameraShakerInstance:ShakeSustain(p1.CameraShaker.Presets.Vibration);
	end;
	function v1.StopShake(p12)
		if p1.CameraShakerInstance then
			p1.CameraShakerInstance:Destroy();
		end;
	end;
	function v1.GetCF(p13)
		return l__CurrentCamera__2.CFrame;
	end;
	function v1.SetCFrame(p14, p15)
		l__CurrentCamera__2.CFrame = p15;
	end;
	local l__Utilities__3 = p1.Utilities;
	function v1.GetBehind(p16)
		l__CurrentCamera__2.CFrame = l__Utilities__3.GetBehind(game.Players.LocalPlayer.Character, 10);
	end;
	local u4 = nil;
	function v1.Cancel(p17)
		if u4 then
			u4:Cancel();
		end;
	end;
	function v1.Return(p18)
		if u4 then
			u4:Cancel();
		end;
		if u1 then
			l__CurrentCamera__2.CFrame = u1;
		end;
		u1 = nil;
		l__CurrentCamera__2.CameraType = Enum.CameraType.Custom;
		l__CurrentCamera__2.CameraSubject = p1.p.Character.Humanoid;
	end;
	function v1.NewChunkPov(p19)
		if not p1.p.Character then
			local v2 = p1.p.CharacterAdded:wait();
		end;
		l__CurrentCamera__2.CFrame = CFrame.new((l__Utilities__3:GetBack(p1.p.Character.HumanoidRootPart, 20) + Vector3.new(0, 10, 0)).p, p1.p.Character.HumanoidRootPart.Position);
		l__CurrentCamera__2.CameraType = Enum.CameraType.Custom;
		l__CurrentCamera__2.CameraSubject = p1.p.Character.Humanoid;
	end;
	function v1.Default(p20)
		l__CurrentCamera__2.FieldOfView = 70;
	end;
	local l__TweenService__5 = game:GetService("TweenService");
	function v1.Tween(p21, p22, p23, p24, p25)
		l__TweenService__5:Create(l__CurrentCamera__2, TweenInfo.new(p23, p24, p25), {
			CFrame = p22
		}):Play();
		l__Utilities__3.Halt(p23);
	end;
	function v1.TitleTween(p26, p27, p28, p29, p30)
		local v3 = l__TweenService__5:Create(l__CurrentCamera__2, TweenInfo.new(p28, p29, p30), {
			CFrame = p27
		});
		v3:Play();
		if u4 then
			u4:Destroy();
		end;
		u4 = v3;
		return v3;
	end;
	function v1.ReturnCutscene()
		return Cutsceen;
	end;
	local u6 = false;
	function v1.SetCutscene(p31, p32)
		u6 = p31;
		if p32 == "NoCamera" then
			return;
		end;
		if p31 == true then
			l__CurrentCamera__2.CameraType = Enum.CameraType.Scriptable;
			return;
		end;
		l__CurrentCamera__2.CameraType = Enum.CameraType.Custom;
	end;
	local u7 = Enum.RenderPriority.Character.Value - 5;
	local function u8()
		local l__Character__4 = game.Players.LocalPlayer.Character;
		if l__Character__4 then
			for v5, v6 in pairs(l__Character__4:GetDescendants()) do
				if v6:IsA("BasePart") then
					v6.LocalTransparencyModifier = 0;
				end;
			end;
		end;
	end;
	function v1.NoTransparent(p33)
		game:GetService("RunService"):BindToRenderStep("NoTransparent", u7, function()
			u8();
		end);
	end;
	function v1.StopNoTransparent(p34)
		p1.Services.RunService:UnbindFromRenderStep("NoTransparent");
	end;
	function v1.Zoom(p35)
		for v7 = 70, 120, 2 do
			l__CurrentCamera__2.FieldOfView = v7;
			l__Utilities__3.Halt();
		end;
		for v8 = 110, 10, -10 do
			l__CurrentCamera__2.FieldOfView = v8;
			l__Utilities__3.Halt();
		end;
	end;
	local u9 = nil;
	function v1.NotOverhead(p36)
		p1.p.CameraMinZoomDistance = 0.5;
		p1.p.CameraMaxZoomDistance = 18;
		if u9 then
			p1.Services.RunService:UnbindFromRenderStep("OverheadCamera");
		end;
		l__CurrentCamera__2.CameraType = "Custom";
		l__CurrentCamera__2.CameraSubject = p1.p.Character.Humanoid;
		u9 = nil;
		l__Utilities__3.Halt(0.1);
	end;
	function v1.TweenToModel(p37, p38, p39)
		v1:Tween(CFrame.new(p38.PrimaryPart.Position - Vector3.new(-12, -8, -0.1), p38.PrimaryPart.Position), p39, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
		l__Utilities__3.Halt(math.max(0.5, p39 - 0.5));
	end;
	local u10 = nil;
	function v1.StopFocus(p40)
		u10 = nil;
		p1.Services.RunService:UnbindFromRenderStep("FocusCamera");
	end;
	function v1.FocusOther(p41, p42)
		l__CurrentCamera__2.CameraType = Enum.CameraType.Scriptable;
		u10 = p42;
		p1.p.CameraMinZoomDistance = 5;
		p1.p.CameraMaxZoomDistance = 5;
		u9 = true;
		game:GetService("RunService"):BindToRenderStep("FocusCamera", u7, function()
			if u10 == p42 and not u6 then
				workspace.CurrentCamera.CoordinateFrame = CFrame.new(p42.HumanoidRootPart.Position - Vector3.new(-12, -8, -0.1), p42.HumanoidRootPart.Position);
				u8();
			end;
		end);
	end;
	function v1.TweenOverhead(p43)
		v1:Tween(CFrame.new(p1.p.Character.PrimaryPart.Position - Vector3.new(-12, -8, -0.1), p1.p.Character.PrimaryPart.Position), 0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		u6 = nil;
	end;
	function v1.SetScriptable(p44)
		l__CurrentCamera__2.CameraType = Enum.CameraType.Scriptable;
	end;
	function v1.Overhead(p45)
		v1:SavePosition();
		l__CurrentCamera__2.CameraType = Enum.CameraType.Scriptable;
		p1.p.CameraMinZoomDistance = 5;
		p1.p.CameraMaxZoomDistance = 5;
		u9 = true;
		game:GetService("RunService"):BindToRenderStep("OverheadCamera", u7, function()
			if p1.p.Character and not u6 and not u10 then
				workspace.CurrentCamera.CoordinateFrame = CFrame.new(p1.p.Character.PrimaryPart.Position - Vector3.new(-12, -8, -0.1), p1.p.Character.PrimaryPart.Position);
				u8();
			end;
		end);
	end;
	function v1.ScreenPointToRay(p46, p47, p48, p49)
		local v9 = l__CurrentCamera__2:ScreenPointToRay(p47, p48, p49);
		return CFrame.new(v9.Origin, v9.Origin + v9.Direction);
	end;
	function v1.SetInBuildingCamera(p50, p51)
		u6 = true;
		l__CurrentCamera__2.CFrame = p51;
	end;
	function v1.InBuildingCamera(p52, p53, p54, p55, p56)
		u6 = true;
		l__Utilities__3.Halt(0.1);
		v1:Tween(p53, p54, p55, p56);
		l__Utilities__3.Halt(p54);
	end;
	function v1.StopInBuildingCutscene(p57)
		u6 = nil;
	end;
	return v1;
end;
