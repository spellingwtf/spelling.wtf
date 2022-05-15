-- Decompiled with the Synapse X Luau decompiler.

return function(p1, p2)
	local v1 = {};
	local l__Utilities__1 = p1.Utilities;
	local function u2(p3, p4, p5, p6)
		return l__Utilities__1:Create("ImageLabel")({
			Image = p3, 
			BackgroundTransparency = 1, 
			BorderSizePixel = 0, 
			Size = UDim2.new(p6, 0, p6, 0), 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			ImageRectSize = p4, 
			ImageColor3 = p5
		});
	end;
	local function u3(p7)
		if not p7.Parent:FindFirstChild("Decoy") then
			return p7;
		end;
		return p7.Parent:FindFirstChild("Decoy");
	end;
	function v1.Slash(p8, p9)
		local v2 = p9.Speed and 0.033;
		local v3 = p9.Wait and 0.3;
		if p9.Flipped then
			local v4 = -1;
		else
			v4 = 1;
		end;
		local v5 = Vector2.new(v4 * 300, 300);
		if p9.Flipped then
			local v6 = 2;
		else
			v6 = 1;
		end;
		local v7 = u2("http://www.roblox.com/asset/?id=4592334492", v5, p9.Color and 1, p9.Size and 1);
		v7.ZIndex = p8.ZIndex + 5;
		v7.Parent = u3(p8);
		v7.Rotation = p9.Rotation and 0;
		if not p9.NoSound then
			p1.Sound:Play("Claw", p9.Pitch and 1, p9.Volume and 1);
		end;
		for v8 = 1, p9.Times and 1 do
			for v9 = 1, 3 do
				for v10 = v6, 3 + (v6 - 1) do
					v7.ImageRectOffset = Vector2.new((v10 - 1) * math.abs(v5.X), (v9 - 1) * v5.Y);
					l__Utilities__1.Halt(v2);
				end;
			end;
			l__Utilities__1.Halt(v3);
			v7:Destroy();
		end;
	end;
	function v1.Bite(p10, p11)
		local v11 = p11.Speed and 0.033;
		local v12 = p11.Wait and 0.3;
		if p11.Flipped then
			local v13 = -1;
		else
			v13 = 1;
		end;
		local v14 = Vector2.new(v13 * 300, 300);
		if p11.Flipped then
			local v15 = 2;
		else
			v15 = 1;
		end;
		local v16 = u2("http://www.roblox.com/asset/?id=5737903515", v14, p11.Color and 1, p11.Size and 1);
		v16.ZIndex = p10.ZIndex + 5;
		v16.Parent = u3(p10);
		v16.Rotation = p11.Rotation and 0;
		if not p11.NoSound then
			p1.Sound:Play("Bite", p11.Pitch and 1, p11.Volume and 1);
		end;
		for v17 = 1, p11.Times and 1 do
			for v18 = 1, 3 do
				for v19 = v15, 3 + (v15 - 1) do
					v16.ImageRectOffset = Vector2.new((v19 - 1) * math.abs(v14.X), (v18 - 1) * v14.Y);
					l__Utilities__1.Halt(v11);
				end;
			end;
			l__Utilities__1.Halt(v12);
			v16:Destroy();
		end;
	end;
	local u4 = {
		Fire = 8728911837, 
		Spark = 2890763474, 
		Metal = 368169621, 
		Insect = 8728917925, 
		Ice = 8728927712
	};
	function v1.Default(p12, p13, p14)
		local v20 = p13.Speed and 0.05;
		local v21 = p13.Wait and 0.3;
		local v22 = p13.Pitch and 0.8;
		local v23 = p13.Volume and 1;
		if p13.Flipped then
			local v24 = -1;
		else
			v24 = 1;
		end;
		local v25 = Vector2.new(v24 * 300, 300);
		if p13.Flipped then
			local v26 = 2;
		else
			v26 = 1;
		end;
		local v27 = u2("http://www.roblox.com/asset/?id=7245078789", v25, p13.Color and 1, p13.Size and 1);
		v27.ZIndex = p12.ZIndex + 5;
		v27.Parent = u3(p12);
		v27.Rotation = p13.Rotation and 0;
		if p14 and u4[p14] then
			p1.Sound:PlayId(u4[p14], v22, v23);
		elseif not p13.NoSound then
			p1.Sound:PlayId(190321873, v22, v23);
		end;
		for v28 = 1, p13.Times and 1 do
			for v29 = 1, 3 do
				for v30 = v26, 3 + (v26 - 1) do
					v27.ImageRectOffset = Vector2.new((v30 - 1) * math.abs(v25.X), (v29 - 1) * v25.Y);
					l__Utilities__1.Halt(v20);
				end;
			end;
			l__Utilities__1.Halt(v21);
		end;
	end;
	function v1.Impact(p15, p16)
		local v31 = p16.Speed and 0.033;
		local v32 = p16.Wait and 0.3;
		if p16.Flipped then
			local v33 = -1;
		else
			v33 = 1;
		end;
		local v34 = Vector2.new(v33 * 300, 300);
		if p16.Flipped then
			local v35 = 2;
		else
			v35 = 1;
		end;
		local v36 = u2("http://www.roblox.com/asset/?id=5734669791", v34, p16.Color and 1, p16.Size and 1);
		v36.ZIndex = p15.ZIndex + 5;
		v36.Parent = u3(p15);
		v36.Rotation = p16.Rotation and 0;
		if not p16.NoSound then
			p1.Sound:Play("Claw", p16.Pitch and 1, p16.Volume and 1);
		end;
		for v37 = 1, p16.Times and 1 do
			for v38 = 1, 3 do
				for v39 = v35, 3 + (v35 - 1) do
					v36.ImageRectOffset = Vector2.new((v39 - 1) * math.abs(v34.X), (v38 - 1) * v34.Y);
					l__Utilities__1.Halt(v31);
				end;
			end;
			l__Utilities__1.Halt(v32);
		end;
	end;
	function v1.Paralysis(p17)
		local v40 = Vector2.new(300, 300);
		local v41 = u2("http://www.roblox.com/asset/?id=5707708866", v40, Color3.fromRGB(255, 255, 255), 1);
		v41.ZIndex = p17.ZIndex + 5;
		v41.Parent = p17;
		p1.Sound:Play("Shock");
		for v42 = 1, 3 do
			for v43 = 1, 2 do
				for v44 = 1, 2 do
					if v44 ~= 2 or v43 ~= 2 then
						v41.ImageRectOffset = Vector2.new((v44 - 1) * v40.X, (v43 - 1) * v40.Y);
						l__Utilities__1.Halt(0.1);
					end;
				end;
			end;
			p1.Sound:Play("Shock");
		end;
		l__Utilities__1.Halt(0.05);
		v41:Destroy();
	end;
	local l__Tween__5 = p1.Tween;
	function v1.Poison(p18, p19)
		if p19.Wait then

		end;
		if p19.Pitch then

		end;
		if p19.Volume then

		end;
		if p19.Flipped then

		end;
		if p19.Flipped then
			local v45 = 2;
		else
			v45 = 1;
		end;
		local v46 = u2("http://www.roblox.com/asset/?id=7244768725", Vector2.new(250, 250), Color3.fromRGB(255, 255, 255), p19.Size and 1);
		v46.ZIndex = p18.ZIndex + 5;
		v46.Parent = u3(p18);
		v46.Rotation = p19.Rotation and 0;
		l__Tween__5:MakeTween(p18, {
			ImageColor3 = Color3.fromRGB(172, 138, 207)
		}, true, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		p1.Sound:Play("Poison");
		for v47 = 1, p19.Times and 1 do
			for v48 = 1, 3 do
				for v49 = v45, 4 + (v45 - 1) do
					v46.ImageRectOffset = Vector2.new((v49 - 1) * 250, (v48 - 1) * 250);
					l__Utilities__1.Halt(0.05);
				end;
			end;
			l__Utilities__1.Halt(0.05);
		end;
		l__Tween__5:MakeTween(p18, {
			ImageColor3 = p18.ImageColor3
		}, true, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		wait(0.2);
	end;
	function v1.Diseased(p20, p21)
		if p21.Wait then

		end;
		if p21.Pitch then

		end;
		if p21.Volume then

		end;
		if p21.Flipped then

		end;
		if p21.Flipped then
			local v50 = 2;
		else
			v50 = 1;
		end;
		local v51 = u2("http://www.roblox.com/asset/?id=7245032317", Vector2.new(200, 200), Color3.fromRGB(255, 255, 255), p21.Size and 1);
		v51.ZIndex = p20.ZIndex + 5;
		v51.Parent = u3(p20);
		v51.Rotation = p21.Rotation and 0;
		l__Tween__5:MakeTween(p20, {
			ImageColor3 = Color3.fromRGB(161, 216, 73)
		}, true, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		p1.Sound:Play("Poison", 0.5);
		for v52 = 1, p21.Times and 1 do
			for v53 = 1, 3 do
				for v54 = v50, 5 + (v50 - 1) do
					v51.ImageRectOffset = Vector2.new((v54 - 1) * 200, (v53 - 1) * 200);
					l__Utilities__1.Halt(0.075);
				end;
			end;
			l__Utilities__1.Halt(0.075);
		end;
		l__Tween__5:MakeTween(p20, {
			ImageColor3 = p20.ImageColor3
		}, true, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		wait(0.2);
	end;
	function v1.Rage(p22, p23)
		if p23.Wait then

		end;
		if p23.Pitch then

		end;
		if p23.Volume then

		end;
		if p23.Flipped then

		end;
		if p23.Flipped then
			local v55 = 2;
		else
			v55 = 1;
		end;
		local v56 = u2("http://www.roblox.com/asset/?id=7244909640", Vector2.new(200, 200), Color3.fromRGB(255, 255, 255), p23.Size and 1);
		v56.ZIndex = p22.ZIndex + 5;
		v56.Parent = u3(p22);
		v56.Rotation = p23.Rotation and 0;
		p1.Sound:PlayId(7244996487, 1, 3);
		l__Tween__5:MakeTween(p22, {
			ImageColor3 = Color3.fromRGB(228, 90, 82)
		}, true, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		for v57 = 1, p23.Times and 1 do
			for v58 = 1, 3 do
				for v59 = v55, 5 + (v55 - 1) do
					v56.ImageRectOffset = Vector2.new((v59 - 1) * 200, (v58 - 1) * 200);
					l__Utilities__1.Halt(0.05);
				end;
			end;
			l__Utilities__1.Halt(0.05);
		end;
		l__Tween__5:MakeTween(p22, {
			ImageColor3 = p22.ImageColor3
		}, true, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		wait(0.2);
	end;
	local function u6(p24)
		local v60 = u2("http://www.roblox.com/asset/?id=7245302521", Vector2.new(0, 0), Color3.fromRGB(255, 255, 255), 0.5);
		v60.Rotation = math.random(-30, 30);
		v60.ZIndex = 10;
		v60.ImageTransparency = 1;
		return v60;
	end;
	local function u7(p25)
		local l__X__61 = p25.AbsoluteSize.X;
		local v62 = u2("http://www.roblox.com/asset/?id=7245302192", Vector2.new(0, 0), Color3.fromRGB(255, 255, 255), 1);
		v62.ImageTransparency = 1;
		v62.ZIndex = p25.ZIndex - 1;
		v62.Position = UDim2.new(0.5, 0, 0.5, 0);
		v62.Name = "Fog";
		v62.Parent = p25;
		l__Utilities__1.FastSpawn(function()
			p1.Tween:MakeTween(p25, {
				ImageTransparency = math.random(45, 55) * 0.01
			}, true, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			p1.Tween:MakeTween(v62, {
				ImageTransparency = 0.3
			}, true, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			l__Utilities__1.Halt(0.25);
			p1.Tween:MakeTween(v62, {
				ImageTransparency = 1
			}, true, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			p1.Tween:MakeTween(p25, {
				ImageTransparency = 1, 
				Size = p25.Size + UDim2.new(0.1, 0, 0.1, 0)
			}, true, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			l__Utilities__1.Halt(0.51);
			p25:Destroy();
		end);
		return v62;
	end;
	function v1.Frozen(p26, p27)
		if p27.Size then

		end;
		if p27.Times then

		end;
		local v63 = Color3.fromRGB(255, 255, 255);
		if p27.Wait then

		end;
		if p27.Pitch then

		end;
		if p27.Volume then

		end;
		if p27.Rotation then

		end;
		if p27.Flipped then

		end;
		local v64 = Vector2.new(200, 200);
		if p27.Flipped then

		end;
		p1.Gui:Cancel(p26);
		p1.Sound:PlayId(747238556, 1, 3);
		l__Tween__5:MakeTween(p26, {
			ImageColor3 = Color3.fromRGB(170, 255, 255)
		}, true, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		for v65 = 1, 6 do
			local v66 = u6(p26);
			v66.Position = UDim2.new(0.5 - math.random(-3, 3) * 0.1, 0, 0.5 - math.random(-2, 2) * 0.1, 0);
			v66.Parent = p26;
			l__Utilities__1.FastSpawn(function()
				u7(v66);
			end);
			l__Utilities__1.Halt(0.05);
		end;
		l__Utilities__1.Halt(0.5);
		l__Tween__5:MakeTween(p26, {
			ImageColor3 = p26.ImageColor3
		}, true, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		wait(0.2);
	end;
	function v1.Marked(p28)
		local v67 = u2("http://www.roblox.com/asset/?id=7254684297", Vector2.new(300, 300), Color3.fromRGB(255, 255, 255), 0.75);
		v67.ZIndex = p28.ZIndex + 5;
		v67.AnchorPoint = Vector2.new(0.5, 0.5);
		v67.Position = UDim2.new(-4, 0, 0.5, 0);
		v67.ImageTransparency = 1;
		v67.Parent = p28;
		p1.Tween:MakeTween(v67, {
			ImageTransparency = 0
		}, true, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		l__Utilities__1.Halt(0.2);
		l__Tween__5:MakeTween(v67, {
			Position = UDim2.new(0.5, 0, 0.5, 0)
		}, true, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
		l__Utilities__1.Halt(0.3);
		p1.Sound:Play("Claw");
		l__Tween__5:MakeTween(v67, {
			Position = UDim2.new(0.5, 0, 0.5, 0)
		}, true, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
		l__Utilities__1.Halt(0.5);
		p1.Tween:MakeTween(v67, {
			ImageTransparency = 1, 
			Size = p28.Size + UDim2.new(0.2, 0, 0.2, 0)
		}, true, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		l__Utilities__1.Halt(0.4);
		v67:Destroy();
	end;
	function v1.Sleep(p29)
		local v68 = u2("http://www.roblox.com/asset/?id=7314710841", Vector2.new(300, 300), Color3.fromRGB(170, 170, 255), 0);
		v68.ZIndex = v68.ZIndex + 5;
		v68.AnchorPoint = Vector2.new(0.5, 0.5);
		v68.Position = UDim2.new(0.5, 0, 0.5, 0);
		v68.ImageTransparency = 1;
		v68.Parent = p29;
		p1.Sound:Play("Snore", 1, 6);
		for v69 = 1, 3 do
			local v70 = v68:Clone();
			v70.Parent = p29;
			p1.Tween:MakeTween(v70, {
				ImageTransparency = 0, 
				Size = v70.Size + UDim2.new(0.5 + v69 / 10, 0, 0.5 + v69 / 10, 0), 
				Position = v70.Position - UDim2.new(0, 0, 0.25 + v69 / 10, 0)
			}, true, 0.66, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
			l__Utilities__1.Halt(0.33);
			l__Utilities__1.FastSpawn(function()
				p1.Tween:MakeTween(v70, {
					ImageTransparency = 1
				}, true, 0.66, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
				l__Utilities__1.Halt(0.66);
				v70:Destroy();
			end);
		end;
		v68:Destroy();
	end;
	function v1.HealSparkle(p30)
		local v71 = { UDim2.new(0.498, 0, 0.349, 0), UDim2.new(0.243, 0, 0.796, 0), UDim2.new(0.742, 0, 0.712, 0), UDim2.new(0.5, 0, 0.5, 0) };
		p1.Sound:Play("RestoreHealth", 1, 2);
		local v72 = 1 - 1;
		while true do
			l__Utilities__1.Halt(0.25);
			local u8 = v72;
			l__Utilities__1.FastSpawn(function()
				local l__ImageColor3__73 = p30.ImageColor3;
				local v74 = u2("http://www.roblox.com/asset/?id=7329394075", Vector2.new(250, 250), Color3.fromRGB(170, 255, 255), 0.5);
				v74.ZIndex = p30.ZIndex + 5;
				v74.Position = v71[u8];
				v74.Parent = u3(p30);
				p1.Sound:PlayId(18472672, 1, 0.5);
				for v75 = 1, 1 do
					for v76 = 1, 3 do
						for v77 = 1, 4 do
							v74.ImageRectOffset = Vector2.new((v77 - 1) * 250, (v76 - 1) * 250);
							l__Utilities__1.Halt(0.05);
						end;
					end;
					l__Utilities__1.Halt(0.05);
				end;
				v74:Destroy();
			end);
			if 0 <= 1 then
				if not (u8 < 3) then
					break;
				end;
			elseif not (u8 > 3) then
				break;
			end;
			u8 = u8 + 1;		
		end;
	end;
	function v1.RageTiny(p31, p32)
		if p32.Wait then

		end;
		if p32.Pitch then

		end;
		if p32.Volume then

		end;
		if p32.Flipped then

		end;
		if p32.Flipped then
			local v78 = 2;
		else
			v78 = 1;
		end;
		local v79 = u2("http://www.roblox.com/asset/?id=7244909640", Vector2.new(200, 200), Color3.fromRGB(255, 255, 255), p32.Size and 0.5);
		v79.Position = UDim2.new(0.25, 0, 0.25, 0);
		v79.ZIndex = p31.ZIndex + 5;
		v79.Rotation = p32.Rotation and 0;
		local v80 = v79:Clone();
		v80.Position = UDim2.new(0.75, 0, 0.25, 0);
		v79.Parent = u3(p31);
		v80.Parent = u3(p31);
		p1.Sound:PlayId(7244996487, 1, 3);
		l__Tween__5:MakeTween(p31, {
			ImageColor3 = Color3.fromRGB(228, 90, 82)
		}, true, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		for v81 = 1, p32.Times and 1 do
			for v82 = 1, 3 do
				for v83 = v78, 5 + (v78 - 1) do
					v79.ImageRectOffset = Vector2.new((v83 - 1) * 200, (v82 - 1) * 200);
					v80.ImageRectOffset = Vector2.new((v83 - 1) * 200, (v82 - 1) * 200);
					l__Utilities__1.Halt(0.05);
				end;
			end;
			l__Utilities__1.Halt(0.05);
		end;
		l__Tween__5:MakeTween(p31, {
			ImageColor3 = p31.ImageColor3
		}, true, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		wait(0.2);
	end;
	return v1;
end;
