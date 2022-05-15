--[[VARIABLE DEFINITION ANOMALY DETECTED, DECOMPILATION OUTPUT POTENTIALLY INCORRECT]]--
-- Decompiled with the Synapse X Luau decompiler.

local v1 = false;
local v2, v3 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserFixChatWindowHoverOver");
end);
if v2 then
	v1 = v3;
end;
local v4 = false;
local v5, v6 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserFixMouseCapture");
end);
if v5 then
	v4 = v6;
end;
local v7 = false;
local v8, v9 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserHandleChatHotKeyWithContextActionService");
end);
if v8 then
	v7 = v9;
end;
local l__RunService__10 = game:GetService("RunService");
local l__ReplicatedStorage__11 = game:GetService("ReplicatedStorage");
local l__Chat__12 = game:GetService("Chat");
local l__StarterGui__13 = game:GetService("StarterGui");
local l__ContextActionService__14 = game:GetService("ContextActionService");
local v15 = l__ReplicatedStorage__11:WaitForChild("DefaultChatSystemChatEvents");
local v16 = l__ReplicatedStorage__11:WaitForChild("DefaultChatSystemChatEvents");
local l__ClientChatModules__17 = l__Chat__12:WaitForChild("ClientChatModules");
local v18 = require(l__ClientChatModules__17:WaitForChild("ChatConstants"));
local v19 = require(l__ClientChatModules__17:WaitForChild("ChatSettings"));
local v20 = require(l__ClientChatModules__17:WaitForChild("MessageCreatorModules"):WaitForChild("Util"));
local u1 = nil;
pcall(function()
	u1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization);
end);
if u1 == nil then
	u1 = {
		Get = function(p1, p2, p3)
			return p3;
		end
	};
end;
local v21 = Instance.new("BindableEvent");
local u2 = {
	OnNewMessage = "RemoteEvent", 
	OnMessageDoneFiltering = "RemoteEvent", 
	OnNewSystemMessage = "RemoteEvent", 
	OnChannelJoined = "RemoteEvent", 
	OnChannelLeft = "RemoteEvent", 
	OnMuted = "RemoteEvent", 
	OnUnmuted = "RemoteEvent", 
	OnMainChannelSet = "RemoteEvent", 
	SayMessageRequest = "RemoteEvent", 
	GetInitDataRequest = "RemoteFunction"
};
local u3 = {};
local u4 = 10;
function TryRemoveChildWithVerifyingIsCorrectType(p4)
	if u2[p4.Name] then
		if p4:IsA(u2[p4.Name]) then
			u2[p4.Name] = nil;
			u3[p4.Name] = p4;
			u4 = u4 - 1;
		end;
	end;
end;
for v22, v23 in pairs(v16:GetChildren()) do
	TryRemoveChildWithVerifyingIsCorrectType(v23);
end;
if u4 > 0 then
	local v24 = v16.ChildAdded:connect(function(p5)
		TryRemoveChildWithVerifyingIsCorrectType(p5);
		if u4 < 1 then
			v21:Fire();
		end;
	end);
	v21.Event:wait();
	v24:disconnect();
	v21:Destroy();
end;
local l__UserInputService__25 = game:GetService("UserInputService");
local l__RunService__26 = game:GetService("RunService");
local l__Players__27 = game:GetService("Players");
local v28 = l__Players__27.LocalPlayer;
while not v28 do
	l__Players__27.ChildAdded:wait();
	v28 = l__Players__27.LocalPlayer;
end;
local v29 = 6;
if v19.ScreenGuiDisplayOrder ~= nil then
	v29 = v19.ScreenGuiDisplayOrder;
