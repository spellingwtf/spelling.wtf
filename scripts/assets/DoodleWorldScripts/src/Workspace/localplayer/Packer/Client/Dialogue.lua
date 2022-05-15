-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = {};
	local l__Utilities__2 = p1.Utilities;
	local u1 = {};
	local u2 = { 0.4, 0.36, 0.33, 0.32, 0.31, 0.3, 0.28, 0.27, 0.25, 0.23, 0.21, 0.19 };
	function v1.TextSize(p2, p3)
		local l__Talk__3 = p1.Talky.Talk;
		l__Talk__3.Fits.Text = p3;
		local l__AbsoluteSize__4 = p1.Talky.AbsoluteSize;
		local v5 = 0.495;
		for v6, v7 in pairs(u2) do
			l__Talk__3.Fits.TextSize = v7 * l__AbsoluteSize__4.Y;
			if l__Talk__3.Fits.TextFits then
				v5 = v7;
				break;
			end;
		end;
		l__Talk__3.TextSize = v5 * l__AbsoluteSize__4.Y;
		l__Talk__3.DropShadow.TextSize = v5 * l__AbsoluteSize__4.Y;
	end;
	local u3 = nil;
	local u4 = nil;
	function v1.Fire(p4)
		u3 = true;
		u4 = true;
		p1.Dialogue:Hide();
		l__Utilities__2.Halt(0.275);
	end;
	local u5 = nil;
	function v1.IsVisible(p5)
		return u5.Visible;
	end;
	local u6 = nil;
	local function u7()
		for v8, v9 in pairs(u1) do
			v9:Disconnect();
		end;
	end;
	local u8 = nil;
	local u9 = l__Utilities__2.Signal();
	local u10 = nil;
	local u11 = nil;
	local u12 = nil;
	local u13 = nil;
	local u14 = l__Utilities__2.Signal();
	local u15 = nil;
	local u16 = nil;
	local function u17(p6, p7)
		local v10 = p6;
		local v11 = {
			["<NAME>"] = p1.p.DisplayName
		};
		if p7 then
			for v12, v13 in pairs(p7) do
				if v11[v12] <= v13[1] then
					return u17(v13[2]);
				end;
			end;
		end;
		for v14, v15 in pairs(v11) do
			v10 = v10:gsub(v14, v11);
		end;
		return v10;
	end;
	local u18 = false;
	function v1.ForceStop(p8)
		u18 = true;
	end;
	local u19 = nil;
	local u20 = nil;
	local u21 = nil;
	local u22 = nil;
	local u23 = nil;
	function v1.BeamKill(p9, p10)
		if p10 == u19 then
			return false;
		end;
		if u20 then
			u20:Destroy();
		end;
		if u21 then
			u21:Destroy();
		end;
		if u22 then
			u22:Disconnect();
		end;
		if u23 then
			u23:Disconnect();
		end;
		u19 = nil;
		return true;
	end;
	function v1.MakeBeam(p11, p12)
		if not v1:BeamKill(p12) then
			return;
		end;
		if typeof(p12) == "table" and p12.Model and p12.Model:FindFirstChild("Head") then
			u19 = p12.Model;
			local l__AbsoluteSize__16 = p1.guiholder.AbsoluteSize;
			local v17 = l__AbsoluteSize__16.X / 2;
			local l__AbsoluteSize__18 = p1.Talky.AbsoluteSize;
			local l__AbsolutePosition__19 = p1.Talky.AbsolutePosition;
			local v20 = l__AbsolutePosition__19.Y + l__AbsoluteSize__18.Y / 2;
			local v21 = l__Utilities__2:Create("Part")({
				Anchored = true, 
				CanCollide = false, 
				Size = Vector3.new(0.2, 0.2, 0.2), 
				CFrame = p1.Camera:ScreenPointToRay(v17, v20, 2), 
				Transparency = 1
			});
			v21.Parent = p12.Model;
			local v22 = l__Utilities__2:Create("Beam")({
				Width0 = 0.3, 
				Width1 = 0, 
				Transparency = NumberSequence.new(0), 
				FaceCamera = true, 
				Attachment0 = l__Utilities__2:Create("Attachment")({
					Parent = v21
				}), 
				Attachment1 = l__Utilities__2:Create("Attachment")({
					Parent = p12.Model.Head, 
					Position = Vector3.new(0, 0.65, -0.6)
				}), 
				Color = ColorSequence.new(Color3.fromRGB(50, 50, 50)), 
				Texture = "http://www.roblox.com/asset/?id=2807298556"
			});
			u20 = v21;
			u21 = v22;
			v22.Parent = p12.Model;
			local u24 = v17;
			local u25 = v20;
			u22 = workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(function()
				v21.CFrame = p1.Camera:ScreenPointToRay(u24, u25, 2);
			end);
			local u26 = l__AbsoluteSize__18;
			local u27 = l__AbsolutePosition__19;
			u23 = p1.Talky:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				u26 = p1.Talky.AbsoluteSize;
				u27 = p1.Talky.AbsolutePosition;
				u24 = l__AbsoluteSize__16.X / 2;
				u25 = u27.Y + u26.Y / 2;
				v21.CFrame = p1.Camera:ScreenPointToRay(u24, u25, 2);
			end);
		end;
	end;
	local u28 = false;
	function v1.Hide(p13)
		p1.Dialogue:BeamKill();
		u28 = nil;
		p1.Talky.Visible = false;
	end;
	local function u29()
		u5 = p1.Talky;
		u11 = u5.NPCName;
		u10 = u5.Talk;
		u8 = u5.Next;
		u6 = u5.Choice;
		u13 = u6.Yes;
		u16 = u6.No;
		p1.Gui:TextHover(u13);
		p1.Gui:TextHover(u16);
		p1.Gui:Hover(u8);
	end;
	local function u30(p14, p15, p16, p17, p18)
		local v23 = p1.Settings:Get("TextSpeed");
		local v24 = nil;
		u4 = nil;
		if p15:find("%[NONEXT%]") then
			v24 = true;
			p15 = p15:gsub("%[NONEXT%]", "");
		end;
		local v25 = nil;
		u6.Visible = false;
		u3 = false;
		u7();
		local u31 = nil;
		table.insert(u1, (u8.MouseButton1Click:connect(function()
			if u3 == false then
				u3 = true;
				return;
			end;
			if u3 == true then
				u31 = true;
				u9:Fire();
			end;
		end)));
		local u32 = nil;
		local u33 = nil;
		local v26 = game:GetService("UserInputService").InputEnded:Connect(function(p19)
			if p19.KeyCode == Enum.KeyCode.Q then
				u33 = true;
			end;
		end);
		table.insert(u1, (game:GetService("UserInputService").InputBegan:Connect(function(p20)
			if u32 == true and (p20.UserInputType == Enum.UserInputType.MouseButton1 or p20.UserInputType == Enum.UserInputType.Touch) then
				if u3 == false then
					u3 = true;
					return;
				end;
				if u3 == true then
					u9:Fire();
					return;
				end;
			elseif p20.KeyCode == Enum.KeyCode.Q then
				if u3 == false then
					u3 = true;
					u33 = false;
					l__Utilities__2.Halt(0.25);
					if u33 == true then
						u31 = true;
						u9:Fire();
						return;
					end;
				elseif u3 == true then
					u31 = true;
					u9:Fire();
				end;
			end;
		end)));
		table.insert(u1, v26);
		if v24 == true then
			u8.Visible = false;
		else
			u8.Visible = p17 ~= "Autoskip";
		end;
		u10.Size = UDim2.new(0.879, 0, 0.675, 0);
		u10.Position = UDim2.new(0.027, 0, 0.275, 2);
		if p14 == "" then
			u10.Size = UDim2.new(0.879, 0, 0.9, 0);
			u10.Position = UDim2.new(0.027, 0, 0.1, 0);
		end;
		p1.Gui:ChangeText(u11, p14);
		p1.Gui:ChangeText(u10, "");
		p1.Gui:DialogueTextSize(u10, p15);
		u5.Visible = true;
		for v27 = 1, #p15, v23 do
			if u4 then
				break;
			end;
			if v27 > 5 then
				u32 = true;
			elseif #p15 <= 5 then
				u32 = true;
			end;
			if u3 == false then
				p1.Gui:ChangeText(u10, p15:sub(1, v27), nil, true);
				p1.Sound:Play("Blip", nil, 0.2);
				l__Utilities__2.Halt();
			elseif u3 == true then
				break;
			end;
		end;
		u32 = true;
		p1.Gui:ChangeText(u10, p15, nil, true);
		u3 = true;
		if not u4 then
			if p17 == "Autoskip" then
				l__Utilities__2.Halt(0.75);
			elseif p16 then
				u12 = u13.MouseButton1Click:Connect(function()
					p1.Sound:Play("BasicClick");
					u14:Fire("Yes");
				end);
				u15 = u16.MouseButton1Click:Connect(function()
					p1.Sound:Play("BasicClick", 0.75);
					u14:Fire("No");
				end);
				u8.Visible = false;
				u6.Visible = true;
			else
				u8.Visible = true;
				u6.Visible = false;
			end;
		end;
		table.insert(u1, u12);
		table.insert(u1, u15);
		if p17 ~= "Autoskip" and not u4 then
			if p16 then
				v25 = u14:Wait();
			else
				u9:Wait();
			end;
		end;
		u7();
		if not v25 or u31 == true then
			l__Utilities__2.Halt(0.25);
		end;
		if u4 or p18 then
			p1.Dialogue:Hide();
		end;
		return v25;
	end;
	function v1.Run(p21, p22, p23, p24, p25, p26, p27, p28, p29)
		p1.ObjectiveUI:Hide();
		p1.Controls:ToggleWalk(false);
		p1.Menu.MenuGui:TweenPosition(UDim2.new(0.5, 0, -1, 0), "Out", "Quad", 0.1, true);
		p1.ClientDatabase:PDSEvent("ToggleBusy", true);
		u29();
		u18 = false;
		p1.Menu:Disable();
		u7();
		if not p29 then
			v1:MakeBeam(p23);
		end;
		local v28 = nil;
		for v29, v30 in pairs(p22) do
			local v31 = typeof(v30);
			if u18 then
				u18 = false;
				break;
			end;
			if v31 == "table" then
				v28 = u30(p22.Name and p24, u17(v30.String, v30.Special), v30.YesNo, p23, p28);
				if p27 then
					return v28;
				end;
				if v28 then
					v1:Run(v1:GetStageInfo(v30[v28], nil, true), p23, p24, p25, p28);
				end;
			elseif v31 == "function" then
				v30(p23);
			end;
		end;
		p1.ObjectiveUI:Show();
		if p23 == "Maintain" then
			v1:Hide();
		end;
		if p25 then
			return;
		end;
		v1:Hide();
		p1.ClientDatabase:PDSEvent("ToggleBusy", false);
		if not (not v28) or p23 == "Autoskip" or not (not p26) then
			if p26 then
				v1:BeamKill();
			end;
			return;
		end;
		v1:BeamKill();
		p1.Menu:Enable();
		p1.Controls:ToggleWalk(true);
	end;
	function v1.GetStageInfo(p30, p31, p32, p33)
		local v32 = p33 and p31 or (p31.Dialogue[p32] or {});
		local v33 = v32.Name and "";
		local v34 = v32.Icon and "";
		local l__Talk__35 = v32.Talk;
		local v36 = {};
		if l__Talk__35 then
			for v37, v38 in pairs(l__Talk__35) do
				if typeof(v38) == "table" then
					local v39 = false;
					if p31.CutsceneCheck and p31.CutsceneCheck() then
						v39 = true;
					end;
					table.insert(v36, v37, {
						String = v38.Talking, 
						Icon = v34, 
						Name = v38.Name and v38.Name or v33, 
						Special = v38.Special, 
						YesNo = v38.YesNo, 
						Yes = v38.Yes, 
						No = v38.No, 
						DisableBeam = v39
					});
				elseif typeof(v38) == "function" then
					table.insert(v36, v37, v38);
				end;
			end;
		end;
		return v36;
	end;
	local u34 = nil;
	function v1.Talk(p34, p35, p36)
		if not u28 then
			local v40 = 1;
			if p35.NPCId then
				local v41 = tostring(p35.NPCId);
				u34 = u34 or p1.ClientDatabase:PDSFunc("GetProgression", true);
				if u34[v41] then
					v40 = u34[v41];
				end;
			end;
			local v42 = v1:GetStageInfo(p35, v40);
			local v43 = nil;
			if p35.CutsceneCheck and p35.CutsceneCheck() then
				v43 = true;
			end;
			if #v42 > 0 then
				v1:Run(v42, p36, p35.Name and "", nil, nil, nil, nil, v43);
			end;
			u28 = nil;
		end;
	end;
	local u35 = nil;
	p1.Network:BindEvent("UpdateProgression", function(p37, p38)
		u34 = p37;
		u35 = p38;
	end);
	p1.Network:BindEvent("UpdateKeys", function(p39)
		p1.KeysObtained = p39;
	end);
	function v1.SaySimple(p40, p41, p42, p43)
		local v44 = {
			Dialogue = { {
					Talk = {
						YesNo = true,
						{
							Talking = p41
						}
					}
				} }, 
			Name = p43
		};
		return v1:Run(v1:GetStageInfo(v44, 1), p42, v44.Name and "", nil, true);
	end;
	function v1.SaySimpleYesNo(p44, p45, p46, p47)
		local v45 = {
			Dialogue = { {
					Talk = { {
							Talking = p45, 
							YesNo = true
						} }
				} }, 
			Name = p47
		};
		return v1:Run(v1:GetStageInfo(v45, 1), p46, v45.Name and "", nil, true, true);
	end;
	function p1.GetProgression(p48)
		if u34 == nil then
			local v46, v47 = p1.ClientDatabase:PDSFunc("GetProgression", true);
			u34 = v46;
			u35 = v47;
		end;
		return u34, u35;
	end;
	return v1;
end;
