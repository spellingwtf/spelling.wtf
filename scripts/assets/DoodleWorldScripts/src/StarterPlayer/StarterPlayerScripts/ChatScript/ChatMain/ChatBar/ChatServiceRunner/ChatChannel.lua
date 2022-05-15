-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game:GetService("ServerScriptService"):WaitForChild("ServerInitializer"):WaitForChild("ServerFramework"));
local v2, v3 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserShouldMuteUnfilteredMessage");
end);
local v4 = {};
local l__Chat__5 = game:GetService("Chat");
local l__RunService__6 = game:GetService("RunService");
local l__ClientChatModules__7 = l__Chat__5:WaitForChild("ClientChatModules");
local v8 = require(l__ClientChatModules__7:WaitForChild("ChatSettings"));
local v9 = require(l__ClientChatModules__7:WaitForChild("ChatConstants"));
local v10 = require(script.Parent:WaitForChild("Util"));
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
local v11 = {};
v11.__index = v11;
function v11.SendSystemMessage(p4, p5, p6)
	local u2 = p4:InternalCreateMessageObject(p5, nil, true, p6);
	local v12, v13 = pcall(function()
		p4.eMessagePosted:Fire(u2);
	end);
	if not v12 and v13 then
		print("Error posting message: " .. v13);
	end;
	p4:InternalAddMessageToHistoryLog(u2);
	for v14, v15 in pairs(p4.Speakers) do
		v15:InternalSendSystemMessage(u2, p4.Name);
	end;
	return u2;
end;
function v11.SendSystemMessageToSpeaker(p7, p8, p9, p10)
	local v16 = p7.Speakers[p9];
	if v16 then
		v16:InternalSendSystemMessage(p7:InternalCreateMessageObject(p8, nil, true, p10), p7.Name);
		return;
	end;
	if l__RunService__6:IsStudio() then
		warn(string.format("Speaker '%s' is not in channel '%s' and cannot be sent a system message", p9, p7.Name));
	end;
end;
function v11.SendMessageObjToFilters(p11, p12, p13, p14)
	p13.Message = p12;
	p11:InternalDoMessageFilter(p14.Name, p13, p11.Name);
	p11.ChatService:InternalDoMessageFilter(p14.Name, p13, p11.Name);
	p13.Message = p13.Message;
	return p13.Message;
end;
function v11.CanCommunicateByUserId(p15, p16, p17)
	if l__RunService__6:IsStudio() then
		return true;
	end;
	if p16 == 0 or p17 == 0 then
		return true;
	end;
	local v17, v18 = pcall(function()
		return l__Chat__5:CanUsersChatAsync(p16, p17);
	end);
	return v17 or v18;
end;
function v11.CanCommunicate(p18, p19, p20)
	local v19 = nil;
	local v20 = p19:GetPlayer();
	v19 = p20:GetPlayer();
	if not v20 or not v19 then
		return true;
	end;
	return p18:CanCommunicateByUserId(v20.UserId, v19.UserId);
end;
function v11.SendMessageToSpeaker(p21, p22, p23, p24, p25)
	local v21 = p21.Speakers[p23];
	local v22 = p21.ChatService:GetSpeaker(p24);
	if v21 and v22 then
		if v21:IsSpeakerMuted(p24) then
			return;
		end;
		if not p21:CanCommunicate(v21, v22) then
			return;
		end;
		local v23 = p21:InternalCreateMessageObject(p22, p24, p23 == p24, p25);
		p22 = p21:SendMessageObjToFilters(p22, v23, p24);
		v21:InternalSendMessage(v23, p21.Name);
		local v24, v25, v26 = p21.ChatService:InternalApplyRobloxFilterNewAPI(v23.FromSpeaker, p22, p21.Private and Enum.TextFilterContext.PrivateChat or Enum.TextFilterContext.PublicChat);
		if v24 then
			v23.FilterResult = v26;
			v23.IsFilterResult = v25;
			v23.IsFiltered = true;
			v21:InternalSendFilteredMessageWithFilterResult(v23, p21.Name);
			return;
		end;
	elseif l__RunService__6:IsStudio() then
		warn(string.format("Speaker '%s' is not in channel '%s' and cannot be sent a message", p23, p21.Name));
	end;
