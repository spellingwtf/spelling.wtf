-- Decompiled with the Synapse X Luau decompiler.

local u1 = false;
return function(p1)
	local v1 = {};
	local l__Utilities__2 = p1.Utilities;
	local u3 = 16;
	local function u4(p2)
		local l__Humanoid__2 = p2:WaitForChild("Humanoid");
		p2.Parent = workspace.TargetFilter;
		l__Humanoid__2.Running:Connect(function(p3)
			u3 = math.floor(p3);
		end);
		l__Humanoid__2:SetStateEnabled(Enum.HumanoidStateType.Swimming, false);
	end;
	p1.p.CharacterAdded:Connect(function(p4)
		u4(p4);
	end);
	u4(p1.p.Character or p1.p.CharacterAdded:wait());
	local l__LocalPlayer__5 = game.Players.LocalPlayer;
	local u6 = nil;
	local function u7(p5)
		p1.Controls:ToggleWalk(false);
		local v3, v4 = p1.Battle:WildBattle(p5.Name);
		u1 = true;
		if not v3:Wait() then
			p1.Wipeout[v4].func();
		end;
		l__Utilities__2.Halt(3);
		u1 = false;
	end;
	function v1.Start(p6)
		if p1.TestMode then

		end;
		while true do
			local v5 = l__LocalPlayer__5.Character or l__LocalPlayer__5.CharacterAdded:wait();
			local l__HumanoidRootPart__6 = v5:FindFirstChild("HumanoidRootPart");
			if u3 > 6 and l__HumanoidRootPart__6 and p1.p.AAF.Value == false and not u1 and v5:FindFirstChild("Humanoid"):GetState() ~= Enum.HumanoidStateType.Climbing then
				l__Utilities__2.Halt(0.015);
				local v7 = l__Utilities__2:IsInGrass(Ray.new(l__HumanoidRootPart__6.Position, Vector3.new(0, -1, 0).unit * 12), l__HumanoidRootPart__6.Parent);
				if v7 and not p1.Battle.RequestBattle and not p1.TrainerEncounter and not p1.InCutscene then
					local v8 = 1200;
					if u6 == "Incandescent" then
						v8 = 1000;
					end;
					if _G.PlayerRunning then
						v8 = v8 * 0.9;
					end;
					if v8 <= math.random(1, 1300) then
						p1.Battle.RequestBattle = true;
						u7(v7);
					end;
				end;
			end;
			l__Utilities__2.Halt(0.33);		
		end;
	end;
	local u8 = { "Glubbie", "Maelzuri" };
	p1.Network:BindEvent("UpdateChain", function(p7)
		local l__CurrentChain__9 = p1.guiholder.CurrentChain;
		if not (p7.Number >= 10) and not table.find(u8, p7.Name) then
			l__CurrentChain__9.Visible = false;
			return;
		end;
		l__CurrentChain__9.CurrentNumber.Text = l__Utilities__2.AddComma(p7.Number);
		l__CurrentChain__9.Image = p1.DoodleInfo[p7.Name].FrontSprite;
		l__CurrentChain__9.Visible = true;
	end);
	p1.Network:BindEvent("UpdateLeadAbility", function(p8)
		u6 = p8;
	end);
	return v1;
end;
