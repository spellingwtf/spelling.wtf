-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local l__RunService__2 = game:GetService("RunService");
local l__Chat__3 = game:GetService("Chat");
local l__ClientChatModules__4 = l__Chat__3:WaitForChild("ClientChatModules");
local l__Parent__5 = script.Parent;
local l__ClientChatModules__6 = l__Chat__3:WaitForChild("ClientChatModules");
local v7 = {
	ChatColor = require(l__ClientChatModules__6:WaitForChild("ChatSettings")).ErrorMessageTextColor or Color3.fromRGB(245, 50, 50)
};
local v8 = require(l__ClientChatModules__6:WaitForChild("ChatConstants"));
local v9 = require(l__Parent__5:WaitForChild("ChatChannel"));
local v10 = require(l__Parent__5:WaitForChild("Speaker"));
local v11 = require(l__Parent__5:WaitForChild("Util"));
local u1 = nil;
pcall(function()
	u1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization);
end);
u1 = u1 or {};
if not u1.FormatMessageToSend or not u1.LocalizeFormattedMessage then
	function u1.FormatMessageToSend(p1, p2, p3)
		return p3;
	end;
end;
local v12 = {};
v12.__index = v12;
function v12.AddChannel(p4, p5, p6)
	if p4.ChatChannels[p5:lower()] then
		error(string.format("Channel %q alrady exists.", p5));
	end;
	local v13 = v9.new(p4, p5);
	p4.ChatChannels[p5:lower()] = v13;
	v13:RegisterProcessCommandsFunction("default_commands", function(p7, p8)
		if p8:lower() ~= "/leave" then
			return false;
		end;
		local v14 = p4:GetChannel(p5);
		local v15 = p4:GetSpeaker(p7);
		if v14 and v15 then
			if v14.Leavable then
				v15:LeaveChannel(p5);
				v15:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatService_YouHaveLeftChannel", string.format("You have left channel '%s'", p5), "RBX_NAME", p5), "System");
			else
				v15:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatService_CannotLeaveChannel", "You cannot leave this channel."), p5);
			end;
		end;
		return true;
	end, v8.HighPriority);
	local v16, v17 = pcall(function()
		p4.eChannelAdded:Fire(p5);
	end);
	if not v16 and v17 then
		print("Error addding channel: " .. v17);
	end;
	if p6 ~= nil then
		v13.AutoJoin = p6;
		if p6 then
			for v18, v19 in pairs(p4.Speakers) do
				v19:JoinChannel(p5);
			end;
		end;
	end;
	return v13;
end;
function v12.RemoveChannel(p9, p10)
	local v20 = nil;
	if p9.ChatChannels[p10:lower()] then
		local l__Name__21 = p9.ChatChannels[p10:lower()].Name;
		p9.ChatChannels[p10:lower()]:InternalDestroy();
		p9.ChatChannels[p10:lower()] = nil;
		local v22 = nil;
		v22, v20 = pcall(function()
			p9.eChannelRemoved:Fire(l__Name__21);
		end);
		if not (not v22) or not v20 then
			return;
		end;
	else
		warn(string.format("Channel %q does not exist.", p10));
		return;
	end;
	print("Error removing channel: " .. v20);
end;
function v12.GetChannel(p11, p12)
	return p11.ChatChannels[p12:lower()];
end;
function v12.AddSpeaker(p13, p14)
	if p13.Speakers[p14:lower()] then
		error("Speaker \"" .. p14 .. "\" already exists!");
	end;
	local v23 = v10.new(p13, p14);
	p13.Speakers[p14:lower()] = v23;
	local v24, v25 = pcall(function()
		p13.eSpeakerAdded:Fire(p14);
	end);
	if not v24 and v25 then
		print("Error adding speaker: " .. v25);
	end;
	return v23;
end;
function v12.InternalUnmuteSpeaker(p15, p16)
	for v26, v27 in pairs(p15.ChatChannels) do
		if v27:IsSpeakerMuted(p16) then
			v27:UnmuteSpeaker(p16);
		end;
	end;
end;
function v12.RemoveSpeaker(p17, p18)
	local v28 = nil;
	if p17.Speakers[p18:lower()] then
		local l__Name__29 = p17.Speakers[p18:lower()].Name;
		p17:InternalUnmuteSpeaker(l__Name__29);
		p17.Speakers[p18:lower()]:InternalDestroy();
		p17.Speakers[p18:lower()] = nil;
		local v30 = nil;
		v30, v28 = pcall(function()
			p17.eSpeakerRemoved:Fire(l__Name__29);
		end);
		if not (not v30) or not v28 then
			return;
		end;
	else
		warn("Speaker \"" .. p18 .. "\" does not exist!");
		return;
	end;
	print("Error removing speaker: " .. v28);
