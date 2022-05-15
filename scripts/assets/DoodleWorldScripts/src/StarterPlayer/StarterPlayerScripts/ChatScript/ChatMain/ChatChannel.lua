-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local l__Parent__2 = script.Parent;
local v3 = {};
v3.__index = v3;
function v3.Destroy(p1)
	p1.Destroyed = true;
end;
function v3.SetActive(p2, p3)
	if p3 == p2.Active then
		return;
	end;
	if p3 == false then
		p2.MessageLogDisplay:Clear();
	else
		p2.MessageLogDisplay:SetCurrentChannelName(p2.Name);
		for v4 = 1, #p2.MessageLog do
			p2.MessageLogDisplay:AddMessage(p2.MessageLog[v4]);
		end;
	end;
	p2.Active = p3;
end;
function v3.UpdateMessageFiltered(p4, p5)
	local v5 = 1;
	local l__MessageLog__6 = p4.MessageLog;
	local v7 = nil;
	while v5 <= #l__MessageLog__6 do
		local v8 = l__MessageLog__6[v5];
		if v8.ID == p5.ID then
			v7 = v8;
			break;
		end;
		v5 = v5 + 1;	
	end;
	if v7 then
		v7.Message = p5.Message;
		v7.IsFiltered = true;
		if not p4.Active then
			return;
		end;
	else
		p4:AddMessageToChannelByTimeStamp(p5);
		return;
	end;
	p4.MessageLogDisplay:UpdateMessageFiltered(v7);
end;
local u1 = require(game:GetService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("ChatSettings"));
function v3.AddMessageToChannel(p6, p7)
	table.insert(p6.MessageLog, p7);
	if p6.Active then
		p6.MessageLogDisplay:AddMessage(p7);
	end;
	if u1.MessageHistoryLengthPerChannel < #p6.MessageLog then
		p6:RemoveLastMessageFromChannel();
	end;
end;
function v3.InternalAddMessageAtTimeStamp(p8, p9)
	for v9 = 1, #p8.MessageLog do
		if p9.Time < p8.MessageLog[v9].Time then
			table.insert(p8.MessageLog, v9, p9);
			return;
		end;
	end;
	table.insert(p8.MessageLog, p9);
end;
function v3.AddMessagesToChannelByTimeStamp(p10, p11, p12)
	for v10 = p12, #p11 do
		p10:InternalAddMessageAtTimeStamp(p11[v10]);
	end;
	while u1.MessageHistoryLengthPerChannel < #p10.MessageLog do
		table.remove(p10.MessageLog, 1);	
	end;
	if p10.Active then
		p10.MessageLogDisplay:Clear();
		for v11 = 1, #p10.MessageLog do
			p10.MessageLogDisplay:AddMessage(p10.MessageLog[v11]);
		end;
	end;
end;
function v3.AddMessageToChannelByTimeStamp(p13, p14)
	if not (#p13.MessageLog >= 1) then
		p13:AddMessageToChannel(p14);
		return;
	end;
	if p14.Time < p13.MessageLog[1].Time then
		return;
	end;
	if p13.MessageLog[#p13.MessageLog].Time <= p14.Time then
		p13:AddMessageToChannel(p14);
		return;
	end;
	for v12 = 1, #p13.MessageLog do
		if p14.Time < p13.MessageLog[v12].Time then
			table.insert(p13.MessageLog, v12, p14);
			if u1.MessageHistoryLengthPerChannel < #p13.MessageLog then
				p13:RemoveLastMessageFromChannel();
			end;
			if p13.Active then
				p13.MessageLogDisplay:AddMessageAtIndex(p14, v12);
			end;
			return;
		end;
	end;
end;
function v3.RemoveLastMessageFromChannel(p15)
	table.remove(p15.MessageLog, 1);
	if p15.Active then
		p15.MessageLogDisplay:RemoveLastMessage();
	end;
end;
function v3.ClearMessageLog(p16)
	p16.MessageLog = {};
	if p16.Active then
		p16.MessageLogDisplay:Clear();
	end;
end;
function v3.RegisterChannelTab(p17, p18)
	p17.ChannelTab = p18;
end;
function v1.new(p19, p20)
	local v13 = setmetatable({}, v3);
	v13.Destroyed = false;
	v13.Active = false;
	v13.MessageLog = {};
	v13.MessageLogDisplay = p20;
	v13.ChannelTab = nil;
	v13.Name = p19;
	return v13;
end;
return v1;