end;
local v30 = Instance.new("ScreenGui");
v30.Name = "Chat";
v30.ResetOnSpawn = false;
v30.DisplayOrder = v29;
v30.Parent = v28:WaitForChild("PlayerGui");
local v31 = require(script:WaitForChild("MessageLabelCreator"));
local v32 = require(script:WaitForChild("MessageLogDisplay"));
local v33 = require(script:WaitForChild("ChatChannel"));
local v34 = require(script:WaitForChild("ChatWindow")).new();
local v35 = require(script:WaitForChild("ChannelsBar")).new();
local v36 = v32.new();
local v37 = require(script:WaitForChild("CommandProcessor")).new();
local v38 = require(script:WaitForChild("ChatBar")).new(v37, v34);
v34:CreateGuiObjects(v30);
v34:RegisterChatBar(v38);
v34:RegisterChannelsBar(v35);
v34:RegisterMessageLogDisplay(v36);
v20:RegisterChatWindow(v34);
local v39 = require(script:WaitForChild("MessageSender"));
v39:RegisterSayMessageFunction(u3.SayMessageRequest);
if l__UserInputService__25.TouchEnabled then
	v38:SetTextLabelText(u1:Get("GameChat_ChatMain_ChatBarTextTouch", "Tap here to chat"));
else
	v38:SetTextLabelText(u1:Get("GameChat_ChatMain_ChatBarText", "To chat click here or press \"/\" key"));
end;
local l__script__5 = script;
spawn(function()
	local v40 = require(l__script__5:WaitForChild("CurveUtil"));
	local v41 = 1 / (v19.ChatAnimationFPS and 20);
	local v42 = tick();
	while true do
		local v43 = tick();
		local v44 = v40:DeltaTimeToTimescale(v43 - v42);
		if v44 ~= 0 then
			v34:Update(v44);
		end;
		v42 = v43;
		wait(v41);	
	end;
end);
function CheckIfPointIsInSquare(p6, p7, p8)
	local v45 = false;
	if p7.X <= p6.X then
		v45 = false;
		if p6.X <= p8.X then
			v45 = false;
			if p7.Y <= p6.Y then
				v45 = p6.Y <= p8.Y;
			end;
		end;
	end;
	return v45;
end;
local u6 = 0;
local u7 = false;
local u8 = Instance.new("BindableEvent");
function DoBackgroundFadeIn(p9)
	u6 = tick();
	u7 = false;
	u8:Fire();
	v34:FadeInBackground(p9 or v19.ChatDefaultFadeDuration);
	if v34:GetCurrentChannel() then
		local l__Scroller__46 = v36.Scroller;
		l__Scroller__46.ScrollingEnabled = true;
		l__Scroller__46.ScrollBarThickness = v32.ScrollBarThickness;
	end;
end;
function DoBackgroundFadeOut(p10)
	u6 = tick();
	u7 = true;
	u8:Fire();
	v34:FadeOutBackground(p10 or v19.ChatDefaultFadeDuration);
	if v34:GetCurrentChannel() then
		local l__Scroller__47 = v36.Scroller;
		l__Scroller__47.ScrollingEnabled = false;
		l__Scroller__47.ScrollBarThickness = 0;
	end;
end;
local u9 = 0;
local u10 = false;
function DoTextFadeIn(p11)
	u9 = tick();
	u10 = false;
	u8:Fire();
	v34:FadeInText((p11 or v19.ChatDefaultFadeDuration) * 0);
end;
function DoTextFadeOut(p12)
	u9 = tick();
	u10 = true;
	u8:Fire();
	v34:FadeOutText(p12 or v19.ChatDefaultFadeDuration);
end;
function DoFadeInFromNewInformation()
	DoTextFadeIn();
	if v19.ChatShouldFadeInFromNewInformation then
		DoBackgroundFadeIn();
	end;
end;
function InstantFadeIn()
	DoBackgroundFadeIn(0);
	DoTextFadeIn(0);
end;
function InstantFadeOut()
	DoBackgroundFadeOut(0);
	DoTextFadeOut(0);
