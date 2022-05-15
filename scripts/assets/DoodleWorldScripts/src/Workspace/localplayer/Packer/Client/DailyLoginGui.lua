-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	p1.DailyLoginOn = true;
	local l__DailyLogin__1 = p1.DailyLogin;
	local u2 = {
		Cash = {
			Image = "http://www.roblox.com/asset/?id=6493697995", 
			Color = Color3.fromRGB(46, 204, 113)
		}, 
		Gems = {
			Image = "http://www.roblox.com/asset/?id=6493648722", 
			Color = Color3.fromRGB(0, 255, 255)
		}
	};
	local u3 = l__Utilities__1.Class({
		ClassName = "DailyLogin"
	}, function(p2, p3)
		if p3 == nil then
			p1.DailyLoginOn = nil;
			return;
		end;
		p1.ClientDatabase:PDSEvent("ToggleBusy", true);
		p1.Controls:ToggleWalk(false);
		p1.Menu.Blur();
		p1.Menu:CloseAll();
		p1.Menu:Disable();
		p2.UI = p1.guiholder.DailyLogin;
		local l__DailyLoginRewards__2 = p1.GuiObjs.DailyLoginRewards;
		local v3 = p3 % 7;
		if v3 == 0 then
			v3 = 7;
		end;
		for v4 = 1, 7 do
			local v5 = l__DailyLoginRewards__2:Clone();
			v5.Name = "Day" .. v4;
			v5.LayoutOrder = v4;
			v5.Redeemed.Visible = false;
			if v4 <= v3 then
				v5.Redeemed.Visible = true;
			else
				v5.Icon.ImageColor3 = Color3.fromRGB(55, 55, 55);
			end;
			local v6 = l__DailyLogin__1[v4];
			if v6.Type == "Gems" or v6.Type == "Cash" then
				v5.Icon.Image = u2[v6.Type].Image;
				v5.Reward.TextColor3 = u2[v6.Type].Color;
				if v6.Type == "Gems" then
					p1.Gui:ChangeText(v5.Reward, v6.Amount .. " gems");
				elseif v6.Type == "Cash" then
					p1.Gui:ChangeText(v5.Reward, "$" .. l__Utilities__1.AddComma(v6.Amount));
				end;
			end;
			if v6.Type == "Item" then
				v5.Icon.Image = p1.ItemList[v6.Item].Image;
				p1.Gui:ChangeText(v5.Reward, v6.Item);
			end;
			v5.Parent = p2.UI.Holder;
		end;
		local l__Confirm__7 = p2.UI.Confirm;
		p1.Gui:PushButton(l__Confirm__7);
		l__Confirm__7.MouseButton1Click:Connect(function()
			p1.Sound:Play("Boop");
			p2.UI:TweenPosition(UDim2.new(0.5, 0, 4, 0), "Out", "Linear", 1);
			p1.ClientDatabase:PDSEvent("ToggleBusy", false);
			p1.Controls:ToggleWalk(true);
			p1.Menu.DisableBlur();
			p1.DailyLoginOn = nil;
		end);
		p1.Menu:Invisible();
		p2.UI.Position = UDim2.new(0.5, 0, -4, 0);
		p2.UI.Visible = true;
		p2.UI:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Linear", 1);
		return p2;
	end);
	p1.Network:BindEvent("WonStreak", function(p4)
		while true do
			l__Utilities__1.Halt(0.01);
			if p1.Loaded then
				break;
			end;		
		end;
		u3.new({}, p4);
	end);
	return u3;
end;