end;
function v11.KickSpeaker(p26, p27, p28)
	local v27 = nil;
	local v28 = p26.ChatService:GetSpeaker(p27);
	if not v28 then
		error("Speaker \"" .. p27 .. "\" does not exist!");
	end;
	v27 = v28:GetNameForDisplay();
	if p28 then
		local v29 = string.format("You were kicked from '%s' for the following reason(s): %s", p26.Name, p28);
		local v30 = string.format("%s was kicked for the following reason(s): %s", v27, p28);
	else
		v29 = string.format("You were kicked from '%s'", p26.Name);
		v30 = string.format("%s was kicked", v27);
	end;
	p26:SendSystemMessageToSpeaker(v29, p27);
	v28:LeaveChannel(p26.Name);
	p26:SendSystemMessage(v30);
end;
function v11.MuteSpeaker(p29, p30, p31, p32)
	local v31 = p29.ChatService:GetSpeaker(p30);
	if not v31 then
		error("Speaker \"" .. p30 .. "\" does not exist!");
	end;
	if p32 == 0 or p32 == nil then
		local v32 = 0;
	else
		v32 = os.time() + p32;
	end;
	p29.Mutes[p30:lower()] = v32;
	if p31 then
		p29:SendSystemMessage(string.format("%s was muted for the following reason(s): %s", v31:GetNameForDisplay(), p31));
	end;
	local v33, v34 = pcall(function()
		p29.eSpeakerMuted:Fire(p30, p31, p32);
	end);
	if not v33 and v34 then
		print("Error mutting speaker: " .. v34);
	end;
	local v35 = p29.ChatService:GetSpeaker(p30);
	if v35 then
		local v36, v37 = pcall(function()
			v35.eMuted:Fire(p29.Name, p31, p32);
		end);
		if not v36 and v37 then
			print("Error mutting speaker: " .. v37);
		end;
	end;
end;
function v11.UnmuteSpeaker(p33, p34)
	if not p33.ChatService:GetSpeaker(p34) then
		error("Speaker \"" .. p34 .. "\" does not exist!");
	end;
	p33.Mutes[p34:lower()] = nil;
	local v38, v39 = pcall(function()
		p33.eSpeakerUnmuted:Fire(p34);
	end);
	if not v38 and v39 then
		print("Error unmuting speaker: " .. v39);
	end;
	local v40 = p33.ChatService:GetSpeaker(p34);
	if v40 then
		local v41, v42 = pcall(function()
			v40.eUnmuted:Fire(p33.Name);
		end);
		if not v41 and v42 then
			print("Error unmuting speaker: " .. v42);
		end;
	end;
end;
function v11.IsSpeakerMuted(p35, p36)
	return p35.Mutes[p36:lower()] ~= nil;
end;
function v11.GetSpeakerList(p37)
	local v43 = {};
	for v44, v45 in pairs(p37.Speakers) do
		table.insert(v43, v45.Name);
	end;
	return v43;
end;
function v11.RegisterFilterMessageFunction(p38, p39, p40, p41)
	if p38.FilterMessageFunctions:HasFunction(p39) then
		error(string.format("FilterMessageFunction '%s' already exists", p39));
	end;
	p38.FilterMessageFunctions:AddFunction(p39, p40, p41);
end;
function v11.FilterMessageFunctionExists(p42, p43)
	return p42.FilterMessageFunctions:HasFunction(p43);
end;
function v11.UnregisterFilterMessageFunction(p44, p45)
	if not p44.FilterMessageFunctions:HasFunction(p45) then
		error(string.format("FilterMessageFunction '%s' does not exists", p45));
	end;
	p44.FilterMessageFunctions:RemoveFunction(p45);
end;
function v11.RegisterProcessCommandsFunction(p46, p47, p48, p49)
	if p46.ProcessCommandsFunctions:HasFunction(p47) then
		error(string.format("ProcessCommandsFunction '%s' already exists", p47));
	end;
	p46.ProcessCommandsFunctions:AddFunction(p47, p48, p49);
