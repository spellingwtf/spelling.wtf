-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local l__Parent__2 = script.Parent;
local u1 = {};
local u2 = {
	eDestroyed = true, 
	eSaidMessage = true, 
	eReceivedMessage = true, 
	eReceivedUnfilteredMessage = true, 
	eMessageDoneFiltering = true, 
	eReceivedSystemMessage = true, 
	eChannelJoined = true, 
	eChannelLeft = true, 
	eMuted = true, 
	eUnmuted = true, 
	eExtraDataUpdated = true, 
	eMainChannelSet = true, 
	eChannelNameColorUpdated = true
};
local u3 = {
	Destroyed = "eDestroyed", 
	SaidMessage = "eSaidMessage", 
	ReceivedMessage = "eReceivedMessage", 
	ReceivedUnfilteredMessage = "eReceivedUnfilteredMessage", 
	RecievedUnfilteredMessage = "eReceivedUnfilteredMessage", 
	MessageDoneFiltering = "eMessageDoneFiltering", 
	ReceivedSystemMessage = "eReceivedSystemMessage", 
	ChannelJoined = "eChannelJoined", 
	ChannelLeft = "eChannelLeft", 
	Muted = "eMuted", 
	Unmuted = "eUnmuted", 
	ExtraDataUpdated = "eExtraDataUpdated", 
	MainChannelSet = "eMainChannelSet", 
	ChannelNameColorUpdated = "eChannelNameColorUpdated"
};
function u1.__index(p1, p2)
	local v3 = rawget(u1, p2);
	if v3 then
		return v3;
	end;
	if u2[p2] and not rawget(p1, p2) then
		rawset(p1, p2, Instance.new("BindableEvent"));
	end;
	local v4 = u3[p2];
	if v4 and not rawget(p1, p2) then
		if not rawget(p1, v4) then
			rawset(p1, v4, Instance.new("BindableEvent"));
		end;
		rawset(p1, p2, rawget(p1, v4).Event);
	end;
	return rawget(p1, p2);
end;
function u1.LazyFire(p3, p4, ...)
	local v5 = rawget(p3, p4);
	if v5 then
		v5:Fire(...);
	end;
end;
function u1.SayMessage(p5, p6, p7, p8)
	if p5.ChatService:InternalDoProcessCommands(p5.Name, p6, p7) then
		return;
	end;
	if not p7 then
		return;
	end;
	local v6 = p5.Channels[p7:lower()];
	if not v6 then
		return;
	end;
	local v7 = v6:InternalPostMessage(p5, p6, p8);
	if v7 then
		pcall(function()
			p5:LazyFire("eSaidMessage", v7, p7);
		end);
	end;
	return v7;
end;
function u1.JoinChannel(p9, p10)
	if p9.Channels[p10:lower()] then
		warn("Speaker is already in channel \"" .. p10 .. "\"");
		return;
	end;
	local v8 = p9.ChatService:GetChannel(p10);
	if not v8 then
		error("Channel \"" .. p10 .. "\" does not exist!");
	end;
	p9.Channels[p10:lower()] = v8;
	v8:InternalAddSpeaker(p9);
	local v9, v10 = pcall(function()
		p9.eChannelJoined:Fire(v8.Name, v8:GetWelcomeMessageForSpeaker(p9));
	end);
	if not v9 and v10 then
		print("Error joining channel: " .. v10);
	end;
end;
function u1.LeaveChannel(p11, p12)
	if not p11.Channels[p12:lower()] then
		warn("Speaker is not in channel \"" .. p12 .. "\"");
		return;
	end;
	local v11 = p11.Channels[p12:lower()];
	p11.Channels[p12:lower()] = nil;
	v11:InternalRemoveSpeaker(p11);
	local v12, v13 = pcall(function()
		p11:LazyFire("eChannelLeft", v11.Name);
		if p11.PlayerObj then
			p11.EventFolder.OnChannelLeft:FireClient(p11.PlayerObj, v11.Name);
		end;
	end);
	if not v12 and v13 then
		print("Error leaving channel: " .. v13);
	end;
end;
function u1.IsInChannel(p13, p14)
	return p13.Channels[p14:lower()] ~= nil;
end;
function u1.GetChannelList(p15)
	local v14 = {};
	for v15, v16 in pairs(p15.Channels) do
		table.insert(v14, v16.Name);
	end;
	return v14;
end;
function u1.SendMessage(p16, p17, p18, p19, p20)
	local v17 = p16.Channels[p18:lower()];
	if not v17 then
		warn(string.format("Speaker '%s' is not in channel '%s' and cannot receive a message in it.", p16.Name, p18));
		return;
	end;
	v17:SendMessageToSpeaker(p17, p16.Name, p19, p20);
end;
function u1.SendSystemMessage(p21, p22, p23, p24)
	local v18 = p21.Channels[p23:lower()];
	if not v18 then
		warn(string.format("Speaker '%s' is not in channel '%s' and cannot receive a system message in it.", p21.Name, p23));
		return;
	end;
	v18:SendSystemMessageToSpeaker(p22, p21.Name, p24);
end;
function u1.GetPlayer(p25)
	return p25.PlayerObj;