end;
function v12.GetSpeaker(p19, p20)
	return p19.Speakers[p20:lower()];
end;
function v12.GetSpeakerByUserOrDisplayName(p21, p22)
	local v31 = p21.Speakers[p22:lower()];
	if v31 then
		return v31;
	end;
	for v32, v33 in pairs(p21.Speakers) do
		local v34 = v33:GetPlayer();
		if v34 and v34.DisplayName:lower() == p22:lower() then
			return v33;
		end;
	end;
end;
function v12.GetChannelList(p23)
	local v35 = {};
	for v36, v37 in pairs(p23.ChatChannels) do
		if not v37.Private then
			table.insert(v35, v37.Name);
		end;
	end;
	return v35;
end;
function v12.GetAutoJoinChannelList(p24)
	local v38 = {};
	for v39, v40 in pairs(p24.ChatChannels) do
		if v40.AutoJoin then
			table.insert(v38, v40);
		end;
	end;
	return v38;
end;
function v12.GetSpeakerList(p25)
	local v41 = {};
	for v42, v43 in pairs(p25.Speakers) do
		table.insert(v41, v43.Name);
	end;
	return v41;
end;
function v12.SendGlobalSystemMessage(p26, p27)
	for v44, v45 in pairs(p26.Speakers) do
		v45:SendSystemMessage(p27, nil);
	end;
end;
function v12.RegisterFilterMessageFunction(p28, p29, p30, p31)
	if p28.FilterMessageFunctions:HasFunction(p29) then
		error(string.format("FilterMessageFunction '%s' already exists", p29));
	end;
	p28.FilterMessageFunctions:AddFunction(p29, p30, p31);
end;
function v12.FilterMessageFunctionExists(p32, p33)
	return p32.FilterMessageFunctions:HasFunction(p33);
end;
function v12.UnregisterFilterMessageFunction(p34, p35)
	if not p34.FilterMessageFunctions:HasFunction(p35) then
		error(string.format("FilterMessageFunction '%s' does not exists", p35));
	end;
	p34.FilterMessageFunctions:RemoveFunction(p35);
end;
function v12.RegisterProcessCommandsFunction(p36, p37, p38, p39)
	if p36.ProcessCommandsFunctions:HasFunction(p37) then
		error(string.format("ProcessCommandsFunction '%s' already exists", p37));
	end;
	p36.ProcessCommandsFunctions:AddFunction(p37, p38, p39);
end;
function v12.ProcessCommandsFunctionExists(p40, p41)
	return p40.ProcessCommandsFunctions:HasFunction(p41);
end;
function v12.UnregisterProcessCommandsFunction(p42, p43)
	if not p42.ProcessCommandsFunctions:HasFunction(p43) then
		error(string.format("ProcessCommandsFunction '%s' does not exist", p43));
	end;
	p42.ProcessCommandsFunctions:RemoveFunction(p43);
end;
local u2 = 0;
local u3 = 0;
local u4 = 0;
function v12.InternalNotifyFilterIssue(p44)
	if tick() - u2 > 60 then
		u3 = 0;
	end;
	u3 = u3 + 1;
	u2 = tick();
	if u3 >= 3 and tick() - u4 > 60 then
		u4 = tick();
		local v46 = p44:GetChannel("System");
		if v46 then
			v46:SendSystemMessage(u1:FormatMessageToSend("GameChat_ChatService_ChatFilterIssues", "The chat filter is currently experiencing issues and messages may be slow to appear."), v7);
		end;
	end;
end;
local function u5(p45)
	return string.len((string.gsub(p45, " ", ""))) == 0;
