-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local v2 = l__Utilities__1.Class({
		ClassName = "Tooltip"
	}, function(p2, p3, p4)
		p2.Gui = p3;
		p2.Enter = p3.InputBegan:Connect(function(p5)
			if l__Utilities__1.IsValidEnter(p5) then
				p2:Create(p4);
				p2:Move();
			end;
		end);
		p2.Leave = p3.InputEnded:Connect(function(p6)
			if l__Utilities__1.IsValidEnter(p6) and u1[p2.Gui] then
				u1[p2.Gui]:Destroy();
				u1[p2.Gui] = nil;
			end;
		end);
		p2.Changed = p3.InputChanged:Connect(function(p7)
			if l__Utilities__1.IsValidEnter(p7) then
				p2:Create(p4);
				p2:Move();
			end;
		end);
		return p2;
	end);
	function v2.Clear(p8)
		p1.guiholder.Tooltips:ClearAllChildren();
	end;
	function v2.Create(p9, p10)
		if u1[p9.Gui] then
			u1[p9.Gui]:Destroy();
		end;
		local v3 = p1.GuiObjs.Tooltip:Clone();
		if p9.SuperLong then
			v3.Helper.TextSize = 17;
			v3.Display.TextSize = 17;
			v3.Display.DropShadow.TextSize = 17;
		end;
		v3.Position = UDim2.new(-2, 0, -2, 0);
		p1.Gui:ChangeText(v3.Helper, p10, p9.TextColor3);
		p1.Gui:ChangeText(v3.Display, p10, p9.TextColor3);
		v3.Parent = p1.guiholder.Tooltips;
		local l__TextBounds__4 = v3.Helper.TextBounds;
		v3.Helper.Visible = false;
		if p9.SuperLong then
			local v5 = 2;
		else
			v5 = 1.5;
		end;
		v3.Size = UDim2.new(0, l__TextBounds__4.X * v5, 0, l__TextBounds__4.Y);
		u1[p9.Gui] = v3;
	end;
	function v2.Move(p11)
		local l__mouse__2 = p1.p:GetMouse();
		l__Utilities__1.FastSpawn(function()
			while u1[p11.Gui] do
				u1[p11.Gui].Position = UDim2.new(0, l__mouse__2.X + u1[p11.Gui].AbsoluteSize.X / 2, 0, l__mouse__2.Y - u1[p11.Gui].AbsoluteSize.Y);
				game:GetService("RunService").Stepped:wait();			
			end;
		end);
	end;
	function v2.Disconnect(p12)
		p12.Enter:Disconnect();
		p12.Leave:Disconnect();
		p12.Changed:Disconnect();
		if u1[p12.Gui] then
			u1[p12.Gui]:Destroy();
		end;
		p12 = nil;
	end;
	return v2;
end;
