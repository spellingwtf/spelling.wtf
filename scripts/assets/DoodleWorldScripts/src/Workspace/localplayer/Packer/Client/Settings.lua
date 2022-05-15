-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local l__Network__1 = p1.Network;
	local v2 = l__Utilities__1.Class({
		ClassName = "Settings"
	}, function(p2)
		p2.Gui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui"):WaitForChild("Settings");
		p2.Gui.Close.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop", 0.8);
			p2:Hide();
		end);
		p2.Gui.Close.MouseEnter:Connect(function()
			p2.Gui.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			p2.Gui.Close.Roundify.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		p2.Gui.Close.MouseLeave:Connect(function()
			p2.Gui.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p2.Gui.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		p2.Gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			p2:UISize();
		end);
		l__Network__1:BindEvent("UpdateSettings", function(p3)
			p2.Options = p3;
			p1.Music:ChangeMute();
			p1.ObjectiveUI:Update();
			p1.Lighting:LightingSetting();
			p2:UpdateGui();
			p1.PlayerList:Initialize();
			p1.Overworld:Toggle();
		end);
		p2:MakeGui();
		p2:UISize();
		return p2;
	end);
	function v2.Hide(p4)
		p4.Gui.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
		p4.Gui.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		p4.Gui:TweenPosition(UDim2.new(0.5, 0, -1, -18), "Out", "Quad", 0.5, true, function()
			p4.Gui.Visible = false;
		end);
		if not p1.Battle.CurrentBattle then
			l__Utilities__1.Halt(0.2);
			p1.Menu:EnableActive();
		end;
	end;
	function v2.UISize(p5)
		local l__UIGridLayout__3 = p5.Gui.Holder.Scroller.UIGridLayout;
		local v4 = p5.Gui.AbsoluteSize.Y / 6;
		l__UIGridLayout__3.CellSize = UDim2.new(0.9, 0, 0, v4);
		p5.Gui.Holder.Scroller.CanvasSize = UDim2.new(0, 0, 0, l__UIGridLayout__3.AbsoluteContentSize.Y);
		for v5, v6 in pairs(p5.Gui:GetDescendants()) do
			if v6:FindFirstChild("UITextSizeConstraint") then
				v6.TextSize = v4 / 2;
			end;
		end;
	end;
	local u2 = { "MuteMusic", "TextSpeed", "DoodleFollow", "SkipLevelUp", "SpectateBattles", "BattleAnimations", "BattleFlash", "ShowNotifs", "ShowObjective", "FindHiddenTraits", "Measurements", "FollowPrivacy", "DisableLighting" };
	local u3 = {
		ContentCreator = {
			String = "No Copyright Music", 
			Choices = "Bool"
		}, 
		TextSpeed = {
			String = "Text Speed", 
			Choices = { "Slow", "Medium", "Fast" }
		}, 
		DoodleFollow = {
			String = "Doodle Followers", 
			Choices = { "Off", "Flat", "Rotate" }
		}, 
		MuteMusic = {
			String = "Mute Music", 
			Choices = "Bool"
		}, 
		ShowNotifs = {
			String = "Show Notifications", 
			Choices = "Bool"
		}, 
		ShowObjective = {
			String = "Show Objective", 
			Choices = "Bool"
		}, 
		BattleAnimations = {
			String = "Move Animations", 
			Choices = "Bool"
		}, 
		FollowPrivacy = {
			String = "Who Can Follow", 
			Choices = { "No One", "Friends", "Everyone" }
		}, 
		DisableLighting = {
			String = "Disable Lighting", 
			Choices = "Bool"
		}, 
		SpectateBattles = {
			String = "Spectate Battles", 
			Choices = { "No One", "Friends", "Everyone" }
		}, 
		Measurements = {
			String = "Measurements", 
			Choices = { "Imperial", "Metric" }
		}, 
		SkipLevelUp = {
			String = "Skip Level Up", 
			Choices = "Bool"
		}, 
		BattleFlash = {
			String = "Battle Flash", 
			Choices = "Bool"
		}, 
		FindHiddenTraits = {
			String = "Chaining Hidden Traits", 
			Choices = "Bool"
		}
	};
	function v2.MakeGui(p6)
		for v7, v8 in pairs(u2) do
			local v9 = p1.GuiObjs.SettingLabel:Clone();
			v9.Name = v8;
			v9.LayoutOrder = v7;
			local v10 = u3[v8];
			p1.Gui:ChangeText(v9.Label, v10.String);
			local v11 = v10.Choices == "Bool" and v9.Bool or v9.Choices;
			p1.Gui:Hover(v11);
			v11.MouseButton1Click:Connect(function()
				p1.Sound:Play("BasicClick", math.random(90, 110) / 100);
				if v10.Choices == "Bool" then
					v11.Label.Visible = not v11.Label.Visible;
					l__Network__1:post("ToggleSettings", v8, v11.Label.Visible);
					return;
				end;
				local l__Choices__12 = u3[v8].Choices;
				local v13 = table.find(l__Choices__12, p6.Options[v8]);
				local v14 = v13 + 1;
				if v13 == #l__Choices__12 then
					v14 = 1;
				end;
				p1.Gui:ChangeText(v9.Choices.Label, l__Choices__12[v14]);
				l__Network__1:post("ToggleSettings", v8, l__Choices__12[v14]);
			end);
			v11.Visible = true;
			v9.Parent = p6.Gui.Holder.Scroller;
		end;
	end;
	function v2.Show(p7)
		l__Utilities__1.Halt(0.2);
		p7.Gui.Position = UDim2.new(0.5, 0, -1, 0);
		p7.Gui.Visible = true;
		p7.Gui:TweenPosition(UDim2.new(0.5, 0, 0.5, -18), "Out", "Quad", 0.5, true);
		return p7;
	end;
	function v2.UpdateGui(p8)
		for v15, v16 in pairs(p8.Gui.Holder.Scroller:GetChildren()) do
			if p8.Options[v16.Name] ~= nil then
				if typeof(p8.Options[v16.Name]) == "boolean" then
					v16.Bool.Label.Visible = p8.Options[v16.Name];
				else
					p1.Gui:ChangeText(v16.Choices.Label, p8.Options[v16.Name]);
				end;
			end;
		end;
	end;
	function v2.SetMute(p9)
		p1.Music:ChangeMute();
	end;
	local u4 = {
		Slow = 1, 
		Medium = 2, 
		Fast = 3
	};
	function v2.Get(p10, p11)
		local v17 = nil;
		local v18 = nil;
		local v19 = nil;
		local v20 = nil;
		if p10.Options then
			if p10.Options[p11] == nil then
				warn(p11 .. " isn't a valid setting!");
				v17 = warn;
				v18 = "Player has no settings!";
				v19 = v17;
				v20 = v18;
				v19(v20);
				return;
			end;
		else
			v17 = warn;
			v18 = "Player has no settings!";
			v19 = v17;
			v20 = v18;
			v19(v20);
			return;
		end;
		local v21 = p10.Options[p11];
		if not u4[v21] then
			return v21;
		end;
		return u4[v21];
	end;
	return v2.new();
end;