end;
local u11 = nil;
local u12 = Instance.new("BindableEvent");
function UpdateFadingForMouseState(p13)
	u11 = p13;
	u12:Fire();
	if v38:IsFocused() then
		return;
	end;
	if p13 then

	else
		DoBackgroundFadeIn();
		return;
	end;
	DoBackgroundFadeIn();
	DoTextFadeIn();
end;
local u13 = Instance.new("BindableEvent");
spawn(function()
	while true do
		l__RunService__26.RenderStepped:wait();
		while not (not u11) or not (not v38:IsFocused()) do
			if u11 then
				u12.Event:wait();
			end;
			if v38:IsFocused() then
				u13.Event:wait();
			end;		
		end;
		if not u7 then
			if v19.ChatWindowBackgroundFadeOutTime < tick() - u6 then
				DoBackgroundFadeOut();
			end;
		elseif not u10 then
			if v19.ChatWindowTextFadeOutTime < tick() - u9 then
				DoTextFadeOut();
			end;
		else
			u8.Event:wait();
		end;	
	end;
end);
function getClassicChatEnabled()
	if v19.ClassicChatEnabled ~= nil then
		return v19.ClassicChatEnabled;
	end;
	return l__Players__27.ClassicChat;
end;
function getBubbleChatEnabled()
	if v19.BubbleChatEnabled ~= nil then
		return v19.BubbleChatEnabled;
	end;
	return l__Players__27.BubbleChat;
end;
function bubbleChatOnly()
	return not getClassicChatEnabled() and getBubbleChatEnabled();
end;
local u14 = {};
function UpdateMousePosition(p14, p15)
	if u14.Visible then
		if u14.IsCoreGuiEnabled then
			if not u14.TopbarEnabled then
				if not v19.ChatOnWithTopBarOff then
					return;
				end;
			end;
		else
			return;
		end;
	else
		return;
	end;
	if bubbleChatOnly() then
		return;
	end;
	local l__AbsolutePosition__48 = v34.GuiObject.AbsolutePosition;
	local v49 = CheckIfPointIsInSquare(p14, l__AbsolutePosition__48, l__AbsolutePosition__48 + v34.GuiObject.AbsoluteSize);
	if v1 then
		if p15 then
			if v49 == true then
				return;
			end;
		end;
	end;
	if v49 ~= u11 then
		UpdateFadingForMouseState(v49);
	end;
end;
l__UserInputService__25.InputChanged:connect(function(p16, p17)
	if p16.UserInputType == Enum.UserInputType.MouseMovement then
		UpdateMousePosition(Vector2.new(p16.Position.X, p16.Position.Y), p17);
	end;
end);
l__UserInputService__25.TouchTap:connect(function(p18, p19)
	UpdateMousePosition(p18[1], false);
end);
l__UserInputService__25.TouchMoved:connect(function(p20, p21)
	UpdateMousePosition(Vector2.new(p20.Position.X, p20.Position.Y), false);
end);
if not v4 then
	l__UserInputService__25.Changed:connect(function(p22)
		if p22 == "MouseBehavior" and l__UserInputService__25.MouseBehavior == Enum.MouseBehavior.LockCenter then
			local l__AbsolutePosition__50 = v34.GuiObject.AbsolutePosition;
			if CheckIfPointIsInSquare(v30.AbsoluteSize / 2, l__AbsolutePosition__50, l__AbsolutePosition__50 + v34.GuiObject.AbsoluteSize) then
				l__UserInputService__25.MouseBehavior = Enum.MouseBehavior.Default;
			end;
		end;
	end);
