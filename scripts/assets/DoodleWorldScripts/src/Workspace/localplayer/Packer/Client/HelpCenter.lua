-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = l__Utilities__1.Signal();
	local u1 = {};
	local function u2()
		for v3, v4 in pairs(u1) do
			v4:Disconnect();
		end;
	end;
	local u3 = false;
	local v5 = l__Utilities__1.Class({
		ClassName = "HelpCenterUI"
	}, function(p2)
		u2();
		p2.UI = p1.guiholder.HelpCenter;
		p2.Main = p2.UI.Main;
		p2.Board = p2.Main.Board;
		p2.Request = p2.UI.Request;
		p2:ClearRequests();
		p2:ClearRewards();
		if p2.Location then
			p2:Setup();
		end;
		p2:Show();
		u1.CloseClick = p2.UI.Close.MouseButton1Click:Connect(function()
			local v6, v7 = p1:GetProgression();
			p2.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p2.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
			if u3 then
				p2.Request.Visible = false;
				u3 = false;
				p1.Sound:Play("PageFlip");
				p2.Main.Visible = true;
				return;
			end;
			if p2.Tutorial == nil or v7 then
				p1.Sound:Play("Boop", 0.8);
				p2:Destroy();
				return;
			end;
			if p2.Tutorial then
				p1.Gui:TextAnnouncement("Sorry, but you need to accept the help request.", true, true, "Cassidy", true);
			end;
		end);
		u1.CloseHover = p2.UI.Close.MouseEnter:Connect(function()
			p2.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 0);
			p2.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(120, 0, 0);
		end);
		u1.CloseLeave = p2.UI.Close.MouseLeave:Connect(function()
			p2.UI.Close.Roundify.ImageColor3 = Color3.fromRGB(170, 0, 0);
			p2.UI.Close.Label.TextColor3 = Color3.fromRGB(255, 255, 255);
		end);
		p1.Gui:PushButton(p2.Request.Board.JobBG.Accept);
		p2:DescSize();
		if p2.Location == "Tutorial" then
			p2.Tutorial = true;
			p1.Gui:TextAnnouncement("This is the quest board. There's only one quest available, so click/tap on it.", true, true, "Cassidy", true);
		end;
		return p2;
	end);
	function v5.DescSize(p3)
		local function u4()
			local v8 = p3.Request.Board.JobBG.AbsoluteSize.Y / 10;
			p3.Request.Board.JobBG.Desc.TextSize = v8;
			p3.Request.Board.JobBG.Desc.DropShadow.TextSize = v8;
		end;
		u1.DescSize = p3.Request.Board.JobBG:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			u4();
		end);
		u4();
	end;
	function v5.ClearRewards(p4)
		for v9, v10 in pairs(p4.Request.BottomBar.Rewards:GetChildren()) do
			if v10:IsA("GuiObject") then
				v10:Destroy();
			end;
		end;
	end;
	function v5.ClearRequests(p5)
		for v11, v12 in pairs(p5.Board:GetChildren()) do
			if v12:IsA("GuiObject") then
				v12:Destroy();
			end;
		end;
	end;
	local u5 = {};
	function v5.SetupRewards(p6, p7)
		p6:ClearRewards();
		for v13, v14 in pairs(p7.Reward) do
			local v15 = p1.GuiObjs.Reward:Clone();
			v15.LayoutOrder = v13;
			if v14.Money then
				p1.Gui:ChangeText(v15.Number, "$" .. l__Utilities__1.AddComma(v14.Money));
				v15.Item.Image = "http://www.roblox.com/asset/?id=6493697995";
			elseif v14.Gems then
				p1.Gui:ChangeText(v15.Number, l__Utilities__1.AddComma(v14.Gems) .. " gems");
				v15.Item.Image = "http://www.roblox.com/asset/?id=6493648722";
			elseif v14.Dance then
				u5.reward = p1.Gui.ViewportModule(p1.p.Character or p1.p.CharacterAdded:wait(), v15.Item, {
					PlayAnim = v14.Dance, 
					Zoom = 6, 
					Diagonal = 0, 
					BackgroundColor3 = v15.BackgroundColor3
				});
				u5.reward:PlayAnim(v14.Dance);
				v15.Item.Image = "";
				p1.Gui:ChangeText(v15.Number, v14.Dance .. " Dance");
			elseif v14.Doodle then
				p1.Gui:ChangeText(v15.Number, v14.Doodle);
				if v14.Color3 then
					v15.Item.ImageColor3 = v14.Color3;
					p1.Gui:ChangeText(v15.Number, "???");
				end;
				p1.Gui:AnimateSprite(v15.Item, {
					Name = v14.Doodle, 
					Skin = 0, 
					Gender = "M", 
					Shiny = false
				}, true);
			elseif v14.Item then
				v15.Item.Image = p1.ItemList[v14.Item].Image;
				if v14.Color3 then
					v15.Item.ImageColor3 = v14.Color3;
				end;
				if v14.Amount == 1 then
					v15.Number.Visible = false;
				elseif v14.Name then
					p1.Gui:ChangeText(v15.Number, v14.Name);
				else
					p1.Gui:ChangeText(v15.Number, "x" .. v14.Amount);
				end;
			end;
			v15.Parent = p6.Request.BottomBar.Rewards;
		end;
	end;
	local u6 = nil;
	local u7 = nil;
	function v5.JobDesc(p8, p9)
		if u6 then
			u6:Destroy();
		end;
		if u7 then
			u7:Disconnect();
		end;
		p8.Main.Visible = false;
		u3 = true;
		p1.Gui:ChangeText(p8.Request.Title, p9.Name);
		local v16 = p9.ClientID or p9.Client;
		p1.Gui:ChangeText(p8.Request.Board.ClientFrame.ClientName, v16);
		if v16 == "???" or not p1.Services.ReplicatedStorage.NPCs:FindFirstChild(v16) then
			v16 = "Unknown";
		end;
		p1.Gui:ChangeText(p8.Request.Board.JobBG.Desc, p9.Description);
		local v17 = p1.Services.ReplicatedStorage.NPCs:FindFirstChild(v16):Clone();
		v17.Parent = p1.Fodder;
		v17:MoveTo(Vector3.new(10000, 10000, 10000));
		u6 = p1.Gui.ViewportModule(v17, p8.Request.Board.ClientFrame.CharacterHolder, {
			Zoom = 2, 
			Diagonal = 0.5, 
			BackgroundColor3 = p8.Request.Board.ClientFrame.BackgroundColor3
		});
		p1.Gui:ChangeText(p8.Request.Board.ClientFrame.ClientName, "Client: " .. v16);
		p8:SetupRewards(p9);
		local v18, v19 = p1:GetProgression();
		if v19 == p9.Completed then
			p8.Request.Board.JobBG.Accept.Visible = false;
			p8.Request.Board.JobBG.AlreadyAccepted.Visible = true;
		else
			p8.Request.Board.JobBG.Accept.Visible = true;
			p8.Request.Board.JobBG.AlreadyAccepted.Visible = false;
		end;
		u7 = p8.Request.Board.JobBG.Accept.MouseButton1Click:Connect(function()
			if not v19 then
				p1.Sound:Play("Boop");
				p1.ClientDatabase:PDSEvent("TakeHelpRequest", p9.Completed);
				p8.Request.Board.JobBG.Accept.Visible = false;
				p8.Request.Board.JobBG.AlreadyAccepted.Visible = true;
				if p8.Tutorial then
					p1.ClientDatabase:PDSEvent("SetSwitch", "18", 1);
					p1.ClientDatabase:PDSEvent("SetSwitch", "13", 2);
					p1.ClientDatabase:PDSEvent("UpdateObjective", 12);
					p8:Destroy();
					return;
				elseif p9.Accept then
					p8:Destroy(true);
					p1.Gui:TextAnnouncement(p9.Accept, true, true, nil, true);
					p1.GlobalSignal:Fire();
					return;
				else
					return;
				end;
			elseif p8.Tutorial then
				p1.ClientDatabase:PDSEvent("SetSwitch", "18", 1);
				p1.ClientDatabase:PDSEvent("SetSwitch", "13", 2);
				p1.ClientDatabase:PDSEvent("UpdateObjective", 12);
				p8:Destroy();
				return;
			end;
			p1.Dialogue:Fire();
			if v19 == p9.Completed then
				p1.Gui:TextAnnouncement("You are already doing this request.", true, true, nil, true);
				return;
			end;
			p1.Gui:TextAnnouncement("You are already doing a help center request. To cancel that request, talk to the receptionist.", true, true, nil, true);
		end);
		p8.Request.Visible = true;
		if p8.Tutorial then
			p1.Dialogue:Fire();
			p1.Gui:TextAnnouncement("These are the job details. You can only take one job at a time, so remember that! Now, accept this job.", true, true, "Cassidy", true);
		end;
	end;
	local l__HelpRequests__8 = p1.HelpRequests;
	local l__HelpCenterCard__9 = p1.GuiObjs.HelpCenterCard;
	local u10 = {};
	local u11 = nil;
	function v5.Setup(p10)
		p10.Request.Visible = false;
		u3 = false;
		if p10.Location == "Tutorial" then
			local v20 = "GraphiteLodge";
		else
			v20 = p10.Location;
		end;
		local v21 = p1:GetProgression();
		for v22, v23 in pairs(l__HelpRequests__8[v20]) do
			if not (v22 > 1) or v21["18"] == 5 then
				local v24 = nil;
				local v25 = l__HelpCenterCard__9:Clone();
				v25.LayoutOrder = v22;
				p1.Gui:ChangeText(v25.QuestName, v23.Name);
				p1.Gui:ChangeText(v25.ClientName, v23.Client);
				local v26 = v23.ClientID or v23.Client;
				if v26 == "???" or not p1.Services.ReplicatedStorage.NPCs:FindFirstChild(v26) then
					v26 = "Unknown";
				end;
				if v21[v23.Completed] and v23.Steps and v21[v23.Completed] == v23.Steps then
					v25.CharacterHolder.Completed.Visible = true;
					v25.AutoButtonColor = false;
					v24 = "This quest is already completed!";
				elseif v23.NotReady and v21[v23.Requirement] == nil then
					v24 = "You don't meet the qualifications for this quest yet. " .. v23.NotReady;
					v25.AutoButtonColor = false;
				end;
				v25.Name = v26;
				local v27 = p1.Services.ReplicatedStorage.NPCs[v26]:Clone();
				v27:MoveTo(Vector3.new(10000, 10000, 10000));
				u10[v27] = true;
				v27.Parent = p1.Fodder;
				v25.Parent = p10.Board;
				u5[v22] = p1.Gui.ViewportModule(v27, v25.CharacterHolder, {
					Zoom = 6, 
					Diagonal = 0, 
					BackgroundColor3 = v25.BackgroundColor3
				});
				v25.MouseEnter:Connect(function()
					if not v24 then
						u5[v22]:PlayAnim("Wave");
						v25.ClientName.TextColor3 = Color3.fromRGB(255, 255, 0);
						v25.QuestName.TextColor3 = Color3.fromRGB(255, 255, 0);
					end;
				end);
				v25.MouseLeave:Connect(function()
					if not v24 then
						u5[v22]:StopAnim("Wave");
						v25.ClientName.TextColor3 = Color3.fromRGB(255, 255, 255);
						v25.QuestName.TextColor3 = Color3.fromRGB(255, 255, 255);
					end;
				end);
				v25.MouseButton1Click:Connect(function()
					if v24 == nil then
						p1.Sound:Play("PageFlip");
						p10:JobDesc(v23);
						return;
					end;
					if not u11 then
						u11 = true;
						p1.Gui:TextAnnouncement(v24);
						u11 = nil;
					end;
				end);
			end;
		end;
		p10.Main.Visible = true;
	end;
	function v5.Show(p11)
		p11.UI.Visible = true;
	end;
	function v5.Destroy(p12, p13)
		p12.UI.Visible = false;
		setmetatable(p12, nil);
		for v28, v29 in pairs(u5) do
			v29:Destroy();
		end;
		for v30, v31 in pairs(u10) do
			v30:Destroy();
		end;
		u5 = {};
		if not p13 then
			p1.GlobalSignal:Fire();
			p1.Dialogue:Fire();
		end;
	end;
	return v5;
end;
