-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = l__Utilities__1.Class({
		ClassName = "EvolutionScreen"
	}, function(p2)
		p1.ClientDatabase:PDSEvent("ToggleBusy", true);
		p1.Overworld:RainStop();
		local v3 = p1.Camera.ReturnCutscene();
		local l__Doodle__4 = p2.Doodle;
		if l__Doodle__4.Evolve == nil then
			setmetatable(p2, nil);
			return;
		end;
		local l__DoodleBrick__5 = workspace.DoodleBrick;
		local v6 = l__DoodleBrick__5.Position + Vector3.new(0, 2.5, 0);
		l__DoodleBrick__5.Gui.DoodleFront.Sprite.Size = UDim2.new(0.8, 0, 0.8, 0);
		local v7 = p1.Gui:AnimateSprite(l__DoodleBrick__5.Gui.DoodleFront.Sprite, l__Doodle__4, true);
		local v8 = CFrame.new(v6 + l__DoodleBrick__5.CFrame.lookVector * 15, v6);
		p1.Camera.SetCutscene(true, "NoCamera");
		p1.Camera:Scriptable(v8, true);
		p1.Menu.Blur();
		p1.Gui:FadeFromBlack();
		p1.Dialogue:Run(p1.Dialogue:GetStageInfo(p2:MakeTalkTable(l__Doodle__4, v7, v8, true), nil, true), nil, "", true);
		p1.Talky.Visible = false;
		if not p2.ItemEvolution then
			p1.Gui:FadeToBlack();
			p1.Menu.DisableBlur();
		end;
		if not v3 then
			p1.Camera.SetCutscene(nil, "NoCamera");
		end;
		p1.ClientDatabase:PDSEvent("ToggleBusy", false);
		return p2;
	end);
	function v2.Change(p3)
		local l__Evolved__9 = p3.Evolved;
		local l__Doodle__10 = p3.Doodle;
	end;
	function v2.WeatherCheck(p4)
		if p1.StoryWeather == "ThunderousRain" and _G.NoWind == nil and not _G.NoRain and not _G.InBuilding then
			p1.Overworld:RandomBoltSpot();
			p1.Overworld:Rain();
			p1.Overworld:Cloudy(true);
			return;
		end;
		p1.Overworld:RainStop();
		p1.Overworld:Cloudy(false);
	end;
	local function u1(p5, p6)
		p5.Moves[5] = {
			Name = p6, 
			PPUp = 0, 
			Uses = p1.Moves[p6].Uses
		};
	end;
	local function u2(p7, p8, p9)
		local v11 = nil;
		local v12, v13, v14 = pairs(p8);
		while true do
			local v15, v16 = v12(v13, v14);
			if not v15 then
				break;
			end;
			local v17 = false;
			for v18, v19 in pairs(p7) do
				if v16.Name == v19.Name then
					v17 = true;
					break;
				end;
			end;
			if not v17 then
				v11 = v16.Name;
				break;
			end;		
		end;
		if v11 ~= nil and v11 ~= p9 then
			return "MoveForgotten", v11;
		end;
		return "DidNotLearn";
	end;
	function v2.MakeTalkTable(p10, p11, p12, p13)
		local v20 = {};
		local v21 = {};
		local v22 = {
			Talking = l__Utilities__1.GetName(p11) .. " is about to evolve. Do you want to proceed?", 
			YesNo = true
		};
		local v23 = {};
		local v24 = {};
		local u3 = nil;
		local u4 = nil;
		local u5 = nil;
		v24[1] = function()
			p1.Music:PlaySong("EvolutionTheme", true);
			p1.Camera:Earthquake();
			local v25, v26, v27 = p1.Network:get("EvolveRequest", p11.ID, true);
			u3 = v25;
			u4 = v26;
			u5 = v27;
			p10.Evolved = u3;
			p10.Doodle.Name = p10.Evolved.Name;
			if p10.Party then
				local v28 = p10.Party:UpdateDoodle(p10.Evolved);
				p10.Party:SetupBox(p10.Party.PartyGui["Party" .. v28], p10.Doodle);
				p1.Gui:ChangeText(p10.Party.PartyGui["Party" .. v28].DoodleName.Label, l__Utilities__1.GetName(u3));
			end;
		end;
		v24[2] = {
			Talking = "Woah! " .. l__Utilities__1.GetName(p11) .. " is evolving!"
		};
		v24[3] = function()
			p1.Dialogue:Hide();
			local v29, v30, v31 = p1.Gui:GetGuiSize(p12, u3);
			local l__Size__6 = p12.Size;
			p1.Services.ContentProvider:PreloadAsync({ v31 }, function()
				p12:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 1, true);
				l__Utilities__1.Halt(1);
				p12:TweenSize(l__Size__6, "Out", "Quad", 0.75, true);
				l__Utilities__1.Halt(0.75);
				p12:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.5, true);
				l__Utilities__1.Halt(0.5);
				p12:TweenSize(l__Size__6, "Out", "Quad", 0.5, true);
				l__Utilities__1.Halt(0.5);
				p12:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.25, true);
				l__Utilities__1.Halt(0.4);
				p12.Image = v31;
				p1.Camera:StopShake();
				l__Utilities__1.Halt(0.2);
				p1.Tween:PlayTween(workspace.CurrentCamera, {
					CFrame = p13
				}, true, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
				l__Utilities__1.Halt(0.1);
				workspace.CurrentCamera.CFrame = p13;
				p12:TweenSizeAndPosition(v29, v30, "Out", "Linear", 1.5, true);
				l__Utilities__1.Halt(1.5);
			end);
			if p10.Item then
				p1.Network:post("SubtractOne", p10.Item);
			end;
			l__Utilities__1.Halt(5);
		end;
		v24[4] = {
			Talking = l__Utilities__1.GetName(p11) .. " evolved into " .. p11.Evolve .. "!"
		};
		v24[5] = function()
			for v32, v33 in pairs(u4) do
				p1.Gui:SayText("", l__Utilities__1.GetName(u3) .. " learned " .. v33 .. "!", nil, true);
			end;
			local v34 = nil;
			if typeof(u5) == "table" then
				for v35, v36 in pairs(u5) do
					local u7 = v34;
					p1.Gui:SayChoiceText("", l__Utilities__1.GetName(u3) .. " wants to learn " .. v36 .. " but can't learn more than 4 moves. Make room for " .. v36 .. "?", nil, function()
						p1.Menu:Disable();
						p1.Dialogue:Hide();
						u7 = u7 or l__Utilities__1:deepCopy(p11.Moves);
						p11.Moves = u7;
						u1(u3, v36);
						local v37 = {
							BattleAppear = true
						};
						local u8 = l__Utilities__1:deepCopy(u3.Moves);
						function v37.CloseFunc(p14)
							p10.Doodle = p1.Network:get("RemoveExtraMove", p14.ID, true);
							local v38, v39 = u2(p10.Doodle.Moves, u8, v36);
							if v38 == "DidNotLearn" then
								p1.Gui:SayText("", l__Utilities__1.GetName(u3) .. " did not learn " .. v36 .. ".", nil, true);
							elseif v38 == "MoveForgotten" then
								p1.Gui:SayText("", l__Utilities__1.GetName(u3) .. " forgot " .. v39 .. " and learned " .. v36 .. "!", nil, true);
							end;
							u7 = l__Utilities__1:deepCopy(p10.Doodle.Moves);
							p10.Evolved.Moves = u7;
							if p10.Party then
								p10.Party:SetupBox(p10.Party.PartyGui["Party" .. p10.Party:UpdateDoodle(p10.Evolved)], p10.Evolved);
							end;
							p1.MoveLearn:Fire();
						end;
						v37.LearningMove = true;
						p1.Stats.new(v37, u3);
					end, function()
						l__Utilities__1.FastSpawn(function()
							p1.Gui:SayText("", l__Utilities__1.GetName(u3) .. " did not learn " .. v36 .. ".", nil, true);
							p10.Doodle = p1.Network:get("RemoveExtraMove", p11.ID, true);
							p1.MoveLearn:Fire();
						end);
					end);
					p1.MoveLearn:Wait();
				end;
			end;
			p10.Doodle = p10.Evolved;
			p1.Music:PlayPreviousSong();
			p10:WeatherCheck();
		end;
		v23.Talk = v24;
		v22.Yes = v23;
		v22.No = {
			Talk = { {
					Talking = l__Utilities__1.GetName(p11) .. " did not evolve."
				}, function()
					p1.Network:get("EvolveRequest", p11.ID, false);
					p1.Dialogue:Hide();
					p10:WeatherCheck();
				end }
		};
		v21[1] = v22;
		v20.Talk = v21;
		v20.Name = "";
		return v20;
	end;
	return v2;
end;