end;
UpdateFadingForMouseState(true);
UpdateFadingForMouseState(false);
local v51 = {
	Signal = function()
		local v52 = {};
		local u15 = nil;
		local u16 = nil;
		local u17 = Instance.new("BindableEvent");
		function v52.fire(p23, ...)
			u15 = { ... };
			u16 = select("#", ...);
			u17:Fire();
		end;
		function v52.connect(p24, p25)
			if not p25 then
				error("connect(nil)", 2);
			end;
			return u17.Event:connect(function()
				p25(unpack(u15, 1, u16));
			end);
		end;
		function v52.wait(p26)
			u17.Event:wait();
			assert(u15, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.");
			return unpack(u15, 1, u16);
		end;
		return v52;
	end
};
function SetVisibility(p27)
	v34:SetVisible(p27);
	u14.VisibilityStateChanged:fire(p27);
	u14.Visible = p27;
	if u14.IsCoreGuiEnabled then
		if p27 then

		else
			InstantFadeOut();
			return;
		end;
	else
		return;
	end;
	InstantFadeIn();
end;
u14.TopbarEnabled = true;
u14.MessageCount = 0;
u14.Visible = true;
u14.IsCoreGuiEnabled = true;
function u14.ToggleVisibility(p28)
	SetVisibility(not v34:GetVisible());
end;
function u14.SetVisible(p29, p30)
	if v34:GetVisible() ~= p30 then
		SetVisibility(p30);
	end;
end;
function u14.FocusChatBar(p31)
	v38:CaptureFocus();
end;
function u14.EnterWhisperState(p32, p33)
	v38:EnterWhisperState(p33);
end;
function u14.GetVisibility(p34)
	return v34:GetVisible();
end;
function u14.GetMessageCount(p35)
	return p35.MessageCount;
end;
function u14.TopbarEnabledChanged(p36, p37)
	p36.TopbarEnabled = p37;
	p36.CoreGuiEnabled:fire(game:GetService("StarterGui"):GetCoreGuiEnabled(Enum.CoreGuiType.Chat));
end;
function u14.IsFocused(p38, p39)
	return v38:IsFocused();
end;
u14.ChatBarFocusChanged = v51.Signal();
u14.VisibilityStateChanged = v51.Signal();
u14.MessagesChanged = v51.Signal();
u14.MessagePosted = v51.Signal();
u14.CoreGuiEnabled = v51.Signal();
u14.ChatMakeSystemMessageEvent = v51.Signal();
u14.ChatWindowPositionEvent = v51.Signal();
u14.ChatWindowSizeEvent = v51.Signal();
u14.ChatBarDisabledEvent = v51.Signal();
function u14.fChatWindowPosition(p40)
	return v34.GuiObject.Position;
end;
function u14.fChatWindowSize(p41)
	return v34.GuiObject.Size;
end;
function u14.fChatBarDisabled(p42)
	return not v38:GetEnabled();
end;
if v7 then
	local u18 = true;
	l__ContextActionService__14:BindAction("ToggleChat", function(p43, p44, p45)
		if p43 == "ToggleChat" and p44 == Enum.UserInputState.Begin and u18 and p45.UserInputType == Enum.UserInputType.Keyboard then
			DoChatBarFocus();
		end;
	end, true, Enum.KeyCode.Slash);
else
	local u19 = true;
	function u14.SpecialKeyPressed(p46, p47, p48)
		if p47 == Enum.SpecialKey.ChatHotkey and u19 then
			DoChatBarFocus();
		end;
	end;
end;
u14.CoreGuiEnabled:connect(function(p49)
	u14.IsCoreGuiEnabled = p49;
	p49 = p49 and (u14.TopbarEnabled or v19.ChatOnWithTopBarOff);
	v34:SetCoreGuiEnabled(p49);
	if p49 then
		InstantFadeIn();
		return;
	end;
	v38:ReleaseFocus();
	InstantFadeOut();
end);
function trimTrailingSpaces(p50)
	local v53 = #p50;
	while true do
		if 0 < v53 then

		else
			break;
		end;
		if p50:find("^%s", v53) then

		else
			break;
		end;
		v53 = v53 - 1;	
	end;
	return p50:sub(1, v53);
end;
local u20 = false;
u14.ChatMakeSystemMessageEvent:connect(function(p51)
	if p51.Text and type(p51.Text) == "string" then
		while not u20 do
			wait();		
		end;
		local l__GeneralChannelName__54 = v19.GeneralChannelName;
		local v55 = v34:GetChannel(l__GeneralChannelName__54);
		if v55 then
			v55:AddMessageToChannel({
				ID = -1, 
				FromSpeaker = nil, 
				SpeakerUserId = 0, 
				OriginalChannel = l__GeneralChannelName__54, 
				IsFiltered = true, 
				MessageLength = string.len(p51.Text), 
				Message = trimTrailingSpaces(p51.Text), 
				MessageType = v18.MessageTypeSetCore, 
				Time = os.time(), 
				ExtraData = p51
			});
			v35:UpdateMessagePostedInChannel(l__GeneralChannelName__54);
			u14.MessageCount = u14.MessageCount + 1;
			u14.MessagesChanged:fire(u14.MessageCount);
		end;
	end;
end);
u14.ChatBarDisabledEvent:connect(function(p52)
	if u19 then
		v38:SetEnabled(not p52);
		if p52 then
			v38:ReleaseFocus();
		end;
	end;
end);
u14.ChatWindowSizeEvent:connect(function(p53)
	v34.GuiObject.Size = p53;
end);
u14.ChatWindowPositionEvent:connect(function(p54)
	v34.GuiObject.Position = p54;
end);
function DoChatBarFocus()
	if not v34:GetCoreGuiEnabled() then
		return;
	end;
	if not v38:GetEnabled() then
		return;
	end;
	if not v38:IsFocused() then
		if v38:GetVisible() then
			u14:SetVisible(true);
			InstantFadeIn();
			v38:CaptureFocus();
			u14.ChatBarFocusChanged:fire(true);
		end;
	end;
end;
u13.Event:connect(function(p55)
	u14.ChatBarFocusChanged:fire(p55);
end);
function DoSwitchCurrentChannel(p56)
	if v34:GetChannel(p56) then
		v34:SwitchCurrentChannel(p56);
	end;
end;
function SendMessageToSelfInTargetChannel(p57, p58, p59)
	local v56 = v34:GetChannel(p58);
	if v56 then
		v56:AddMessageToChannel({
			ID = -1, 
			FromSpeaker = nil, 
			SpeakerUserId = 0, 
			OriginalChannel = p58, 
			IsFiltered = true, 
			MessageLength = string.len(p57), 
			Message = trimTrailingSpaces(p57), 
			MessageType = v18.MessageTypeSystem, 
			Time = os.time(), 
			ExtraData = p59
		});
	end;
end;
function chatBarFocused()
	if not u11 then
		DoBackgroundFadeIn();
		if u10 then
			DoTextFadeIn();
		end;
	end;
	u13:Fire(true);
end;
function chatBarFocusLost(p60, p61)
	DoBackgroundFadeIn();
	u13:Fire(false);
	if p60 then
		local v57 = v38:GetTextBox().Text;
		if v38:IsInCustomState() then
			local v58 = v38:GetCustomMessage();
			if v58 then
				v57 = v58;
			end;
			local v59 = v38:CustomStateProcessCompletedMessage(v57);
			v38:ResetCustomState();
			if v59 then
				return;
			end;
		end;
		v38:GetTextBox().Text = "";
		if v57 ~= "" then
			u14.MessagePosted:fire(v57);
			if not v37:ProcessCompletedChatMessage(v57, v34) then
				local v60 = nil;
				if v19.DisallowedWhiteSpace then
					local v61 = #v19.DisallowedWhiteSpace;
					local v62 = 1 - 1;
					while true do
						if v19.DisallowedWhiteSpace[v62] == "\t" then
							v57 = string.gsub(v57, v19.DisallowedWhiteSpace[v62], " ");
						else
							v57 = string.gsub(v57, v19.DisallowedWhiteSpace[v62], "");
						end;
						if 0 <= 1 then
							if v62 < v61 then

							else
								break;
							end;
						elseif v61 < v62 then

						else
							break;
						end;
						v62 = v62 + 1;					
					end;
				end;
				v60 = string.gsub(string.gsub(v57, "\n", ""), "[ ]+", " ");
				local v63 = v34:GetTargetMessageChannel();
				if v63 then
					v39:SendMessage(v60, v63);
					return;
				end;
				v39:SendMessage(v60, nil);
			end;
		end;
	end;
end;
local u21 = {};
function setupChatBarConnections()
	local v64 = #u21;
	local v65 = 1 - 1;
	while true do
		u21[v65]:Disconnect();
		if 0 <= 1 then
			if v65 < v64 then

			else
				break;
			end;
		elseif v64 < v65 then

		else
			break;
		end;
		v65 = v65 + 1;	
	end;
	u21 = {};
	table.insert(u21, (v38:GetTextBox().FocusLost:connect(chatBarFocusLost)));
	table.insert(u21, (v38:GetTextBox().Focused:connect(chatBarFocused)));
end;
setupChatBarConnections();
v38.GuiObjectsChanged:connect(setupChatBarConnections);
function getEchoMessagesInGeneral()
	if v19.EchoMessagesInGeneralChannel == nil then
		return true;
	end;
	return v19.EchoMessagesInGeneralChannel;
end;
u3.OnMessageDoneFiltering.OnClientEvent:connect(function(p62)
	if not v19.ShowUserOwnFilteredMessage and p62.FromSpeaker == v28.Name then
		return;
	end;
	local l__OriginalChannel__66 = p62.OriginalChannel;
	local v67 = v34:GetChannel(l__OriginalChannel__66);
	if v67 then
		v67:UpdateMessageFiltered(p62);
	end;
	if getEchoMessagesInGeneral() and v19.GeneralChannelName and l__OriginalChannel__66 ~= v19.GeneralChannelName then
		local v68 = v34:GetChannel(v19.GeneralChannelName);
		if v68 then
			v68:UpdateMessageFiltered(p62);
		end;
	end;
end);
u3.OnNewMessage.OnClientEvent:connect(function(p63, p64)
	local v69 = v34:GetChannel(p64);
	if v69 then
		v69:AddMessageToChannel(p63);
		if p63.FromSpeaker ~= v28.Name then
			v35:UpdateMessagePostedInChannel(p64);
		end;
		if getEchoMessagesInGeneral() and v19.GeneralChannelName and p64 ~= v19.GeneralChannelName then
			local v70 = v34:GetChannel(v19.GeneralChannelName);
			if v70 then
				v70:AddMessageToChannel(p63);
			end;
		end;
		u14.MessageCount = u14.MessageCount + 1;
		u14.MessagesChanged:fire(u14.MessageCount);
		DoFadeInFromNewInformation();
	end;
end);
u3.OnNewSystemMessage.OnClientEvent:connect(function(p65, p66)
	p66 = p66 and "System";
	local v71 = v34:GetChannel(p66);
	if v71 then
		v71:AddMessageToChannel(p65);
		v35:UpdateMessagePostedInChannel(p66);
		u14.MessageCount = u14.MessageCount + 1;
		u14.MessagesChanged:fire(u14.MessageCount);
		DoFadeInFromNewInformation();
		if getEchoMessagesInGeneral() and v19.GeneralChannelName and p66 ~= v19.GeneralChannelName then
			local v72 = v34:GetChannel(v19.GeneralChannelName);
			if v72 then
				v72:AddMessageToChannel(p65);
				return;
			end;
		end;
	else
		warn(string.format("Just received system message for channel I'm not in [%s]", p66));
	end;
end);
function HandleChannelJoined(p67, p68, p69, p70, p71, p72)
	if v34:GetChannel(p67) then
		v34:RemoveChannel(p67);
	end;
	if p67 == v19.GeneralChannelName then
		u20 = true;
	end;
	if p70 then
		v38:SetChannelNameColor(p67, p70);
	end;
	local v73 = v34:AddChannel(p67);
	if v73 then
		if p67 == v19.GeneralChannelName then
			DoSwitchCurrentChannel(p67);
		end;
		if p69 then
			local v74 = 1;
			if v19.MessageHistoryLengthPerChannel < #p69 then
				v74 = #p69 - v19.MessageHistoryLengthPerChannel;
			end;
			local v75 = #p69;
			local v76 = v74 - 1;
			while true do
				v73:AddMessageToChannel(p69[v76]);
				if 0 <= 1 then
					if v76 < v75 then

					else
						break;
					end;
				elseif v75 < v76 then

				else
					break;
				end;
				v76 = v76 + 1;			
			end;
			if getEchoMessagesInGeneral() then
				if p71 then
					if v19.GeneralChannelName then
						if p67 ~= v19.GeneralChannelName then
							local v77 = v34:GetChannel(v19.GeneralChannelName);
							if v77 then
								v77:AddMessagesToChannelByTimeStamp(p69, v74);
							end;
						end;
					end;
				end;
			end;
		end;
		if p68 ~= "" then
			local v78 = {
				ID = -1, 
				FromSpeaker = nil, 
				SpeakerUserId = 0, 
				OriginalChannel = p67, 
				IsFiltered = true, 
				MessageLength = string.len(p68), 
				Message = trimTrailingSpaces(p68), 
				MessageType = v18.MessageTypeWelcome, 
				Time = os.time(), 
				ExtraData = nil
			};
			v73:AddMessageToChannel(v78);
			if getEchoMessagesInGeneral() then
				if p72 then
					if not v19.ShowChannelsBar then
						if p67 ~= v19.GeneralChannelName then
							local v79 = v34:GetChannel(v19.GeneralChannelName);
							if v79 then
								v79:AddMessageToChannel(v78);
							end;
						end;
					end;
				end;
			end;
		end;
		DoFadeInFromNewInformation();
	end;
end;
u3.OnChannelJoined.OnClientEvent:connect(function(p73, p74, p75, p76)
	HandleChannelJoined(p73, p74, p75, p76, false, true);
end);
u3.OnChannelLeft.OnClientEvent:connect(function(p77)
	v34:RemoveChannel(p77);
	DoFadeInFromNewInformation();
end);
u3.OnMuted.OnClientEvent:connect(function(p78)

end);
u3.OnUnmuted.OnClientEvent:connect(function(p79)

end);
u3.OnMainChannelSet.OnClientEvent:connect(function(p80)
	DoSwitchCurrentChannel(p80);
end);
coroutine.wrap(function()
	local l__ChannelNameColorUpdated__80 = v15:WaitForChild("ChannelNameColorUpdated", 5);
	if l__ChannelNameColorUpdated__80 then
		l__ChannelNameColorUpdated__80.OnClientEvent:connect(function(p81, p82)
			v38:SetChannelNameColor(p81, p82);
		end);
	end;
end)();
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
pcall(function()
	u22 = l__StarterGui__13:GetCore("PlayerBlockedEvent");
	u23 = l__StarterGui__13:GetCore("PlayerMutedEvent");
	u24 = l__StarterGui__13:GetCore("PlayerUnblockedEvent");
	u25 = l__StarterGui__13:GetCore("PlayerUnmutedEvent");
end);
function SendSystemMessageToSelf(p83)
	local v81 = v34:GetCurrentChannel();
	if v81 then
		v81:AddMessageToChannel({
			ID = -1, 
			FromSpeaker = nil, 
			SpeakerUserId = 0, 
			OriginalChannel = v81.Name, 
			IsFiltered = true, 
			MessageLength = string.len(p83), 
			Message = trimTrailingSpaces(p83), 
			MessageType = v18.MessageTypeSystem, 
			Time = os.time(), 
			ExtraData = nil
		});
	end;
end;
function MutePlayer(p84)
	local l__MutePlayerRequest__82 = v15:FindFirstChild("MutePlayerRequest");
	if l__MutePlayerRequest__82 then

	else
		return false;
	end;
	return l__MutePlayerRequest__82:InvokeServer(p84.Name);
end;
if u22 then
	u22.Event:connect(function(p85)
		if MutePlayer(p85) then
			if v19.PlayerDisplayNamesEnabled then
				local v83 = p85.DisplayName;
			else
				v83 = p85.Name;
			end;
			SendSystemMessageToSelf(string.gsub(u1:Get("GameChat_ChatMain_SpeakerHasBeenBlocked", string.format("Speaker '%s' has been blocked.", v83)), "{RBX_NAME}", v83));
		end;
	end);
end;
if u23 then
	u23.Event:connect(function(p86)
		if MutePlayer(p86) then
			if v19.PlayerDisplayNamesEnabled then
				local v84 = p86.DisplayName;
			else
				v84 = p86.Name;
			end;
			SendSystemMessageToSelf(string.gsub(u1:Get("GameChat_ChatMain_SpeakerHasBeenMuted", string.format("Speaker '%s' has been muted.", v84)), "{RBX_NAME}", v84));
		end;
	end);
end;
function UnmutePlayer(p87)
	local l__UnMutePlayerRequest__85 = v15:FindFirstChild("UnMutePlayerRequest");
	if l__UnMutePlayerRequest__85 then

	else
		return false;
	end;
	return l__UnMutePlayerRequest__85:InvokeServer(p87.Name);
end;
if u24 then
	u24.Event:connect(function(p88)
		if UnmutePlayer(p88) then
			if v19.PlayerDisplayNamesEnabled then
				local v86 = p88.DisplayName;
			else
				v86 = p88.Name;
			end;
			SendSystemMessageToSelf(string.gsub(u1:Get("GameChat_ChatMain_SpeakerHasBeenUnBlocked", string.format("Speaker '%s' has been unblocked.", v86)), "{RBX_NAME}", v86));
		end;
	end);
end;
if u25 then
	u25.Event:connect(function(p89)
		if UnmutePlayer(p89) then
			if v19.PlayerDisplayNamesEnabled then
				local v87 = p89.DisplayName;
			else
				v87 = p89.Name;
			end;
			SendSystemMessageToSelf(string.gsub(u1:Get("GameChat_ChatMain_SpeakerHasBeenUnMuted", string.format("Speaker '%s' has been unmuted.", v87)), "{RBX_NAME}", v87));
		end;
	end);
end;
spawn(function()
	if v28.UserId > 0 then
		pcall(function()
			local v88 = l__StarterGui__13:GetCore("GetBlockedUserIds");
			if #v88 > 0 then
				local l__SetBlockedUserIdsRequest__89 = v15:FindFirstChild("SetBlockedUserIdsRequest");
				if l__SetBlockedUserIdsRequest__89 then
					l__SetBlockedUserIdsRequest__89:FireServer(v88);
				end;
			end;
		end);
	end;
end);
spawn(function()
	local v90, v91 = pcall(function()
		return l__Chat__12:CanUserChatAsync(v28.UserId);
	end);
	if v90 then
		u19 = l__RunService__26:IsStudio() and v91;
	end;
end);
local v92 = u3.GetInitDataRequest:InvokeServer();
for v93, v94 in pairs(v92.Channels) do
	if v94[1] == v19.GeneralChannelName then
		HandleChannelJoined(v94[1], v94[2], v94[3], v94[4], true, false);
	end;
end;
for v95, v96 in pairs(v92.Channels) do
	if v96[1] ~= v19.GeneralChannelName then
		HandleChannelJoined(v96[1], v96[2], v96[3], v96[4], true, false);
	end;
end;
return u14;
