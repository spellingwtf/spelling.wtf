-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {};
	local l__Utilities__2 = p1.Utilities;
	function v1.LoadImage(p2, p3)
		local l__ContentProvider__1 = game:GetService("ContentProvider");
		local u2 = { p3 };
		l__Utilities__2.FastSpawn(function()
			l__ContentProvider__1:PreloadAsync(u2);
		end);
	end;
	local u3 = { 0.5, 0.45, 0.4, 0.36, 0.35, 0.34, 0.33, 0.32, 0.31, 0.3, 0.28, 0.27, 0.25, 0.23, 0.21, 0.19, 0.17, 0.15, 0.13, 0.11 };
	function v1.DialogueTextSize(p4, p5, p6)
		p5.Fits.Text = p6;
		local l__AbsoluteSize__3 = p5.AbsoluteSize;
		local v4 = 0.495;
		for v5, v6 in pairs(u3) do
			p5.Fits.TextSize = v6 * l__AbsoluteSize__3.Y;
			if p5.Fits.TextFits then
				v4 = v6;
				break;
			end;
		end;
		v1:ResizeText(p5, v4 * l__AbsoluteSize__3.Y);
	end;
	function v1.SetGenderIcon(p7, p8, p9)
		local v7 = p1.MiscDB.GenderIcons[p8.Gender and "U"];
		p9.Image = v7.Image;
		p9.ImageColor3 = v7.Color;
	end;
	function v1.SayChoiceText(p10, p11, p12, p13, p14, p15)
		local v8 = {};
		local v9 = {};
		local v10 = {
			Talking = p12, 
			YesNo = true
		};
		local v11 = {};
		local v12 = {};
		v12[1] = function()
			p14();
		end;
		v11.Talk = v12;
		v10.Yes = v11;
		local v13 = {};
		local v14 = {};
		v14[1] = function()
			p15();
		end;
		v13.Talk = v14;
		v10.No = v13;
		v9[1] = v10;
		v8.Talk = v9;
		p1.Dialogue:Run(p1.Dialogue:GetStageInfo(v8, nil, true), p13, p11, true);
	end;
	function v1.SayText(p16, p17, p18, p19, p20, p21)
		p1.CurrentlyTalking = true;
		p1.Dialogue:Run(p1.Dialogue:GetStageInfo({
			Talk = { {
					Talking = p18
				} }, 
			Name = p17
		}, nil, true), p19, p17, p20, nil, nil, p21);
		p1.CurrentlyTalking = nil;
	end;
	local u4 = nil;
	function v1.AreaPopup(p22, p23, p24)
		l__Utilities__2.FastSpawn(function()
			if u4 then
				return;
			end;
			local l__AreaPopup__15 = p1.guiholder.AreaPopup;
			l__AreaPopup__15.ClipMusic.Visible = false;
			l__AreaPopup__15.Size = UDim2.new(0, 0, 0, 2);
			l__AreaPopup__15.Clip.AreaName.Position = UDim2.new(0, 0, 1, 0);
			l__AreaPopup__15.Clip.AreaName.Text = p23;
			l__AreaPopup__15.Clip.AreaName.DropShadow.Text = p23;
			l__AreaPopup__15.Fits.Text = p23;
			local v16 = l__AreaPopup__15.Fits.TextBounds.X;
			if p24 then
				l__AreaPopup__15.ClipMusic.SongName.Position = UDim2.new(0, 0, -1, 0);
				p1.Gui:ChangeText(l__AreaPopup__15.ClipMusic.SongName, "\240\159\142\181 " .. p24);
				l__AreaPopup__15.Fits.Text = "\240\159\142\181 " .. p24;
				if v16 < l__AreaPopup__15.Fits.TextBounds.X then
					v16 = l__AreaPopup__15.Fits.TextBounds.X;
				end;
				l__AreaPopup__15.ClipMusic.Visible = true;
			end;
			u4 = true;
			l__AreaPopup__15.Visible = true;
			l__AreaPopup__15:TweenSize(UDim2.new(0, v16 + 10, 0, 2), "Out", "Linear", 0.25, true);
			wait(0.25);
			l__AreaPopup__15.Clip.AreaName:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Linear", 0.5, true);
			l__AreaPopup__15.ClipMusic.SongName:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Linear", 0.5, true);
			wait(2);
			l__AreaPopup__15.ClipMusic.SongName:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Linear", 0.5, true);
			l__AreaPopup__15.Clip.AreaName:TweenPosition(UDim2.new(0, 0, 1, 0), "Out", "Linear", 1, true);
			wait(1);
			l__AreaPopup__15:TweenSize(UDim2.new(0, 0, 0, 2), "Out", "Linear", 0.25, true);
			wait(0.25);
			l__AreaPopup__15.Visible = false;
			u4 = false;
		end);
	end;
	local u5 = false;
	function v1.ResetSay(p25)
		u5 = false;
	end;
	local u6 = l__Utilities__2.Signal();
	local u7 = false;
	function v1.Say(p26, p27, p28)
		local v17 = p1.Settings:Get("TextSpeed");
		local v18 = false;
		if p28:find("%[LAST%]") then
			p28 = p28:gsub("%[LAST%]", "");
			v18 = true;
		end;
		if p28:find("%[NONEXT%]") then
			p28 = p28:gsub("%[NONEXT%]", "");
			local v19 = false;
		elseif not p27.Parent:FindFirstChild("Next") then
			v19 = false;
		else
			v19 = false;
		end;
		local l__Next__20 = p27.Parent:FindFirstChild("Next");
		if l__Next__20 then
			if v19 then
				local u8 = false;
				local u9 = nil;
				u9 = l__Next__20.MouseButton1Click:Connect(function()
					p1.Sound:Play("BasicClick", math.random(90, 110) / 100);
					if u8 == false then
						u8 = true;
						return;
					end;
					if u8 == true then
						u9:Disconnect();
						u6:Fire();
					end;
				end);
			else
				l__Next__20.Position = UDim2.new(0.9, 1, 0.5, 0);
			end;
		end;
		v1:DialogueTextSize(p27, p28);
		if u5 == p28 then
			return;
		end;
		u5 = p28;
		u7 = true;
		l__Utilities__2.Halt(0.05);
		u7 = false;
		for v21 = 1, #p28, v17 and 2 do
			if u7 == true then
				return;
			end;
			if false == true then
				break;
			end;
			v1:ChangeText(p27, p28:sub(1, v21), nil, true);
			l__Utilities__2.Halt(0.033);
		end;
		v1:ChangeText(p27, p28, nil, true);
		if v18 then
			l__Next__20:TweenPosition(UDim2.new(0.9, 1, 0.5, 0), "Out", "Linear", 0.25, true);
			if nil then
				(nil):Disconnect();
			end;
			l__Utilities__2.Halt(0.5);
		elseif v19 and l__Next__20 then
			l__Next__20:TweenPosition(UDim2.new(1, 1, 0.5, 0), "Out", "Linear", 0.25, true);
			u6:Wait();
		else
			l__Utilities__2.Halt(0.5);
		end;
	end;
	local l__PlayerGui__10 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
	function v1.FadeFromBlack(p29)
		local l__Blackscreen__22 = l__PlayerGui__10.MainGui:WaitForChild("Blackscreen");
		l__Blackscreen__22.BackgroundTransparency = 0;
		l__Blackscreen__22.Visible = true;
		for v23 = 0, 1, 0.1 do
			l__Blackscreen__22.BackgroundTransparency = v23;
			l__Utilities__2.Halt();
		end;
		l__Blackscreen__22.BackgroundTransparency = 1;
		l__Blackscreen__22.Visible = false;
	end;
	function v1.ImmediateBlack(p30)
		local l__Blackscreen__24 = l__PlayerGui__10.MainGui:WaitForChild("Blackscreen");
		l__Blackscreen__24.BackgroundTransparency = 0;
		l__Blackscreen__24.Visible = true;
	end;
	function v1.FadeToBlack(p31)
		local l__Blackscreen__25 = l__PlayerGui__10.MainGui:WaitForChild("Blackscreen");
		l__Blackscreen__25.BackgroundTransparency = 1;
		l__Blackscreen__25.Visible = true;
		for v26 = 1, 0, -0.1 do
			l__Blackscreen__25.BackgroundTransparency = v26;
			l__Utilities__2.Halt();
		end;
		l__Blackscreen__25.BackgroundTransparency = 0;
	end;
	local u11 = {};
	function v1.TypeImage(p32, p33, p34)
		local v27 = p1.Typings:GetImage(p34);
		p33.Image = v27;
		u11[p33] = p34;
		p33.ImageRectSize = Vector2.new(200, 200);
		l__Utilities__2.FastSpawn(function()
			pcall(function()
				while p33:IsDescendantOf(game) and u11[p33] == p34 and p33.Image == v27 and p33.Parent.Parent.Visible == true do
					p33.ImageRectOffset = Vector2.new(0, 0);
					l__Utilities__2.Halt(0.1);
					p33.ImageRectOffset = Vector2.new(200, 0);
					l__Utilities__2.Halt(0.1);
					p33.ImageRectOffset = Vector2.new(0, 200);
					l__Utilities__2.Halt(0.1);				
				end;
			end);
		end);
	end;
	function v1.HealthColor(p35, p36)
		local l__Scale__28 = p36.Size.X.Scale;
		if l__Scale__28 > 0.75 then
			p36.ImageColor3 = Color3.fromRGB(46, 204, 113);
			return;
		end;
		if l__Scale__28 > 0.5 then
			p36.ImageColor3 = Color3.fromRGB(241, 196, 15);
			return;
		end;
		if l__Scale__28 > 0.25 then
			p36.ImageColor3 = Color3.fromRGB(243, 156, 18);
			return;
		end;
		p36.ImageColor3 = Color3.fromRGB(231, 76, 60);
	end;
	local function u12(p37, p38)
		for v29, v30 in pairs(p37:GetChildren()) do
			if v30:IsA(p38) then
				v30:Destroy();
			end;
		end;
	end;
	function v1.ViewportModule(p39, p40, p41)
		if p40 then
			u12(p40, "ViewportFrame");
		end;
		p41 = p41 or {};
		local v31 = l__Utilities__2:Create("ViewportFrame")({
			Size = UDim2.new(1, 0, 1, 0), 
			BackgroundTransparency = 1, 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			Parent = p40, 
			ZIndex = p40.ZIndex + 1
		});
		if p41 and p41.BackgroundColor3 then
			v31.BackgroundColor3 = p41.BackgroundColor3;
		end;
		local v32 = l__Utilities__2:Create("WorldModel")({
			Parent = v31
		});
		p39.Archivable = true;
		local v33 = p39:Clone();
		u12(v33, "BaseScript");
		v33.Parent = v32;
		local v34 = l__Utilities__2:Create("Camera")({
			Parent = v31
		});
		v31.CurrentCamera = v34;
		v34.CameraType = Enum.CameraType.Scriptable;
		local l__Position__35 = v33.Head.Position;
		v34.CFrame = CFrame.new(l__Position__35 + (v33.Head.CFrame.rightVector * (p41 and p41.Diagonal or -1) + v33.Head.CFrame.lookVector) * (p41 and p41.Zoom or 10), l__Position__35);
		local v36 = {};
		v36.__index = v36;
		local v37 = setmetatable({}, v36);
		v37.Frame = v31;
		v37.Camera = v34;
		v37.Model = v33;
		function v36.Destroy(p42)
			if p42.Model and p42.Model:IsDescendantOf(game) then
				p42.Model:Destroy();
			end;
			p40:ClearAllChildren();
			setmetatable(p42, nil);
		end;
		v37.LoadedAnimations = {};
		function v36.PlayAnim(p43, p44)
			p43.Model.Parent = workspace;
			p43.LoadedAnimations[p44] = p43.Model.Humanoid:LoadAnimation((l__Utilities__2:Create("Animation")({
				Parent = v33, 
				AnimationId = "rbxassetid://" .. (typeof(p44) == "number" and p44 or p1.MiscDB.Animations[p44].Id)
			})));
			p43.Model.Parent = v32;
			p43.LoadedAnimations[p44]:Play();
		end;
		function v36.StopAnim(p45, p46)
			if p45.LoadedAnimations[p46] then
				p45.LoadedAnimations[p46]:Stop();
			end;
		end;
		if not p41.StopAnimations then
			if p41.PlayAnim then
				v37:PlayAnim(p41.PlayAnim);
				return v37;
			else
				v37:PlayAnim("DefaultIdle");
				return v37;
			end;
		end;
		for v38, v39 in pairs((v33:FindFirstChild("Humanoid"):GetPlayingAnimationTracks())) do
			v39:Stop();
		end;
		return v37;
	end;
	function v1.DarkerColor(p47, p48)
		return Color3.new(p48.r / 2, p48.g / 2, p48.b / 2);
	end;
	function v1.ChangeText(p49, p50, p51, p52, p53)
		if p50:FindFirstChild("Fits") and not p53 then
			v1:DialogueTextSize(p50, p51);
		end;
		p50.Text = p51;
		if p52 then
			p50.TextColor3 = p52;
		end;
		if p50:FindFirstChild("DropShadow") then
			p50.DropShadow.Text = p51;
		end;
	end;
	function v1.ResizeText(p54, p55, p56)
		p55.TextSize = p56;
		if p55:FindFirstChild("DropShadow") then
			p55.DropShadow.TextSize = p56;
		end;
	end;
	function v1.InvisBlackscreen(p57)
		local l__Blackscreen__40 = l__PlayerGui__10.MainGui:WaitForChild("Blackscreen");
		l__Blackscreen__40.BackgroundTransparency = 1;
		l__Blackscreen__40.Visible = false;
	end;
	function v1.SetBlackscreen(p58)
		local l__Blackscreen__41 = l__PlayerGui__10.MainGui:WaitForChild("Blackscreen");
		l__Blackscreen__41.BackgroundTransparency = 0;
		l__Blackscreen__41.Visible = true;
	end;
	function v1.DiagonalBlackscreen(p59)
		local v42 = l__Utilities__2:Create("Frame")({
			Size = UDim2.new(0, 0, 0, 0), 
			Position = UDim2.new(0, 0, 0, -36), 
			BorderSizePixel = 0, 
			BackgroundColor3 = Color3.fromRGB(0, 0, 0), 
			Rotation = -45, 
			Visible = true, 
			ZIndex = 3
		});
		v42.Parent = p1.guiholder;
		v42:TweenSizeAndPosition(UDim2.new(3.2, 0, 3.2, 36), UDim2.new(-1.6, 0, -0.1, -36), "Out", "Quad", 1);
		l__Utilities__2.Halt(1);
		v1:SetBlackscreen();
		v42:Destroy();
	end;
	function v1.ShadeBlackscreen(p60)
		local v43 = l__Utilities__2:Create("Frame")({
			Size = UDim2.new(0, 0, 1, 36), 
			Position = UDim2.new(0, 0, 0, -36), 
			BorderSizePixel = 0, 
			BackgroundColor3 = Color3.fromRGB(0, 0, 0), 
			Visible = true, 
			ZIndex = 3
		});
		for v44 = 1, 10 do
			local v45 = v43:Clone();
			v45.Position = UDim2.new((v44 - 1) / 10, 0, 0, -36);
			v45.Parent = p1.guiholder.EncounterAnims;
			v45:TweenSize(UDim2.new(0.1, 0, 1, 36), "Out", "Quint", 0.5);
		end;
		l__Utilities__2.Halt(1);
		v43:Destroy();
		v1:SetBlackscreen();
		p1.guiholder.EncounterAnims:ClearAllChildren();
	end;
	function v1.RotatingSquares(p61)
		l__Utilities__2.FastSpawn(function()
			p1.Camera:Zoom();
		end);
		local v46 = l__Utilities__2:Create("Frame")({
			Size = UDim2.new(0.1, 1, 0.1, 0), 
			BorderSizePixel = 0, 
			BackgroundColor3 = Color3.fromRGB(0, 0, 0), 
			SizeConstraint = Enum.SizeConstraint.RelativeXX, 
			Rotation = 45, 
			Visible = false
		});
		v46.Parent = p1.guiholder;
		local l__Y__47 = v46.AbsoluteSize.Y;
		for v48 = 0, l__Y__47 * 6, l__Y__47 do
			for v49 = 0, 1, 0.1 do
				local v50 = v46:Clone();
				v50.Position = UDim2.new(v49, 0, 0, v48);
				v50.Rotation = 50;
				v50.Parent = p1.guiholder.EncounterAnims;
				v50.Visible = true;
				if v49 % 0.2 == 0.1 then
					l__Utilities__2.Halt();
				end;
				l__Utilities__2.FastSpawn(function()
					for v51 = 1, 10 do
						v50.Rotation = v50.Rotation - 5;
						l__Utilities__2.Halt();
					end;
				end);
			end;
		end;
		p1.GenericSignal:wait();
		v46:Destroy();
		v1:SetBlackscreen();
		p1.guiholder.EncounterAnims:ClearAllChildren();
	end;
	function v1.MakeColorSequence(p62, p63)
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, Color), ColorSequenceKeypoint.new(1, Color) });
	end;
	function v1.MakeSimpleColor(p64, p65)
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, p65), ColorSequenceKeypoint.new(1, p65) });
	end;
	function v1.Tint(p66, p67, p68, p69, p70)
		local l__Color__52 = p1.MiscDB.Tints[p69.Tint[1]].Color;
		pcall(function()
			if p68:FindFirstChild("ColorChanger") then
				p68.ColorChanger:Destroy();
			end;
		end);
		local v53 = l__Utilities__2:Create("UIGradient")({
			Color = v1:MakeSimpleColor(l__Color__52), 
			Parent = p68, 
			Name = "ColorChanger"
		});
		if #p69.Tint > 1 then
			local v54 = l__Utilities__2:Create("Color3Value")({
				Value = l__Color__52
			});
			v54.Changed:Connect(function()
				v53.Color = v1:MakeSimpleColor(v54.Value);
			end);
			l__Utilities__2.FastSpawn(function()
				local v55 = nil;
				while true do
					task.wait();
					if v53:IsDescendantOf(game) then
						break;
					end;				
				end;
				while v53:IsDescendantOf(game) do
					for v56 = 1, #p69.Tint do
						if not v53:IsDescendantOf(game) then
							break;
						end;
						v55 = p1.Tween:PlayTween(v54, {
							Value = p1.MiscDB.Tints[p69.Tint[v56]].Color
						}, true, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
						l__Utilities__2.Halt(1);
					end;				
				end;
				if v55 then
					v55:Cancel();
				end;
				if v54 then
					v54:Destroy();
				end;
				if v53 then
					v53:Destroy();
				end;
			end);
		end;
	end;
	function v1.GetSkinFront(p71, p72, p73, p74, p75)
		local v57 = {
			Name = p72, 
			Shiny = p73, 
			Gender = p74
		};
		if p75 == nil then
			v57.Skin = 0;
		else
			v57.Skin = p75;
		end;
		return p1.ClientDatabase:GetFrontSprite(v57);
	end;
	function v1.StaticImage(p76, p77, p78, p79, p80)
		local v58 = p79 and p1.ClientDatabase:GetFrontSprite(p78) or p1.ClientDatabase:GetBackSprite(p78);
		p77.ImageRectSize = Vector2.new(300, 300);
		if p77:FindFirstChild("ColorChanger") then
			p77.ColorChanger:Destroy();
		end;
		if p78.Tint and p78.Tint ~= 0 then
			v1:Tint(p77, p77, p78, true);
		end;
		v1:LoadImage(v58);
		p77.Image = v58;
		p77.Visible = true;
	end;
	function v1.GetGuiSize(p81, p82, p83)
		local v59 = p1.ClientDatabase:GetDoodleSize(p83, 0.8);
		return UDim2.new(v59, 0, v59, 0), UDim2.new(p82.Position.X.Scale, 0, p82.Position.Y.Scale + (0.8 - v59) / 2, 0), p1.ClientDatabase:GetFrontSprite(p83);
	end;
	local u13 = {};
	local l__Tween__14 = p1.Tween;
	function v1.Reboot(p84, p85)
		if u13[p85] then
			l__Tween__14:MakeTween(u13[p85], {
				ImageColor3 = p85.ImageColor3
			}, true, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			wait(0.3);
			u13[p85]:Destroy();
			u13[p85] = nil;
			p85.ImageTransparency = 0;
		end;
	end;
	function v1.Cancel(p86, p87)
		if not u13[p87] then
			local v60 = p87:Clone();
			v60.Name = "FreezeClone";
			v60.Parent = p87;
			v60.Size = UDim2.new(1, 0, 1, 0);
			v60.AnchorPoint = Vector2.new(0.5, 0.5);
			v60.Position = UDim2.new(0.5, 0, 0.5, 0);
			u13[p87] = v60;
			p87.ImageTransparency = 1;
			l__Tween__14:MakeTween(v60, {
				ImageColor3 = Color3.fromRGB(170, 255, 255)
			}, true, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		end;
	end;
	function v1.ConvertToLabel(p88, p89)
		local v61 = Instance.new("ImageLabel");
		for v62, v63 in pairs({ "Position", "ImageTransparency", "ImageRectSize", "ZIndex", "BackgroundTransparency", "AnchorPoint" }) do
			v61[v63] = p89[v63];
		end;
		v61.AnchorPoint = Vector2.new(0.5, 0.5);
		v61.Size = UDim2.new(1, 0, 1, 0);
		v61.Position = UDim2.new(0.5, 0, 0.5, 0);
		return v61;
	end;
	local u15 = {};
	local u16 = { "DoodleFront", "DoodleBack", "DoodleFront1", "DoodleFront2", "DoodleBack1", "DoodleBack2" };
	local function u17(p90, p91)
		return ColorSequenceKeypoint.new(p90, p91);
	end;
	local u18 = {
		LimeGreen = Color3.fromRGB(0, 255, 0), 
		Red = Color3.fromRGB(255, 0, 0), 
		Orange = Color3.fromRGB(255, 156, 38), 
		Yellow = Color3.fromRGB(255, 255, 0), 
		Blue = Color3.fromRGB(0, 107, 255), 
		Cyan = Color3.fromRGB(0, 255, 246), 
		Green = Color3.fromRGB(50, 255, 0), 
		Lime = Color3.fromRGB(230, 255, 100), 
		Periwinkle = Color3.fromRGB(204, 204, 255), 
		Peach = Color3.fromRGB(255, 195, 158), 
		ScreaminGreen = Color3.fromRGB(105, 255, 98), 
		Navy = Color3.fromRGB(25, 25, 112), 
		Orangey = Color3.fromRGB(255, 176, 102), 
		LightPink = Color3.fromRGB(255, 211, 229), 
		IceBlue = Color3.fromRGB(179, 255, 253), 
		NicePurple = Color3.fromRGB(201, 84, 234), 
		Brown = Color3.fromRGB(165, 42, 42), 
		White = Color3.fromRGB(255, 255, 255), 
		Black = Color3.fromRGB(0, 0, 0), 
		Pink = Color3.fromRGB(255, 122, 192), 
		Purple = Color3.fromRGB(190, 31, 255), 
		FireOrange = Color3.fromRGB(255, 79, 0), 
		Lilac = Color3.fromRGB(200, 162, 200), 
		Gold = Color3.fromRGB(255, 209, 46), 
		Bronze = Color3.fromRGB(205, 127, 50), 
		Turquoise = Color3.fromRGB(64, 224, 208), 
		Rose = Color3.fromRGB(229, 84, 81), 
		RoguePink = Color3.fromRGB(193, 40, 105), 
		UglyGreen = Color3.fromRGB(103, 161, 60)
	};
	function v1.AnimateKlydaskunk(p92, p93, p94, p95, p96)
		if p95 then
			local v64, v65, v66 = p1.ClientDatabase:GetKlydaFront(p94);
			local v67 = v64;
			local v68 = v65;
			local v69 = v66;
		else
			local v70, v71, v72 = p1.ClientDatabase:GetKlydaBack(p94);
			v67 = v70;
			v68 = v71;
			v69 = v72;
		end;
		local v73 = { {
				ZIndex = 0, 
				Sprite = v67
			}, {
				ZIndex = 2, 
				Sprite = v68
			}, {
				ZIndex = 1, 
				Sprite = v69
			} };
		local l__Parent__74 = p93.Parent;
		local v75 = nil;
		local v76 = 1 - 1;
		while true do
			local v77 = nil;
			local v78 = v75 == nil and p93:Clone() or v1:ConvertToLabel(p93);
			if not v75 then
				u11[p93] = v78;
				v75 = v78;
				v75.Name = "New" .. v78.Name;
				v77 = true;
			end;
			u15[p93.Name .. v73[v76].Sprite] = v78;
			v78.ImageTransparency = 0;
			v78.ZIndex = v78.ZIndex + v73[v76].ZIndex;
			v78.Visible = true;
			v78.Parent = v75 ~= v78 and v75 or l__Parent__74;
			if v77 and p93.Parent and table.find(u16, p93.Parent.Name) then
				local l__Scale__79 = p93.Size.X.Scale;
				local v80 = p1.ClientDatabase:GetDoodleSize(p94, l__Scale__79);
				v78.Size = UDim2.new(v80, 0, v80, 0);
				if v80 < 0.9 then
					v78.Position = UDim2.new(p93.Position.X.Scale, 0, p93.Position.Y.Scale + (l__Scale__79 - v80) / 2, 0);
				end;
			end;
			v78.ImageRectSize = Vector2.new(300, 300);
			if v76 == 1 and p94.Tint and p94.Tint ~= 0 then
				v1:Tint(p93, v78, p94);
			end;
			v78.Image = v73[v76].Sprite;
			local u19 = v76;
			l__Utilities__2.FastSpawn(function()
				while u15[p93.Name .. v73[u19].Sprite] do
					pcall(function()
						v78.ImageRectOffset = Vector2.new(0, 0);
						l__Utilities__2.Halt(0.1);
						v78.ImageRectOffset = Vector2.new(300, 0);
						l__Utilities__2.Halt(0.1);
						v78.ImageRectOffset = Vector2.new(0, 301);
						l__Utilities__2.Halt(0.1);
					end);				
				end;
			end);
			if (u19 ~= 1 or not (not p96)) and ((u19 ~= 2 or not p96) and u19 == 3) then
				local v81 = Instance.new("UIGradient", v78);
				if p95 then
					local v82 = 45;
				else
					v82 = 0;
				end;
				v81.Rotation = v82;
				v81.Color = ColorSequence.new({ u17(0, u18[p94.FormColor[1]]), u17(0.615, u18[p94.FormColor[2]]), u17(1, Color3.fromRGB(255, 255, 255)) });
			end;
			if 0 <= 1 then
				if not (u19 < 3) then
					break;
				end;
			elseif not (u19 > 3) then
				break;
			end;
			u19 = u19 + 1;		
		end;
		return v75;
	end;
	local function u20(p97)
		for v83, v84 in pairs(p97:GetChildren()) do
			if v84.Name == "Skunk" then
				v84:Destroy();
			end;
		end;
	end;
	function v1.AnimateSprite(p98, p99, p100, p101, p102, p103)
		p99.Visible = false;
		if p99.Parent and p99.Parent:FindFirstChild("Decoy") then
			p99.Parent:FindFirstChild("Decoy"):Destroy();
		end;
		if u11[p99] then
			u11[p99]:Destroy();
		end;
		if not p102 then
			u20(p99.Parent);
		end;
		if not p100 then
			return;
		end;
		if l__Utilities__2.GetRealName(p100) == "Klydaskunk" then
			return v1:AnimateKlydaskunk(p99, p100, p101, p102);
		end;
		if p100.SpecialCase then
			local v85 = p100.SpecialCase;
		else
			v85 = p101 and p1.ClientDatabase:GetFrontSprite(p100) or p1.ClientDatabase:GetBackSprite(p100);
		end;
		v1:LoadImage(v85);
		local v86 = p102 and p99 or p99:Clone();
		v86.Name = "New" .. v86.Name;
		u11[p99] = v86;
		v86.ImageTransparency = 0;
		v86.Visible = true;
		if not p102 then
			v86.Parent = p99.Parent;
		end;
		if p99.Parent and table.find(u16, p99.Parent.Name) then
			local l__Scale__87 = p99.Size.X.Scale;
			local v88 = p1.ClientDatabase:GetDoodleSize(p100, l__Scale__87);
			v86.Size = UDim2.new(v88, 0, v88, 0);
			if v88 < 0.9 then
				v86.Position = UDim2.new(p99.Position.X.Scale, 0, p99.Position.Y.Scale + (l__Scale__87 - v88) / 2, 0);
			end;
		end;
		v86.ImageRectSize = Vector2.new(300, 300);
		if p103 then
			v86.ImageRectSize = Vector2.new(-300, 300);
		end;
		if p100.Tint and p100.Tint ~= 0 then
			v1:Tint(p99, v86, p100);
		end;
		v86.Image = v85;
		l__Utilities__2.FastSpawn(function()
			while u11[p99] and v86:IsDescendantOf(game) do
				pcall(function()
					if not p103 then
						v86.ImageRectOffset = Vector2.new(0, 0);
						l__Utilities__2.Halt(0.1);
						v86.ImageRectOffset = Vector2.new(300, 0);
						l__Utilities__2.Halt(0.1);
						v86.ImageRectOffset = Vector2.new(0, 300);
						l__Utilities__2.Halt(0.1);
						return;
					end;
					v86.ImageRectOffset = Vector2.new(300, 0);
					l__Utilities__2.Halt(0.1);
					v86.ImageRectOffset = Vector2.new(600, 0);
					l__Utilities__2.Halt(0.1);
					v86.ImageRectOffset = Vector2.new(300, 300);
					l__Utilities__2.Halt(0.1);
				end);			
			end;
		end);
		return v86;
	end;
	local u21 = {};
	function v1.Hover(p104, p105, p106, p107, p108)
		if not p106 then
			p106 = {};
		end;
		if p107 and u21[p105] then
			u21[p105].MouseLeave:Disconnect();
			u21[p105].MouseEnter:Disconnect();
			u21[p105] = nil;
		end;
		if u21[p105] then
			return;
		end;
		local l__ImageColor3__89 = p105.ImageColor3;
		local u22 = v1:DarkerColor(l__ImageColor3__89);
		u21[p105] = {
			MouseEnter = p105.MouseEnter:Connect(function()
				if not (not p108) and not (not p108()) or p108 == nil then
					p105.ImageColor3 = u22;
					for v90, v91 in pairs(p106) do
						if v91:IsA("Frame") then
							v91.BackgroundColor3 = u22;
						else
							v91.ImageColor3 = u22;
						end;
					end;
				end;
			end), 
			MouseLeave = p105.MouseLeave:Connect(function()
				if not (not p108) and not (not p108()) or p108 == nil then
					p105.ImageColor3 = l__ImageColor3__89;
					for v92, v93 in pairs(p106) do
						if v93:IsA("Frame") then
							v93.BackgroundColor3 = l__ImageColor3__89;
						else
							v93.ImageColor3 = l__ImageColor3__89;
						end;
					end;
				end;
			end)
		};
	end;
	function v1.TextHover(p109, p110, p111)
		if u21[p110] then
			return;
		end;
		u21[p110] = true;
		local l__TextColor3__94 = p110.TextColor3;
		local u23 = v1:DarkerColor(l__TextColor3__94);
		p110.MouseEnter:Connect(function()
			p110.TextColor3 = p111 or u23;
		end);
		p110.MouseLeave:Connect(function()
			p110.TextColor3 = l__TextColor3__94;
		end);
	end;
	function v1.IsGuiOnScreen(p112, p113)
		local v95 = p1.Camera:GetCurrentCamera();
		if p113.AbsolutePosition.X >= 0 and p113.AbsolutePosition.X < v95.ViewportSize.X - p113.AbsoluteSize.X + 1 and p113.AbsolutePosition.Y >= 0 and p113.AbsolutePosition.Y < v95.ViewportSize.Y - p113.AbsoluteSize.Y then
			return true;
		end;
		return false;
	end;
	function v1.IsGuiOnScreenNoVertical(p114, p115)
		local v96 = p1.Camera:GetCurrentCamera();
		local v97 = v96.ViewportSize.Y - p115.AbsoluteSize.Y;
		if p115.AbsolutePosition.X >= 0 and p115.AbsolutePosition.X < v96.ViewportSize.X - p115.AbsoluteSize.X + 1 then
			return true;
		end;
		return false;
	end;
	function v1.TVScreen(p116, p117, p118, p119)
		local v98 = l__Utilities__2:Create("SurfaceGui")({
			Parent = p1.pgui, 
			Adornee = p117
		});
		local v99 = l__Utilities__2:Create("ViewportFrame")({
			Parent = v98, 
			Size = UDim2.new(1, 0, 1, 0)
		});
		p118:Clone().Parent = v99;
		v99.CurrentCamera = l__Utilities__2:Create("Camera")({
			Parent = v99, 
			CFrame = p119
		});
		return v98;
	end;
	function v1.NewsReport(p120, p121, p122)
		local l__NewsReport__100 = p1.guiholder.NewsReport;
		p1.Gui:ChangeText(l__NewsReport__100.News.MainText, p121);
		l__NewsReport__100.Visible = p122;
	end;
	function v1.TextAnnouncement(p123, p124, p125, p126, p127, p128)
		if p125 == nil then
			local v101 = "Autoskip";
		else
			v101 = p125;
		end;
		v1:SayText(p127 and "", p124, v101, p126, p128);
	end;
	local u24 = false;
	function v1.LoadingIcon(p129)
		local l__Loading__102 = p1.guiholder:FindFirstChild("Loading");
		if not l__Loading__102 then
			return;
		end;
		l__Loading__102.Visible = true;
		u24 = true;
		l__Utilities__2.FastSpawn(function()
			while u24 do
				l__Loading__102.Rotation = l__Loading__102.Rotation + 3;
				l__Utilities__2.Halt(0.05);			
			end;
		end);
	end;
	function v1.LoadingIconOff(p130)
		if not p1.guiholder:FindFirstChild("Loading") then
			return;
		end;
		u24 = false;
		p1.guiholder.Loading.Visible = false;
	end;
	local u25 = {};
	function v1.PushButton(p131, p132)
		if not u25[p132] then
			u25[p132] = true;
			local l__Position__26 = p132.Position;
			p132.MouseButton1Down:Connect(function()
				p132:TweenPosition(l__Position__26 + UDim2.new(0, 0, 0, 6), "Out", "Linear", 0.1, true);
				p132.Border:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Linear", 0.1, true);
			end);
			local l__Position__27 = p132.Border.Position;
			p132.MouseButton1Up:Connect(function()
				p132:TweenPosition(l__Position__26, "Out", "Linear", 0.1, true);
				p132.Border:TweenPosition(l__Position__27, "Out", "Linear", 0.1, true);
			end);
			p132.MouseLeave:Connect(function()
				p132:TweenPosition(l__Position__26, "Out", "Linear", 0.1, true);
				p132.Border:TweenPosition(l__Position__27, "Out", "Linear", 0.1, true);
			end);
		end;
	end;
	function v1.OtherPushButton(p133, p134)
		if not u25[p134] then
			u25[p134] = true;
			local l__Position__28 = p134.Position;
			p134.MouseButton1Down:Connect(function()
				p134:TweenPosition(l__Position__28 + UDim2.new(0, 0, 0, 6), "Out", "Linear", 0.1, true);
				p134.Border:TweenPosition(UDim2.new(0.5, 0, 0.5, -6), "Out", "Linear", 0.1, true);
			end);
			local l__Position__29 = p134.Border.Position;
			p134.MouseButton1Up:Connect(function()
				p134:TweenPosition(l__Position__28, "Out", "Linear", 0.1, true);
				p134.Border:TweenPosition(l__Position__29, "Out", "Linear", 0.1, true);
			end);
			p134.MouseLeave:Connect(function()
				p134:TweenPosition(l__Position__28, "Out", "Linear", 0.1, true);
				p134.Border:TweenPosition(l__Position__29, "Out", "Linear", 0.1, true);
			end);
		end;
	end;
	p1.Network:BindEvent("TextAnnouncement", function(p135, p136, p137, p138)
		v1:TextAnnouncement(p135, p137, p138);
		if p136 then
			p1.Controls:ToggleWalk(true);
		end;
	end);
	local function u30(p139)
		local v103 = tostring(p139);
		if #v103 == 1 then
			v103 = "0" .. v103;
		end;
		return v103;
	end;
	function v1.SecondsToTimer(p140, p141, p142)
		local v104 = nil;
		if not (p141 >= 0) then
			return "00:00:00";
		end;
		local v105 = math.floor(p141 / 3600);
		local v106 = p141 - v105 * 3600;
		local v107 = math.floor(v106 / 60);
		v104 = v106 - v107 * 60;
		if p142 == "NoHour" then
			return u30(v107) .. ":" .. u30(v104);
		end;
		return u30(v105) .. ":" .. u30(v107) .. ":" .. u30(v104);
	end;
	local function u31(p143)
		if p143 % 4 ~= 0 then
			return false;
		end;
		if p143 % 100 == 0 and p143 % 400 ~= 0 then
			return false;
		end;
		return true;
	end;
	function v1.NextDayTimer(p144)
		local l__CurrentDate__108 = game.ReplicatedStorage.CurrentDate;
		local v109 = l__CurrentDate__108.YDay.Value;
		local v110 = nil;
		for v111 = v109, 1, -1 do
			if v111 % 1 == 0 then
				v110 = v111;
				break;
			end;
			if v111 == 1 then
				v110 = 1;
			end;
		end;
		if v110 == 1 then
			local v112 = 1;
		else
			v112 = v110 + 1;
		end;
		local v113 = v112;
		if v109 == 364 or v109 == 365 then
			if u31(l__CurrentDate__108.Year.Value) then
				v113 = 366;
			else
				v113 = 365 - v109 + 2;
				v109 = 1;
			end;
		end;
		if v109 == 366 then
			v113 = 367;
		end;
		return u30(23 + (v113 - v109 - 1) * 24 - l__CurrentDate__108.Hour.Value) .. ":" .. u30(59 - l__CurrentDate__108.Minutes.Value) .. ":" .. u30(59 - l__CurrentDate__108.Seconds.Value);
	end;
	return v1;
end;