end;
function v11.ProcessCommandsFunctionExists(p50, p51)
	return p50.ProcessCommandsFunctions:HasFunction(p51);
end;
function v11.UnregisterProcessCommandsFunction(p52, p53)
	if not p52.ProcessCommandsFunctions:HasFunction(p53) then
		error(string.format("ProcessCommandsFunction '%s' does not exist", p53));
	end;
	p52.ProcessCommandsFunctions:RemoveFunction(p53);
end;
local function u3(p54)
	local v46 = {};
	for v47, v48 in pairs(p54) do
		v46[v47] = v48;
	end;
	return v46;
end;
function v11.GetHistoryLog(p55)
	return u3(p55.ChatHistory);
end;
function v11.GetHistoryLogForSpeaker(p56, p57)
	local v49 = -1;
	local v50 = p57:GetPlayer();
	if v50 then
		v49 = v50.UserId;
	end;
	local v51 = {};
	for v52 = 1, #p56.ChatHistory do
		if p56:CanCommunicateByUserId(v49, p56.ChatHistory[v52].SpeakerUserId) then
			local v53 = u3(p56.ChatHistory[v52]);
			if v53.MessageType == v9.MessageTypeDefault or v53.MessageType == v9.MessageTypeMeCommand then
				local v54 = nil;
				v54 = v53.FilterResult;
				if v53.IsFilterResult then
					if v50 then
						v53.Message = v54:GetChatForUserAsync(v50.UserId);
					else
						v53.Message = v54:GetNonChatStringForBroadcastAsync();
					end;
				else
					v53.Message = v54;
				end;
			end;
			table.insert(v51, v53);
		end;
	end;
	return v51;
end;
function v11.InternalDestroy(p58)
	for v55, v56 in pairs(p58.Speakers) do
		v56:LeaveChannel(p58.Name);
	end;
	p58.eDestroyed:Fire();
	p58.eDestroyed:Destroy();
	p58.eMessagePosted:Destroy();
	p58.eSpeakerJoined:Destroy();
	p58.eSpeakerLeft:Destroy();
	p58.eSpeakerMuted:Destroy();
	p58.eSpeakerUnmuted:Destroy();
end;
function v11.InternalDoMessageFilter(p59, p60, p61, p62)
	for v57, v58, v59 in p59.FilterMessageFunctions:GetIterator(), nil do
		local v60, v61 = pcall(function()
			v58(p60, p61, p62);
		end);
		if not v60 then
			warn(string.format("DoMessageFilter Function '%s' failed for reason: %s", v57, v61));
		end;
	end;
end;
function v11.InternalDoProcessCommands(p63, p64, p65, p66)
	local v62 = p63.ProcessCommandsFunctions:GetIterator();
	local v63 = nil;
	local v64 = nil;
	while true do
		local v65 = nil;
		local v66, v67, v68 = v62(v63, v64);
		if not v66 then
			break;
		end;
		v64 = v66;
		local v69 = nil;
		v69, v65 = pcall(function()
			local v70 = v67(p64, p65, p66);
			if type(v70) ~= "boolean" then
				error("Process command functions must return a bool");
			end;
			return v70;
		end);
		if not v69 then
			warn(string.format("DoProcessCommands Function '%s' failed for reason: %s", v66, v65));
		elseif v65 then
			return true;
		end;	
	end;
	return false;