end;
local u4 = require(game:GetService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("ChatSettings"));
function u1.GetNameForDisplay(p26)
	if not u4.PlayerDisplayNamesEnabled then
		return p26.Name;
	end;
	local v19 = p26:GetPlayer();
	if v19 then
		return v19.DisplayName;
	end;
	return p26.Name;
end;
function u1.SetExtraData(p27, p28, p29)
	p27.ExtraData[p28] = p29;
	p27:LazyFire("eExtraDataUpdated", p28, p29);
end;
function u1.GetExtraData(p30, p31)
	return p30.ExtraData[p31];
end;
function u1.SetMainChannel(p32, p33)
	local v20, v21 = pcall(function()
		p32:LazyFire("eMainChannelSet", p33);
		if p32.PlayerObj then
			p32.EventFolder.OnMainChannelSet:FireClient(p32.PlayerObj, p33);
		end;
	end);
	if not v20 and v21 then
		print("Error setting main channel: " .. v21);
	end;
end;
function u1.AddMutedSpeaker(p34, p35)
	p34.MutedSpeakers[p35:lower()] = true;
end;
function u1.RemoveMutedSpeaker(p36, p37)
	p36.MutedSpeakers[p37:lower()] = false;
end;
function u1.IsSpeakerMuted(p38, p39)
	return p38.MutedSpeakers[p39:lower()];
end;
function u1.InternalDestroy(p40)
	for v22, v23 in pairs(p40.Channels) do
		v23:InternalRemoveSpeaker(p40);
	end;
	p40.eDestroyed:Fire();
	p40.EventFolder = nil;
	p40.eDestroyed:Destroy();
	p40.eSaidMessage:Destroy();
	p40.eReceivedMessage:Destroy();
	p40.eReceivedUnfilteredMessage:Destroy();
	p40.eMessageDoneFiltering:Destroy();
	p40.eReceivedSystemMessage:Destroy();
	p40.eChannelJoined:Destroy();
	p40.eChannelLeft:Destroy();
	p40.eMuted:Destroy();
	p40.eUnmuted:Destroy();
	p40.eExtraDataUpdated:Destroy();
	p40.eMainChannelSet:Destroy();
	p40.eChannelNameColorUpdated:Destroy();
end;
function u1.InternalAssignPlayerObject(p41, p42)
	p41.PlayerObj = p42;
end;
function u1.InternalAssignEventFolder(p43, p44)
	p43.EventFolder = p44;
end;
function u1.InternalSendMessage(p45, p46, p47)
	local v24, v25 = pcall(function()
		p45:LazyFire("eReceivedUnfilteredMessage", p46, p47);
		if p45.PlayerObj then
			p45.EventFolder.OnNewMessage:FireClient(p45.PlayerObj, p46, p47);
		end;
	end);
	if not v24 and v25 then
		print("Error sending internal message: " .. v25);
	end;
end;
function u1.InternalSendFilteredMessage(p48, p49, p50)
	local v26, v27 = pcall(function()
		p48:LazyFire("eReceivedMessage", p49, p50);
		p48:LazyFire("eMessageDoneFiltering", p49, p50);
		if p48.PlayerObj then
			p48.EventFolder.OnMessageDoneFiltering:FireClient(p48.PlayerObj, p49, p50);
		end;
	end);
	if not v26 and v27 then
		print("Error sending internal filtered message: " .. v27);
	end;
end;
local function u5(p51)
	local v28 = {};
	for v29, v30 in pairs(p51) do
		v28[v29] = v30;
	end;
	return v28;
end;
function u1.InternalSendFilteredMessageWithFilterResult(p52, p53, p54)
	local v31 = u5(p53);
	local u6 = p52:GetPlayer();
	local u7 = "";
	local l__FilterResult__8 = v31.FilterResult;
	pcall(function()
		if not v31.IsFilterResult then
			u7 = l__FilterResult__8;
			return;
		end;
		if not u6 then
			u7 = l__FilterResult__8:GetNonChatStringForBroadcastAsync();
			return;
		end;
		u7 = l__FilterResult__8:GetChatForUserAsync(u6.UserId);
	end);
	if #u7 > 0 then
		v31.Message = u7;
		v31.FilterResult = nil;
		p52:InternalSendFilteredMessage(v31, p54);
	end;
end;
function u1.InternalSendSystemMessage(p55, p56, p57)
	local v32, v33 = pcall(function()
		p55:LazyFire("eReceivedSystemMessage", p56, p57);
		if p55.PlayerObj then
			p55.EventFolder.OnNewSystemMessage:FireClient(p55.PlayerObj, p56, p57);
		end;
	end);
	if not v32 and v33 then
		print("Error sending internal system message: " .. v33);
	end;
end;
function u1.UpdateChannelNameColor(p58, p59, p60)
	p58:LazyFire("eChannelNameColorUpdated", p59, p60);
	if p58.PlayerObj then
		p58.EventFolder.ChannelNameColorUpdated:FireClient(p58.PlayerObj, p59, p60);
	end;
end;
function v1.new(p61, p62)
	local v34 = setmetatable({}, u1);
	v34.ChatService = p61;
	v34.PlayerObj = nil;
	v34.Name = p62;
	v34.ExtraData = {};
	v34.Channels = {};
	v34.MutedSpeakers = {};
	v34.EventFolder = nil;
	return v34;
end;
return v1;
