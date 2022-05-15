-- Decompiled with the Synapse X Luau decompiler.

local l__RunService__1 = game:GetService("RunService");
local v2 = nil;
if l__RunService__1:IsServer() then
	v2 = require(script.Parent);
else
	while true do
		task.wait();
		if game.Players.LocalPlayer then
			break;
		end;	
	end;
	local l__LocalPlayer__3 = game.Players.LocalPlayer;
end;
local v4 = {
	GetUID = function()
		return game:GetService("HttpService"):GenerateGUID(false);
	end
};
local function u1(p1, p2)
	function p1.new(p3, ...)
		p3 = p3 or {};
		if typeof(p3) == "table" and not getmetatable(p3) then
			setmetatable(p3, p1);
		end;
		if p2 then
			p3 = p2(p3, ...) and p3;
		end;
		if type(p3) == "table" and not getmetatable(p3) then
			setmetatable(p3, p2);
		end;
		return p3;
	end;
	return p1;
end;
function v4.Class(p4, p5)
	p4 = p4 or {};
	p4.__index = p4;
	return u1(p4, p5);
end;
local u2 = nil;
function v4.SetupCF(p6)
	u2 = p6;
end;
local u3 = { "Grass", "WildGrass", "Lake", "Sewer", "CaveWater" };
function v4.IsInGrass(p7, p8, p9)
	local v5, v6 = workspace:FindPartOnRayWithIgnoreList(p8, { p9, workspace.Terrain });
	if v5 and table.find(u3, v5.Name) then
		return v5;
	end;
end;
function v4.deepCopy(p10, p11)
	local v7 = {};
	for v8, v9 in pairs(p11) do
		if type(v9) == "table" then
			v9 = v4:deepCopy(v9);
		end;
		v7[v8] = v9;
	end;
	return v7;
end;
function v4.shallowCopy(p12, p13)
	local v10 = {};
	for v11, v12 in pairs(p13) do
		v10[v11] = v12;
	end;
	return v10;
end;
function v4.IsInTable(p14, p15, p16)
	for v13, v14 in pairs(p16) do
		if v14 == p15 then
			return true;
		end;
	end;
	return false;
end;
function v4.GetSizeOfTable(p17, p18)
	local v15 = 0;
	for v16, v17 in pairs(p18) do
		v15 = v15 + 1;
	end;
	return v15;
end;
function v4.GetFront(p19, p20, p21, p22)
	local v18 = p20;
	if typeof(p20) == "Instance" and p20:IsA("BasePart") then
		v18 = p20.CFrame;
	end;
	if not v18 then
		return;
	end;
	local l__Position__19 = v18.Position;
	return CFrame.new(l__Position__19 + (p22 or Vector3.new(0, 0, 0)) + v18.lookVector * p21, l__Position__19);
end;
function v4.GetBack(p23, p24, p25, p26)
	local v20 = p24;
	if typeof(p24) == "Instance" and p24:IsA("BasePart") then
		v20 = p24.CFrame;
	end;
	if not v20 then
		return;
	end;
	local l__Position__21 = v20.Position;
	return CFrame.new(l__Position__21 + (p26 or Vector3.new(0, 0, 0)) + v20.lookVector * -1 * p25, l__Position__21);
end;
function v4.Create(p27, p28)
	return function(p29)
		local v22 = Instance.new(p28);
		for v23, v24 in pairs(p29) do
			local v25, v26 = pcall(function()
				if typeof(v24) ~= "function" then
					v22[v23] = v24;
					return;
				end;
				v22[v23]:Connect(v24);
			end);
			if not v25 then

			end;
		end;
		return v22;
	end;
end;
function v4.GetDistPosition(p30, p31, p32, p33)
	if p31 < (p32 - p33).magnitude then
		return false;
	end;
	return true;
end;
function v4.GetDistance(p34, p35, p36, p37)
	if p35 < (p36.Position - p37.Position).magnitude then
		return false;
	end;
	return true;
end;
function v4.FastSpawn(p38, ...)
	local v27 = v4.Signal();
	v27:Connect(p38);
	v27:Fire(...);
	v27.Signaler:Destroy();
end;
function v4.Signal()
	local v28 = {};
	local v29 = Instance.new("BindableEvent");
	v28.Signaler = v29;
	function v28.SetParent(p39, p40)
		v29.Parent = p40;
	end;
	local u4 = nil;
	local u5 = nil;
	function v28.Fire(p41, ...)
		u4 = { ... };
		u5 = select("#", ...);
		v29:Fire();
	end;
	function v28.Connect(p42, p43)
		if not p43 then
			error("connect(nil)", 2);
		end;
		return v29.Event:connect(function()
			p43(unpack(u4, 1, u5));
		end);
	end;
	function v28.Wait(p44)
		v29.Event:wait();
		return unpack(u4, 1, u5);
	end;
	function v28.Destroy(p45)
		v29:Destroy();
	end;
	return v28;
