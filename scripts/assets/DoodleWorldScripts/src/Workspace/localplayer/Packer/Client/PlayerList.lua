-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local v2 = l__Utilities__1.Class({
		ClassName = "PlayerList"
	}, function(p2)
		p2.ColorTable = {};
		p2.maingui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui");
		p2.PlayerList = p2.maingui:WaitForChild("PlayerList");
		p2.Holder = p2.PlayerList.PlayerListHolder;
		p2.PlayerList.Position = UDim2.new(0.98, 6, 0, 6);
		if p1.Services.UserInputService.TouchEnabled then
			p2.PlayerList.Visible = false;
		else
			p2.PlayerList.Visible = true;
		end;
		game.Players.PlayerAdded:Connect(function(p3)
			p2:MakeButton(p3);
		end);
		game.Players.PlayerRemoving:Connect(function(p4)
			p2:DestroyButton(p4);
		end);
		p1.Network:BindEvent("UpdateNameColor", function(p5, p6)
			p2.ColorTable[p5] = p6;
			p2:Update(p5, p6);
		end);
		return p2;
	end);
	function v2.UpdateSize(p7)
		p7.PlayerList.CanvasSize = UDim2.new(0, 0, 0, p7.Holder.UIListLayout.AbsoluteContentSize.Y);
	end;
	local u2 = {};
	function v2.DestroyButton(p8, p9)
		if u2[p9] then
			u2[p9]:Destroy();
			p8.ColorTable[p9.Name] = nil;
		end;
	end;
	local u3 = false;
	local u4 = true;
	local function u5(p10, p11)
		while u3 == p10 do
			p11:Play();
			l__Utilities__1.Halt(3);
			if not p10:FindFirstChild("NameHolder") then
				break;
			end;
			p10.NameHolder.Username.Position = UDim2.new(1, 0, 0, 0);		
		end;
		if p10:FindFirstChild("NameHolder") then
			p10.NameHolder.Username.Position = UDim2.new(0, 0, 0, 0);
		end;
	end;
	function v2.MakeButton(p12, p13)
		if p12.Holder:FindFirstChild(p13.Name) then
			return;
		end;
		local v3 = p1.GuiObjs.NameBadge:Clone();
		v3.Name = p13.Name;
		v3.UserPicture.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. p13.UserId .. "&width=420&height=420&format=png";
		p1.Gui:ChangeText(v3.NameHolder.Username, p13.DisplayName);
		u2[p13] = v3;
		if p13 == game.Players.LocalPlayer then
			if p12.PlayerButton then
				return;
			end;
			v3.LayoutOrder = -100;
			v3.AnchorPoint = Vector2.new(1, 0);
			v3.Position = UDim2.new(0.98, 0, 0, -18);
			v3.Size = UDim2.new(0, p12.PlayerList.AbsoluteSize.X * 1.15, 0, 16);
			v3.Parent = p12.maingui;
			p12.PlayerButton = v3;
			p12.PlayerButton.MouseButton1Click:Connect(function()
				if #game.Players:GetPlayers() == 1 then
					p12.PlayerList.Visible = false;
					return;
				end;
				if u4 then
					return;
				end;
			end);
			p1.Gui:Hover(p12.PlayerButton);
		else
			v3.Size = UDim2.new(0, p12.PlayerList.AbsoluteSize.X - 6, 0, 16);
			v3.ImageColor3 = Color3.fromRGB(64, 64, 64);
			v3.Parent = p12.Holder;
		end;
		v3.UserPicture.MouseEnter:Connect(function()
			v3.UserPicture.ImageColor3 = Color3.new(0.5, 0.5, 0.5);
		end);
		v3.UserPicture.MouseLeave:Connect(function()
			v3.UserPicture.ImageColor3 = Color3.new(1, 1, 1);
		end);
		if v3.NameHolder.Username.TextFits == false then
			local u6 = p1.Tween:MakeTween(v3.NameHolder.Username, {
				Position = UDim2.new(-1, 0, 0, 0)
			}, false, 3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			v3.NameHolder.InputBegan:Connect(function(p14)
				if u3 ~= v3 then
					u3 = v3;
					u5(v3, u6);
				end;
			end);
			v3.NameHolder.InputEnded:Connect(function(p15)
				if p15.UserInputType == Enum.UserInputType.MouseMovement or p15.UserInputType == Enum.UserInputType.MouseMovement then
					u3 = false;
					u6:Cancel();
					v3.NameHolder.Username.Position = UDim2.new(0, 0, 0, 0);
				end;
			end);
		end;
		v3.NameHolder.Username.Size = UDim2.new(0, v3.NameHolder.Username.TextBounds.X, 1, 0);
		if p12.ColorTable[p13.Name] then
			p1.ColorAnim.Create(v3.NameHolder.Username, p12.ColorTable[p13.Name]);
		end;
		p12:UpdateSize();
	end;
	function v2.Initialize(p16)
		p16.ColorTable = p1.ClientDatabase:PDSFunc("GetNameColors");
		for v4, v5 in pairs(game.Players:GetPlayers()) do
			p16:MakeButton(v5);
		end;
	end;
	local u7 = true;
	function v2.Show(p17)
		u4 = true;
		p17.PlayerButton.Visible = true;
		if not p1.Services.UserInputService.TouchEnabled then
			p17.PlayerList.Visible = u7;
			return;
		end;
		p17.PlayerList.Visible = false;
	end;
	function v2.Update(p18, p19, p20)
		local v6 = u2[game.Players:FindFirstChild(p19)];
		if v6 then
			p1.ColorAnim.Create(v6.NameHolder.Username, p20);
		end;
	end;
	function v2.Hide(p21)
		if u4 == false then
			return;
		end;
		u4 = false;
		p21.PlayerButton.Visible = false;
		u7 = p21.PlayerList.Visible;
		p21.PlayerList.Visible = false;
	end;
	return v2.new();
end;
