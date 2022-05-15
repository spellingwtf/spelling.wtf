-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {};
	local l__Tween__1 = p1.Tween;
	function v1.Darken(p2, p3)
		l__Tween__1:MakeTween(p2.Background, {
			ImageColor3 = p3 or Color3.fromRGB(180, 180, 180)
		}, true, 0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
	end;
	function v1.Lighten(p4)
		l__Tween__1:MakeTween(p4.Background, {
			ImageColor3 = Color3.fromRGB(255, 255, 255)
		}, true, 0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
	end;
	local u2 = false;
	local l__Utilities__3 = p1.Utilities;
	local u4 = { "http://www.roblox.com/asset/?id=5786391147", "http://www.roblox.com/asset/?id=5786391924", "http://www.roblox.com/asset/?id=5786402416", "http://www.roblox.com/asset/?id=5786403140", "http://www.roblox.com/asset/?id=5786403786", "http://www.roblox.com/asset/?id=5786404110", "http://www.roblox.com/asset/?id=5786404547", "http://www.roblox.com/asset/?id=5786405099" };
	function v1.StartRain(p5)
		if u2 then
			u2 = nil;
		end;
		l__Utilities__3.Halt(0.06);
		v1.Darken(p5);
		u2 = true;
		p5.Effects.WeatherEffect.Position = UDim2.new(-0, 0, 0, 0);
		p5.Effects.WeatherEffect.ImageTransparency = 0;
		p5.Effects.WeatherEffect.Image = "http://www.roblox.com/asset/?id=5786391147";
		p5.Effects.WeatherEffect.ImageColor3 = Color3.fromRGB(255, 255, 255);
		p5.Effects.WeatherEffect.Visible = true;
		l__Utilities__3.FastSpawn(function()
			while u2 do
				for v2, v3 in ipairs(u4) do
					if not u2 then
						break;
					end;
					p5.Effects.WeatherEffect.Image = v3;
					l__Utilities__3.Halt(0.05);
				end;			
			end;
		end);
	end;
	function v1.AcidRain(p6)
		if u2 then
			u2 = nil;
		end;
		l__Utilities__3.Halt(0.06);
		v1.Darken(p6, Color3.fromRGB(45, 158, 0));
		u2 = true;
		p6.Effects.WeatherEffect.Position = UDim2.new(-0, 0, 0, 0);
		p6.Effects.WeatherEffect.ImageTransparency = 0;
		p6.Effects.WeatherEffect.Image = "http://www.roblox.com/asset/?id=5786391147";
		p6.Effects.WeatherEffect.ImageColor3 = Color3.fromRGB(0, 255, 0);
		p6.Effects.WeatherEffect.Visible = true;
		l__Utilities__3.FastSpawn(function()
			while u2 do
				for v4, v5 in ipairs(u4) do
					if not u2 then
						break;
					end;
					p6.Effects.WeatherEffect.Image = v5;
					l__Utilities__3.Halt(0.05);
				end;			
			end;
		end);
	end;
	function v1.ChocolateRain(p7)
		if u2 then
			u2 = nil;
		end;
		l__Utilities__3.Halt(0.06);
		v1.Darken(p7, Color3.fromRGB(112, 66, 20));
		u2 = true;
		p7.Effects.WeatherEffect.Position = UDim2.new(-0, 0, 0, 0);
		p7.Effects.WeatherEffect.ImageTransparency = 0;
		p7.Effects.WeatherEffect.Image = "http://www.roblox.com/asset/?id=5786391147";
		p7.Effects.WeatherEffect.ImageColor3 = Color3.fromRGB(112, 66, 20);
		p7.Effects.WeatherEffect.Visible = true;
		l__Utilities__3.FastSpawn(function()
			while u2 do
				for v6, v7 in ipairs(u4) do
					if not u2 then
						break;
					end;
					p7.Effects.WeatherEffect.Image = v7;
					l__Utilities__3.Halt(0.05);
				end;			
			end;
		end);
	end;
	function v1.Sandstorm(p8)
		if u2 then
			u2 = nil;
		end;
		l__Utilities__3.Halt(0.06);
		v1.Darken(p8);
		u2 = true;
		p8.Effects.WeatherEffect.Position = UDim2.new(-0, 0, 0, 0);
		p8.Effects.WeatherEffect.ImageTransparency = 0.5;
		p8.Effects.WeatherEffect.Image = "http://www.roblox.com/asset/?id=9146474359";
		p8.Effects.WeatherEffect.ImageColor3 = Color3.fromRGB(112, 66, 20);
		p8.Effects.WeatherEffect.Visible = true;
		l__Utilities__3.FastSpawn(function()
			while u2 do
				for v8 = 1, 9 do
					if not u2 then
						break;
					end;
					p8.Effects.WeatherEffect:TweenPosition(UDim2.new(-0.01 * v8, 0, -0, 0, 0), "Out", "Linear", 0.5, true);
					l__Utilities__3.Halt(0.05);
				end;
				if not u2 then
					break;
				end;
				p8.Effects.WeatherEffect.Position = UDim2.new(-0, 0, 0, 0);			
			end;
		end);
	end;
	function v1.Stop(p9)
		u2 = false;
		p9.Effects.WeatherEffect.Visible = false;
		v1.Lighten(p9);
	end;
	return v1;
end;