end;
function v4.GetStats(p46, p47)
	if p47.Stats then
		return p47.Stats;
	end;
	local v30 = {};
	if p47.hp then
		for v31, v32 in pairs({ "hp", "atk", "def", "matk", "mdef", "spe" }) do
			v30[v32] = p47[v32];
		end;
	end;
	return v30;
end;
function v4.GetIndexFromID(p48, p49, p50)
	for v33 = 1, 6 do
		if p50[v33] and p50[v33].ID == p49.ID then
			return v33;
		end;
	end;
end;
function v4.GetDoodleFromID(p51, p52, p53)
	for v34 = 1, 6 do
		if p52[v34] and p52[v34].ID == p53 then
			return p52[v34];
		end;
	end;
end;
local u6 = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };
function v4.ConvertDate(p54, p55)
	local v35 = p55.DateMet:split("/");
	return u6[tonumber(v35[1])] .. " " .. v35[2] .. ", " .. v35[3];
end;
function v4.GetDate(p56)
	local v36 = os.date("!*t");
	return v36.day, v36.month, v36.year;
end;
function v4.IsValidEnter(p57)
	if p57.UserInputType ~= Enum.UserInputType.MouseMovement and p57.UserInputType ~= Enum.UserInputType.Touch then
		return false;
	end;
	return true;
end;
local u7 = {};
function v4.GetNameFromUserId(p58)
	if u7[p58] then
		return u7[p58];
	end;
	local u8 = "";
	pcall(function()
		u8 = game.Players:GetNameFromUserIdAsync(p58);
	end);
	u7[p58] = u8;
	return "";
end;
function v4.GetRealName(p59)
	return p59.RealName or p59.Name;
end;
function v4.GetName(p60)
	return p60.Nickname or p60.Name;