end;
local u6 = { 0.05, 0.1, 0.2 };
local u7 = {};
function v12.InternalApplyRobloxFilter(p46, p47, p48, p49)
	if not l__RunService__2:IsServer() or not (not l__RunService__2:IsStudio()) then
		if not u7[p48] then
			u7[p48] = true;
			wait();
		end;
		return p48;
	end;
	local v47 = p46:GetSpeaker(p47);
	local v48 = p49 and p46:GetSpeaker(p49);
	if v47 == nil then
		return nil;
	end;
	local v49 = v47:GetPlayer();
	local v50 = v48 and v48:GetPlayer();
	if v49 == nil then
		return p48;
	end;
	if u5(p48) then
		return p48;
	end;
	local v51 = tick();
	local v52 = 0;
	while true do
		local v53 = nil;
		local v54 = nil;
		v54, v53 = pcall(function()
			if v50 then
				return l__Chat__3:FilterStringAsync(p48, v49, v50);
			end;
			return l__Chat__3:FilterStringForBroadcast(p48, v49);
		end);
		if v54 then
			return v53;
		end;
		warn("Error filtering message:", v53);
		v52 = v52 + 1;
		if v52 > 3 then
			break;
		end;
		if tick() - v51 > 60 then
			break;
		end;
		local v55 = u6[math.min(#u6, v52)];
		wait(v55 + (math.random() * 2 - 1) * v55);	
	end;
	p46:InternalNotifyFilterIssue();
	return nil;
end;
function v12.InternalApplyRobloxFilterNewAPI(p50, p51, p52, p53)
	local v56 = nil;
	if not l__RunService__2:IsServer() or not (not l__RunService__2:IsStudio()) then
		wait();
		return true, false, p52;
	end;
	local v57 = p50:GetSpeaker(p51);
	if v57 == nil then
		return false, nil, nil;
	end;
	local v58 = v57:GetPlayer();
	if v58 == nil then
		return true, false, p52;
	end;
	if u5(p52) then
		return true, false, p52;
	end;
	local v59 = nil;
	v59, v56 = pcall(function()
		return game:GetService("TextService"):FilterStringAsync(p52, v58.UserId, p53);
	end);
	if v59 then
		return true, true, v56;
	end;
	warn("Error filtering message:", p52, v56);
	p50:InternalNotifyFilterIssue();
	return false, nil, nil;
end;
function v12.InternalDoMessageFilter(p54, p55, p56, p57)
	for v60, v61, v62 in p54.FilterMessageFunctions:GetIterator(), nil do
		local v63, v64 = pcall(function()
			v61(p55, p56, p57);
		end);
		if not v63 then
			warn(string.format("DoMessageFilter Function '%s' failed for reason: %s", v60, v64));
		end;
	end;
end;
function v12.InternalDoProcessCommands(p58, p59, p60, p61)
	local v65 = p58.ProcessCommandsFunctions:GetIterator();
	local v66 = nil;
	local v67 = nil;
	while true do
		local v68 = nil;
		local v69, v70, v71 = v65(v66, v67);
		if not v69 then
			break;
		end;
		v67 = v69;
		local v72 = nil;
		v72, v68 = pcall(function()
			local v73 = v70(p59, p60, p61);
			if type(v73) ~= "boolean" then
				error("Process command functions must return a bool");
			end;
			return v73;
		end);
		if not v72 then
			warn(string.format("DoProcessCommands Function '%s' failed for reason: %s", v69, v68));
		elseif v68 then
			return true;
		end;	
	end;
	return false;
end;
function v12.InternalGetUniqueMessageId(p62)
	local l__MessageIdCounter__74 = p62.MessageIdCounter;
	p62.MessageIdCounter = l__MessageIdCounter__74 + 1;
	return l__MessageIdCounter__74;
end;
function v12.InternalAddSpeakerWithPlayerObject(p63, p64, p65, p66)
	if p63.Speakers[p64:lower()] then
		error("Speaker \"" .. p64 .. "\" already exists!");
	end;
	local v75 = v10.new(p63, p64);
	v75:InternalAssignPlayerObject(p65);
	p63.Speakers[p64:lower()] = v75;
	if p66 then
		local v76, v77 = pcall(function()
			p63.eSpeakerAdded:Fire(p64);
		end);
		if not v76 and v77 then
			print("Error adding speaker: " .. v77);
		end;
	end;
	return v75;
end;
function v12.InternalFireSpeakerAdded(p67, p68)
	local v78, v79 = pcall(function()
		p67.eSpeakerAdded:Fire(p68);
	end);
	if not v78 and v79 then
		print("Error firing speaker added: " .. v79);
	end;
end;
function v1.new()
	local v80 = setmetatable({}, v12);
	v80.MessageIdCounter = 0;
	v80.ChatChannels = {};
	v80.Speakers = {};
	v80.FilterMessageFunctions = v11:NewSortedFunctionContainer();
	v80.ProcessCommandsFunctions = v11:NewSortedFunctionContainer();
	v80.eChannelAdded = Instance.new("BindableEvent");
	v80.eChannelRemoved = Instance.new("BindableEvent");
	v80.eSpeakerAdded = Instance.new("BindableEvent");
	v80.eSpeakerRemoved = Instance.new("BindableEvent");
	v80.ChannelAdded = v80.eChannelAdded.Event;
	v80.ChannelRemoved = v80.eChannelRemoved.Event;
	v80.SpeakerAdded = v80.eSpeakerAdded.Event;
	v80.SpeakerRemoved = v80.eSpeakerRemoved.Event;
	v80.ChatServiceMajorVersion = 0;
	v80.ChatServiceMinorVersion = 5;
	return v80;
end;
return v1.new();