end;
local u4 = v2 or v3;
function v11.InternalPostMessage(p67, p68, p69, p70)
	if p67:InternalDoProcessCommands(p68.Name, p69, p67.Name) then
		return false;
	end;
	if p67.Mutes[p68.Name:lower()] ~= nil then
		local v71 = p67.Mutes[p68.Name:lower()];
		if not (v71 > 0) or not (v71 < os.time()) then
			p67:SendSystemMessageToSpeaker(u1:FormatMessageToSend("GameChat_ChatChannel_MutedInChannel", "You are muted and cannot talk in this channel"), p68.Name);
			return false;
		end;
		p67:UnmuteSpeaker(p68.Name);
	end;
	local v72 = p67:InternalCreateMessageObject(p69, p68.Name, false, p70);
	v72.Message = p69;
	local u5 = nil;
	local u6 = v72;
	pcall(function()
		u5 = l__Chat__5:InvokeChatCallback(Enum.ChatCallbackType.OnServerReceivingMessage, u6);
	end);
	u6.Message = nil;
	if u5 then
		if u5.ShouldDeliver == false then
			return false;
		end;
		u6 = u5;
	end;
	p69 = p67:SendMessageObjToFilters(p69, u6, p68);
	local v73 = {};
	for v74, v75 in pairs(p67.Speakers) do
		if not v75:IsSpeakerMuted(p68.Name) and p67:CanCommunicate(p68, v75) then
			table.insert(v73, v75.Name);
			if v75.Name == p68.Name then
				local v76 = u3(u6);
				if u4 then
					v76.Message = string.rep("_", u6.MessageLength);
				else
					v76.Message = p69;
				end;
				v76.IsFiltered = true;
				v75:InternalSendMessage(v76, p67.Name);
			else
				v75:InternalSendMessage(u6, p67.Name);
			end;
		end;
	end;
	local v77, v78 = pcall(function()
		p67.eMessagePosted:Fire(u6);
	end);
	if not v77 and v78 then
		print("Error posting message: " .. v78);
	end;
	local v79, v80, v81 = p67.ChatService:InternalApplyRobloxFilterNewAPI(u6.FromSpeaker, p69, p67.Private and Enum.TextFilterContext.PrivateChat or Enum.TextFilterContext.PublicChat);
	if not v79 then
		return false;
	end;
	u6.FilterResult = v81;
	u6.IsFilterResult = v80;
	u6.IsFiltered = true;
	p67:InternalAddMessageToHistoryLog(u6);
	for v82, v83 in pairs(v73) do
		local v84 = p67.Speakers[v83];
		if v84 then
			v84:InternalSendFilteredMessageWithFilterResult(u6, p67.Name);
		end;
	end;
	local v85 = {};
	for v86, v87 in pairs(p67.Speakers) do
		if not v87:IsSpeakerMuted(p68.Name) and p67:CanCommunicate(p68, v87) then
			local v88 = false;
			for v89, v90 in pairs(v73) do
				if v87.Name == v90 then
					v88 = true;
					break;
				end;
			end;
			if not v88 then
				table.insert(v85, v87.Name);
			end;
		end;
	end;
	for v91, v92 in pairs(v85) do
		local v93 = p67.Speakers[v92];
		if v93 then
			v93:InternalSendFilteredMessageWithFilterResult(u6, p67.Name);
		end;
	end;
	return v72;
end;
function v11.InternalAddSpeaker(p71, p72)
	if p71.Speakers[p72.Name] then
		warn("Speaker \"" .. p72.name .. "\" is already in the channel!");
		return;
	end;
	p71.Speakers[p72.Name] = p72;
	local v94, v95 = pcall(function()
		p71.eSpeakerJoined:Fire(p72.Name);
	end);
	if not v94 and v95 then
		print("Error removing channel: " .. v95);
	end;
end;
function v11.InternalRemoveSpeaker(p73, p74)
	if not p73.Speakers[p74.Name] then
		warn("Speaker \"" .. p74.name .. "\" is not in the channel!");
		return;
	end;
	p73.Speakers[p74.Name] = nil;
	local v96, v97 = pcall(function()
		p73.eSpeakerLeft:Fire(p74.Name);
	end);
	if not v96 and v97 then
		print("Error removing speaker: " .. v97);
	end;
end;
function v11.InternalRemoveExcessMessagesFromLog(p75)
	local l__table_remove__98 = table.remove;
	while p75.MaxHistory < #p75.ChatHistory do
		l__table_remove__98(p75.ChatHistory, 1);	
	end;
end;
function v11.InternalAddMessageToHistoryLog(p76, p77)
	table.insert(p76.ChatHistory, p77);
	p76:InternalRemoveExcessMessagesFromLog();
end;
function v11.GetMessageType(p78, p79, p80)
	if p80 == nil then
		return v9.MessageTypeSystem;
	end;
	return v9.MessageTypeDefault;