end;
function v4.CreateColorSequence(p61, p62)
	local v37 = {};
	if p62 == "Fade" then
		return ColorSequence.new(p61[1]);
	end;
	for v38, v39 in pairs(p61) do
		if v38 == 1 then
			local v40 = 0;
		elseif v38 == #p61 then
			v40 = 1;
		else
			v40 = (v38 - 1) / (#p61 - 1);
		end;
		table.insert(v37, (ColorSequenceKeypoint.new(v40, v39)));
	end;
	if #p61 == 1 then
		table.insert(v37, ColorSequenceKeypoint.new(1, p61[1]));
	end;
	return ColorSequence.new(v37);
end;
function v4.AddComma(p63)
	local v41 = tostring(p63);
	return #v41 % 3 == 0 and v41:reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or v41:reverse():gsub("(%d%d%d)", "%1,"):reverse();
end;
local function u9(p64)
	return coroutine.wrap(function()
		local v42 = 1;
		while true do
			for v43, v44 in ipairs(p64:GetCurrentPage()) do
				coroutine.yield(v44, v42);
			end;
			if p64.IsFinished then
				break;
			end;
			p64:AdvanceToNextPageAsync();
			v42 = v42 + 1;		
		end;
	end);
end;
function v4.GetFriendList(p65)
	local v45 = {};
	for v46, v47 in u9((game.Players:GetFriendsAsync(p65.UserId))) do
		table.insert(v45, v46.Username);
	end;
	return v45;
end;
function v4.IsFriendsWith(p66, p67)
	if not p66 or not p67 then
		return;
	end;
	if p66:IsFriendsWith(p67.UserId) then
		return true;
	end;
	return false;
end;
function v4.MakeNotifWithPlayer(p68, p69, p70, p71)
	return {
		Title = p69, 
		Text = p70, 
		Icon = game.Players:GetUserThumbnailAsync(p68.UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size60x60), 
		Duration = p71 and 5
	};
end;
function v4.MakeNotif(p72, p73, p74, p75, p76)
	return {
		Title = p73, 
		Text = p74, 
		Icon = p76 and "", 
		Duration = p75 and 5
	};
end;
function v4.GetTrait(p77)
	local l__Ability__48 = p77.Ability;
	if not v2.Database.Traits[l__Ability__48] then
		warn(l__Ability__48, "No ability found");
		return {};
	end;
	return v2.Database.Traits[l__Ability__48];
end;
local u10 = {
	Paralysis = { "Spark" }, 
	Burn = { "Fire" }, 
	Frozen = { "Ice" }, 
	Cursed = { "Spirit" }, 
	Diseased = { "Poison" }, 
	Poison = { "Poison", "Metal", "Crystal" }
};
local function u11(p78, p79)
	local v49 = v2.Database.DoodleInfo[v4.GetRealName(p78)];
	if not u10[p79] then
		return false;
	end;
	for v50, v51 in pairs(u10[p79]) do
		if table.find(v49.Type, v51) then
			return true;
		end;
	end;
	return false;
end;
local u12 = {
	Paralysis = " is already paralyzed!", 
	Rage = " is already raging!", 
	Poison = " is already poisoned!", 
	Frozen = " is already frozen!", 
	Sleep = " is already asleep!", 
	Cursed = " is already cursed!", 
	Marked = " is already marked!", 
	Vulnerable = " is already vulnerable!", 
	Burn = " is already burned!", 
	Diseased = " is already diseased!"
};
function v4.InflictStatus(p80, p81, p82, p83, p84, p85, p86)
	if p82.currenthp <= 0 then
		return;
	end;
	if p80.Weather == "Acid Rain" and p84 == "Poison" then
		p84 = "Diseased";
	end;
	local v52 = p80:GetItemInfo(p82);
	local v53 = p80:GetSideFromDoodle(p82);
	if p82.currenthp > 0 then
		if v53 and v53.Safeguard then
			if p83 >= 100 then
				p80:AddDialogue(p80.ActionList, p82.Name .. "'s icy veil prevented them from getting " .. p84 .. "!");
			end;
			return;
		end;
		if (p82.Decoy or p82.DecoyKilled) and p81 ~= p82 then
			if p83 >= 100 and p84 ~= "Confuse" and p84 ~= "Flinch" and not p82.DecoyKilled then
				p80:AddDialogue(p80.ActionList, p82.Name .. "'s scapegoat prevented them from getting " .. p84 .. "!");
				return;
			else
				return;
			end;
		end;
		local v54 = v4.GetTrait(p81);
		if v54.StatusModifier then
			local v55, v56 = v54.StatusModifier(p80, p81, p82, p84, p83);
			p84 = v55;
			p83 = v56;
		end;
		local v57 = nil;
		local v58 = v4.GetTrait(p82);
		if v58.StatusFunc then
			local v59, v60, v61 = v58.StatusFunc(p80, p81, p82, p84, p83);
			p84 = v59;
			p83 = v60;
			v57 = v61;
		end;
		if p80.Weather == "Rain" and p84 == "Paralysis" then
			p83 = p83 * 2;
		end;
		if p83 ~= 100 and p81.Status == "Cursed" then
			return;
		end;
		if p84 == "Confuse" then
			if typeof(p83) ~= "number" then
				print("Not a real number");
				return;
			elseif math.random(1, 100) <= p83 then
				if p82.Confuse and p83 >= 100 then
					p80:AddDialogue(p80.ActionList, p82.Name .. " is already confused!");
					return;
				else
					p82.Confuse = math.random(2, 5);
					p80:AddDialogue(p80.ActionList, p82.Name .. " is now confused!");
					return;
				end;
			else
				return;
			end;
		end;
		if p84 == "Flinch" then
			if math.random(1, 100) <= p83 then
				p82.Flinch = true;
				return;
			else
				return;
			end;
		end;
		if p84 == "Flinch" or p84 == "Confuse" then
			if v57 and p83 >= 100 then
				p80:AddDialogue(p80.ActionList, v57);
			end;
			return;
		end;
		if p82.Status == nil and not u11(p82, p84) and not v57 then
			if typeof(p83) ~= "number" then
				print("Not a real number");
				return;
			end;
			if math.random(1, 100) <= p83 then
				if p86 then
					p80:AddDialogue(p80.ActionList, p86);
				end;
				p82.Status = p84;
				p80:StatusDisplay(p82);
				if p82 ~= p81 and typeof(p81.Owner) == "Instance" then
					p81:StatusAchievement(p84);
				end;
				if p84 == "Rage" then
					p82.StatusTurn = math.random(3, 4);
				elseif p84 == "Sleep" then
					p82.StatusTurn = math.random(2, 3);
				elseif p84 == "Frozen" then
					p82.StatusTurn = 5;
				elseif p84 == "Diseased" then
					p82.StatusTurn = 1;
				end;
				if v52 and v52.OnStatus then
					v52.OnStatus(p80, p82, p81);
					return;
				end;
			end;
		else
			if v57 then
				p80:AddDialogue(p80.ActionList, v57);
				return;
			end;
			if p85 and p83 >= 100 and v58.ImmuneStatus and table.find(v58.ImmuneStatus, p84) then
				p80:AddDialogue(p80.ActionList, p82.Name .. "is immune to " .. p84 .. "!");
				return;
			end;
			if p82.Status == p84 and p83 >= 100 and p85 then
				p80:AddDialogue(p80.ActionList, p82.Name .. u12[p84]);
				return;
			end;
			if p85 and p83 >= 100 and (u11(p82, p84) or p82.Status ~= nil) then
				p80:AddDialogue(p80.ActionList, "It has no effect!");
			end;
		end;
	end;
end;
local u13 = {
	eva = "Evasion", 
	acc = "Accuracy", 
	atk = "Attack", 
	def = "Defense", 
	mdef = "Magic Defense", 
	matk = "Magic Attack", 
	spe = "Speed"
};
function v4.ChangeStats(p87, p88, p89, p90, p91)
	if p89.currenthp <= 0 then
		return;
	end;
	if (p89.DecoyKilled or p89.Decoy) and p88 ~= p89 then
		if p90 >= 100 and not p89.DecoyKilled then
			p87:AddDialogue(p87.ActionList, p89.Name .. "'s scapegoat prevented their stats from changing!");
			return;
		else
			return;
		end;
	end;
	if p90 ~= 100 and p88.Status == "Cursed" then
		return;
	end;
	local v62 = v4.GetTrait(p89);
	local v63 = p87:GetItemInfo(p89);
	local v64 = nil;
	if p87.FieldEffects.ModifyStatChance then
		p90 = p87.FieldEffects.ModifyStatChance(p87, p88, p89, p90);
	end;
	local v65 = nil;
	local v66 = nil;
	if math.random(1, 100) <= p90 then
		for v67, v68 in pairs(p91) do
			if p88 ~= p89 and v62.NoStatLower and v68 < 0 then
				if p90 >= 100 and not v64 then
					p87:AddDialogue(p87.ActionList, p89.Name .. "'s " .. p89.Ability .. " prevented their stats from lowering!");
					v64 = true;
				end;
			elseif v62.PreventStatDisable and v68 < 0 and table.find(v62.PreventStatDisable, v67) then
				if p90 >= 100 and not v62.PreventStatDisableFunc then
					p87:AddDialogue(p87.ActionList, p89.Name .. "'s " .. p89.Ability .. " prevented their " .. u13[v67] .. " from lowering!");
				elseif v62.PreventStatDisableFunc then
					v62.PreventStatDisableFunc(p87, p88, p89, v68);
				end;
			else
				p89.Boosts[v67] = p89.Boosts[v67] + v68;
				if v68 < 0 then
					v65 = true;
				elseif v68 > 0 then
					v66 = true;
				end;
			end;
		end;
	end;
	if v62.OnStatChange then
		v62.OnStatChange(p87, p88, p89, v65, v66);
	end;
	if v63.OnStatChange then
		v63.OnStatChange(p87, p88, p89, v65, v66);
	end;
end;
function v4.GetMaxUses(p92)
	return v2.Moves[p92].Uses;
end;
function v4.IsType(p93, p94)
	if table.find(v2.Database.DoodleInfo[v4.GetRealName(p93)].Type, p94) then
		return true;
	end;
	return false;
end;
function v4.Halt(p95)
	p95 = p95 and 0.03;
	task.wait(p95);
end;
function v4.BannedList(p96, p97)
	local v69 = {};
	for v70, v71 in pairs(p96) do
		if v71 and v71.Name then
			local v72 = v4.GetRealName(v71);
			if p97[v72] and not table.find(v69, v72) then
				table.insert(v69, v72);
			end;
		end;
	end;
	if #v69 > 0 then
		return v69;
	end;
	return false;
end;
function v4.ItemClauseCheck(p98)
	local v73 = {};
	for v74, v75 in pairs(p98) do
		if v75 and v75.Name and v75.HeldItem then
			if v73[v75.HeldItem] then
				return false;
			end;
			v73[v75.HeldItem] = true;
		end;
	end;
	return true;
end;
function v4.SpeciesCheck(p99)
	local v76 = {};
	for v77, v78 in pairs(p99) do
		if v78 and v78.Name then
			local v79 = v4.GetRealName(v78);
			if v76[v79] then
				return false;
			end;
			v76[v79] = true;
		end;
	end;
	return true;
end;
function v4.ConvertTimer(p100)
	local v80 = math.floor(p100 / 60);
	local v81 = p100 % 60;
	if #tostring(v81) == 1 then
		v81 = "0" .. v81;
	end;
	return v80 .. ":" .. v81;
end;
local function u14(p101)
	local v82 = tostring(p101);
	if #v82 == 1 then
		v82 = "0" .. v82;
	end;
	return v82;
end;
function v4.HourTimer(p102)
	if not (p102 >= 0) then
		return "00:00:00";
	end;
	local v83 = math.floor(p102 / 3600);
	local v84 = p102 - v83 * 3600;
	local v85 = math.floor(v84 / 60);
	return u14(v83) .. ":" .. u14(v85) .. ":" .. u14(v84 - v85 * 60);
end;
function v4.GetBehind(p103, p104)
	local l__HumanoidRootPart__86 = p103:FindFirstChild("HumanoidRootPart");
	return CFrame.new(l__HumanoidRootPart__86.Position + l__HumanoidRootPart__86.CFrame.lookVector * -1 * p104, l__HumanoidRootPart__86.Position);
end;
function v4.FindFloor(p105, p106)
	local v87 = RaycastParams.new();
	v87.IgnoreWater = true;
	v87.FilterDescendantsInstances = p106;
	local v88 = workspace:Raycast(p105.p, Vector3.new(0, -1, 0).unit * 200, v87);
	if not v88 or not v88.Instance then
		return;
	end;
	return v88.Position;
end;
function v4.FindFloorRecurse(p107, p108, p109)
	local v89 = p109 and p109 + 1 or 1;
	if v89 > 50 then
		return nil;
	end;
	local v90 = v4:shallowCopy(p108);
	local v91 = RaycastParams.new();
	v91.IgnoreWater = true;
	v91.FilterDescendantsInstances = v90;
	local v92 = workspace:Raycast(p107, Vector3.new(0, -1, 0).unit * 200, v91);
	if v92 and v92.Instance and v92.Instance.CanCollide == false then
		return v4.FindFloorRecurse(v92.Position, v90, v89);
	end;
	if v92 and v92.Instance then
		return v92.Position;
	end;
	return nil;
end;
function v4.MapCheckBelow()
	local l__Character__93 = game.Players.LocalPlayer.Character;
	if l__Character__93:FindFirstChild("HumanoidRootPart") then
		local v94 = 0;
		local v95 = Ray.new(l__Character__93.HumanoidRootPart.Position, Vector3.new(0, -1, 0).unit * 20);
		while true do
			v94 = v94 + 1;
			local v96 = workspace:FindPartOnRay(v95, l__Character__93.HumanoidRootPart.Parent);
			v4.Halt(1);
			if v96 then
				break;
			end;
			if v94 >= 8 then
				break;
			end;		
		end;
	end;
end;
function v4.EmptyTable(p110)

end;
function v4.GetStatStars(p111)
	local v97 = {};
	for v98, v99 in pairs(v2.Database.DoodleInfo[p111].Stats) do
		if v99 % 30 >= 15 then
			local v100 = 0.5;
		else
			v100 = 0;
		end;
		v97[v98] = math.max(0.5, math.floor(v99 / 30) + v100);
	end;
	return v97;
end;
function v4.DestroyMetatable(p112)
	setmetatable(p112, nil);
end;
function v4.FindLineTable(p113, p114)
	local v101 = p114.RealName or p114.Name;
	for v102, v103 in pairs(p113) do
		if table.find(v103, v101) then
			return v102;
		end;
	end;
end;
function v4.GetPlayerData(p115)
	if not v2 or not v2.PlayerData[p115] then
		return nil;
	end;
	return v2.PlayerData[p115];
end;
local u15 = {
	LightningKey = 28
};
function v4.LevelCap(p116)
	local v104 = 20;
	local v105 = {};
	if l__RunService__1:IsServer() then
		v105 = v4.GetPlayerData(p116).Key;
	elseif u2.KeysObtained then
		v105 = u2.KeysObtained;
	end;
	for v106, v107 in pairs(u15) do
		if v105[v106] and v104 < v107 then
			v104 = v107;
		end;
	end;
	return v104;
end;
function v4.TableCount(p117)
	local v108 = 0;
	if typeof(p117) ~= "table" then
		return v108;
	end;
	for v109, v110 in pairs(p117) do
		v108 = v108 + 1;
	end;
	return v108;
end;
return v4;
