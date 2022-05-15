-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local u1 = {};
	local function u2(p2)
		for v2, v3 in pairs(p2:GetChildren()) do
			if v3.Name == "Skunk" then
				v3:Destroy();
			end;
		end;
	end;
	local v4 = l__Utilities__1.Class({
		ClassName = "Sprite"
	}, function(p3, p4, p5, p6, p7, p8)
		if u1[p4] then
			u1[p4]:UpdateImage(p5);
			p3:Destroy();
			return;
		end;
		p3.origin = p4;
		p3.origin.Visible = false;
		p3.Doodle = p5;
		p3.Flipped = p8;
		p3.Front = p6;
		if p3.origin.Parent and p3.origin.Parent:FindFirstChild("Decoy") then
			p3.origin.Parent:FindFirstChild("Decoy"):Destroy();
		end;
		if not p7 then
			u2(p4.Parent);
		end;
		if p5 then
			if l__Utilities__1.GetRealName(p5) == "Klydaskunk" then
				return p1.Gui:AnimateKlydaskunk(p4, p5, p6, p7);
			end;
			p3.MainImage = p7 and p4 or p4:Clone();
			p3.MainImage.Name = "New" .. p3.MainImage.Name;
			u1[p4] = p3.MainImage;
			p3.MainImage.ImageTransparency = 0;
			p3.MainImage.Visible = true;
			if not p7 then
				p3.MainImage.Parent = p4.Parent;
			end;
			if p3.origin.Parent and (p3.origin.Name == "DoodleFront" or p3.origin.Name == "DoodleBack") then
				local l__Scale__5 = p4.Size.X.Scale;
				local v6 = p1.ClientDatabase:GetDoodleSize(p5, l__Scale__5);
				p3.MainImage.Size = UDim2.new(v6, 0, v6, 0);
				if v6 < 0.9 then
					p3.MainImage.Position = UDim2.new(p4.Position.X.Scale, 0, p4.Position.Y.Scale + (l__Scale__5 - v6) / 2, 0);
				end;
			end;
			p3.MainImage.ImageRectSize = Vector2.new(300, 300);
			if p3.Flipped then
				p3.MainImage.ImageRectSize = p3.MainImage.new(-300, 300);
			end;
			p3:UpdateImage(p5);
			if p3.MainImage.Parent.Visible == true then
				p3:Loop();
			end;
			p3.MainImage.Parent:GetPropertyChangedSignal("Visible"):Connect(function()
				if p3.MainImage.Parent.Visible == true then
					p3:Loop();
					return;
				end;
				p3:StopLoop();
			end);
		end;
		u1[p4] = p3;
		return p3;
	end);
	function v4.StopLoop(p9)
		p9.Looping = false;
	end;
	function v4.Loop(p10)
		if p10.Looping then
			return;
		end;
		p10.Looping = true;
		l__Utilities__1.FastSpawn(function()
			while p10 and p10.Looping do
				pcall(function()
					if not p10.Flipped then
						p10.MainImage.ImageRectOffset = Vector2.new(0, 0);
						l__Utilities__1.Halt(0.1);
						if not p10.Looping then
							return;
						end;
						p10.MainImage.ImageRectOffset = Vector2.new(300, 0);
						l__Utilities__1.Halt(0.1);
						if not p10.Looping then
							return;
						end;
						p10.MainImage.ImageRectOffset = Vector2.new(0, 301);
						l__Utilities__1.Halt(0.1);
						if not p10.Looping then
							return;
						end;
					else
						p10.MainImage.ImageRectOffset = Vector2.new(300, 0);
						l__Utilities__1.Halt(0.1);
						if not p10.Looping then
							return;
						end;
						p10.MainImage.ImageRectOffset = Vector2.new(600, 0);
						l__Utilities__1.Halt(0.1);
						if not p10.Looping then
							return;
						end;
						p10.MainImage.ImageRectOffset = Vector2.new(300, 301);
						l__Utilities__1.Halt(0.1);
						if not p10.Looping then
							return;
						end;
					end;
				end);			
			end;
		end);
	end;
	function v4.UpdateImage(p11, p12)
		if p12.Tint and p12.Tint ~= 0 then
			p1.Gui:Tint(p11.NewImage, p11.MainImage, p11.Doodle);
		end;
		p11.Doodle = p12;
		p11.MainImage.Image = p11.Front and p1.ClientDatabase:GetFrontSprite(p11.Doodle) or p1.ClientDatabase:GetBackSprite(p11.Doodle);
	end;
	function v4.Destroy(p13)
		print("rip");
		for v7, v8 in pairs(u1) do
			if v8 == p13 then
				u1[v7] = nil;
			end;
		end;
		p13:StopLoop();
		for v9, v10 in pairs(p13) do
			p13[v9] = nil;
		end;
		l__Utilities__1.FastSpawn(function()
			l__Utilities__1.Halt(1);
			setmetatable(p13, nil);
		end);
	end;
	return v4;
end;