end;
function v11.InternalCreateMessageObject(p81, p82, p83, p84, p85)
	local v99 = -1;
	local v100 = nil;
	local v101 = nil;
	if p83 then
		v101 = p81.ChatService:GetSpeaker(p83);
		if v101 then
			local v102 = v101:GetPlayer();
			if v102 then
				v99 = v102.UserId;
				if v8.PlayerDisplayNamesEnabled then
					v100 = v101:GetNameForDisplay();
				end;
			else
				v99 = 0;
			end;
		end;
	end;
	local v103 = v101 and game.Players:FindFirstChild(v101.Name);
	local v104 = {
		ID = p81.ChatService:InternalGetUniqueMessageId(), 
		FromSpeaker = p83, 
		SpeakerDisplayName = v100, 
		SpeakerUserId = v99, 
		OriginalChannel = p81.Name, 
		MessageLength = string.len(p82), 
		MessageType = p81:GetMessageType(p82, p83), 
		IsFiltered = p84, 
		Message = p84 and p82 or nil, 
		Time = os.time(), 
		ExtraData = {
			Color = v103 and v1.PlayerData[v103].Equipped.NameColor or 1
		}
	};
	if v101 then
		for v105, v106 in pairs(v101.ExtraData) do
			v104.ExtraData[v105] = v106;
		end;
	end;
	if p85 then
		for v107, v108 in pairs(p85) do
			v104.ExtraData[v107] = v108;
		end;
	end;
	return v104;
end;
function v11.SetChannelNameColor(p86, p87)
	p86.ChannelNameColor = p87;
	for v109, v110 in pairs(p86.Speakers) do
		v110:UpdateChannelNameColor(p86.Name, p87);
	end;
end;
function v11.GetWelcomeMessageForSpeaker(p88, p89)
	if p88.GetWelcomeMessageFunction then
		local v111 = p88.GetWelcomeMessageFunction(p89);
		if v111 then
			return v111;
		end;
	end;
	return p88.WelcomeMessage;
end;
function v11.RegisterGetWelcomeMessageFunction(p90, p91)
	if type(p91) ~= "function" then
		error("RegisterGetWelcomeMessageFunction must be called with a function.");
	end;
	p90.GetWelcomeMessageFunction = p91;
end;
function v11.UnRegisterGetWelcomeMessageFunction(p92)
	p92.GetWelcomeMessageFunction = nil;
end;
function v4.new(p93, p94, p95, p96)
	local v112 = setmetatable({}, v11);
	v112.ChatService = p93;
	v112.Name = p94;
	v112.WelcomeMessage = p95 and "";
	v112.GetWelcomeMessageFunction = nil;
	v112.ChannelNameColor = p96;
	v112.Joinable = true;
	v112.Leavable = true;
	v112.AutoJoin = false;
	v112.Private = false;
	v112.Speakers = {};
	v112.Mutes = {};
	v112.MaxHistory = 200;
	v112.HistoryIndex = 0;
	v112.ChatHistory = {};
	v112.FilterMessageFunctions = v10:NewSortedFunctionContainer();
	v112.ProcessCommandsFunctions = v10:NewSortedFunctionContainer();
	v112.eDestroyed = Instance.new("BindableEvent");
	v112.eMessagePosted = Instance.new("BindableEvent");
	v112.eSpeakerJoined = Instance.new("BindableEvent");
	v112.eSpeakerLeft = Instance.new("BindableEvent");
	v112.eSpeakerMuted = Instance.new("BindableEvent");
	v112.eSpeakerUnmuted = Instance.new("BindableEvent");
	v112.MessagePosted = v112.eMessagePosted.Event;
	v112.SpeakerJoined = v112.eSpeakerJoined.Event;
	v112.SpeakerLeft = v112.eSpeakerLeft.Event;
	v112.SpeakerMuted = v112.eSpeakerMuted.Event;
	v112.SpeakerUnmuted = v112.eSpeakerUnmuted.Event;
	v112.Destroyed = v112.eDestroyed.Event;
	return v112;
end;
return v4;
