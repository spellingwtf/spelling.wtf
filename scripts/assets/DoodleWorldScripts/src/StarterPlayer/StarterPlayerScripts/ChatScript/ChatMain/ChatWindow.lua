-- Decompiled with the Synapse X Luau decompiler.

local v1 = false;
local v2, v3 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserFixMouseCapture");
end);
if v2 then
	v1 = v3;
end;
local v4 = {};
local l__Players__5 = game:GetService("Players");
local l__Chat__6 = game:GetService("Chat");
local l__Chat__7 = game:GetService("Chat");
local l__Parent__8 = script.Parent;
local v9 = {};
v9.__index = v9;
local u1 = require(l__Chat__7:WaitForChild("ClientChatModules"):WaitForChild("ChatSettings"));
function getClassicChatEnabled()
	if u1.ClassicChatEnabled ~= nil then
		return u1.ClassicChatEnabled;
	end;
	return l__Players__5.ClassicChat;
end;
function getBubbleChatEnabled()
	if u1.BubbleChatEnabled ~= nil then
		return u1.BubbleChatEnabled;
	end;
	return l__Players__5.BubbleChat;
end;
function bubbleChatOnly()
	return not getClassicChatEnabled() and getBubbleChatEnabled();
end;
function mergeProps(p1, p2)
	if p1 then
		if not p2 then
			return;
		end;
	else
		return;
	end;
	local v10, v11, v12 = pairs(p1);
	while true do
		local v13, v14 = v10(v11, v12);
		if v13 then

		else
			break;
		end;
		v12 = v13;
		if p2[v13] ~= nil then
			p2[v13] = v14;
		end;	
	end;
end;
local l__PlayerGui__2 = l__Players__5.LocalPlayer:WaitForChild("PlayerGui");
function v9.CreateGuiObjects(p3, p4)
	local u3 = nil;
	pcall(function()
		u3 = l__Chat__7:InvokeChatCallback(Enum.ChatCallbackType.OnCreatingChatWindow, nil);
	end);
	mergeProps(u3, u1);
	local v15 = Instance.new("Frame");
	v15.BackgroundTransparency = 1;
	v15.Active = u1.WindowDraggable;
	v15.Parent = p4;
	v15.AutoLocalize = false;
	local v16 = Instance.new("Frame");
	v16.Selectable = false;
	v16.Name = "ChatBarParentFrame";
	v16.BackgroundTransparency = 1;
	v16.Parent = v15;
	local v17 = Instance.new("Frame");
	v17.Selectable = false;
	v17.Name = "ChannelsBarParentFrame";
	v17.BackgroundTransparency = 1;
	v17.Position = UDim2.new(0, 0, 0, 0);
	v17.Parent = v15;
	local v18 = Instance.new("Frame");
	v18.Selectable = false;
	v18.Name = "ChatChannelParentFrame";
	v18.BackgroundTransparency = 1;
	v18.BackgroundColor3 = u1.BackGroundColor;
	v18.BackgroundTransparency = 0.6;
	v18.BorderSizePixel = 0;
	v18.Parent = v15;
	local v19 = Instance.new("ImageButton");
	v19.Selectable = false;
	v19.Image = "";
	v19.BackgroundTransparency = 0.6;
	v19.BorderSizePixel = 0;
	v19.Visible = false;
	v19.BackgroundColor3 = u1.BackGroundColor;
	v19.Active = true;
	if bubbleChatOnly() then
		v19.Position = UDim2.new(1, -v19.AbsoluteSize.X, 0, 0);
	else
		v19.Position = UDim2.new(1, -v19.AbsoluteSize.X, 1, -v19.AbsoluteSize.Y);
	end;
	v19.Parent = v15;
	local v20 = Instance.new("ImageLabel");
	v20.Selectable = false;
	v20.Size = UDim2.new(0.8, 0, 0.8, 0);
	v20.Position = UDim2.new(0.2, 0, 0.2, 0);
	v20.BackgroundTransparency = 1;
	v20.Image = "rbxassetid://261880743";
	v20.Parent = v19;
	local function v21()
		local v22 = v15;
		while v22 and not v22:IsA("ScreenGui") do
			v22 = v22.Parent;		
		end;
		return v22;
	end;
	local v23 = 3;
	local v24 = v21();
	if v24.AbsoluteSize.X <= 640 then
		v23 = 1;
	elseif v24.AbsoluteSize.X <= 1024 then
		v23 = 2;
	end;
	local u4 = false;
	local function u5()
		if u4 then
			return;
		end;
		u4 = true;
		if not v15:IsDescendantOf(l__PlayerGui__2) then
			return;
		end;
		local v25 = v21();
		local l__MinimumWindowSize__26 = u1.MinimumWindowSize;
		local l__MaximumWindowSize__27 = u1.MaximumWindowSize;
		local v28 = l__MinimumWindowSize__26.X.Scale * v25.AbsoluteSize.X + l__MinimumWindowSize__26.X.Offset;
		local v29 = math.max(l__MinimumWindowSize__26.Y.Scale * v25.AbsoluteSize.Y + l__MinimumWindowSize__26.Y.Offset, v17.AbsoluteSize.Y + v16.AbsoluteSize.Y);
		local v30 = l__MaximumWindowSize__27.X.Scale * v25.AbsoluteSize.X + l__MaximumWindowSize__27.X.Offset;
		local v31 = l__MaximumWindowSize__27.Y.Scale * v25.AbsoluteSize.Y + l__MaximumWindowSize__27.Y.Offset;
		local l__X__32 = v15.AbsoluteSize.X;
		local l__Y__33 = v15.AbsoluteSize.Y;
		if l__X__32 < v28 then
			v15.Size = v15.Size + UDim2.new(0, v28 - l__X__32, 0, 0);
		elseif v30 < l__X__32 then
			v15.Size = v15.Size + UDim2.new(0, v30 - l__X__32, 0, 0);
		end;
		if l__Y__33 < v29 then
			v15.Size = v15.Size + UDim2.new(0, 0, 0, v29 - l__Y__33);
		elseif v31 < l__Y__33 then
			v15.Size = v15.Size + UDim2.new(0, 0, 0, v31 - l__Y__33);
		end;
		local v34 = v15.AbsoluteSize.X / v25.AbsoluteSize.X;
		local v35 = v15.AbsoluteSize.Y / v25.AbsoluteSize.Y;
		if v1 then
			v34 = math.min(v34, 0.45);
			v35 = math.min(v34, 0.45);
		end;
		v15.Size = UDim2.new(v34, 0, v35, 0);
		u4 = false;
	end;
	v15.Changed:connect(function(p5)
		if p5 == "AbsoluteSize" then
			u5();
		end;
	end);
	v19.DragBegin:connect(function(p6)
		v15.Draggable = false;
	end);
	v19.DragStopped:connect(function(p7, p8)
		v15.Draggable = u1.WindowDraggable;
	end);
	local u6 = false;
	local function u7(p9)
		if u1.WindowDraggable == false and u1.WindowResizable == false then
			return;
		end;
		local v36 = p9 - v15.AbsolutePosition + v19.AbsoluteSize;
		v15.Size = UDim2.new(0, v36.X, 0, v36.Y);
		if bubbleChatOnly() then
			v19.Position = UDim2.new(1, -v19.AbsoluteSize.X, 0, 0);
			return;
		end;
		v19.Position = UDim2.new(1, -v19.AbsoluteSize.X, 1, -v19.AbsoluteSize.Y);
	end;
	v19.Changed:connect(function(p10)
		if p10 == "AbsolutePosition" and not v15.Draggable then
			if u6 then
				return;
			end;
			u6 = true;
			u7(v19.AbsolutePosition);
			u6 = false;
		end;
	end);
	local function v37(p11)
		if v23 == 1 then
			p11 = p11 or u1.ChatBarTextSizePhone;
		else
			p11 = p11 or u1.ChatBarTextSize;
		end;
		return p11 + 14 + 10;
	end;
	if bubbleChatOnly() then
		v16.Position = UDim2.new(0, 0, 0, 0);
		v17.Visible = false;
		v17.Active = false;
		v18.Visible = false;
		v18.Active = false;
		local v38 = v21();
		if v23 == 1 then
			local v39 = u1.DefaultWindowSizePhone.X.Scale;
			local v40 = u1.DefaultWindowSizePhone.X.Offset;
		elseif v23 == 2 then
			v39 = u1.DefaultWindowSizeTablet.X.Scale;
			v40 = u1.DefaultWindowSizeTablet.X.Offset;
		else
			v39 = u1.DefaultWindowSizeDesktop.X.Scale;
			v40 = u1.DefaultWindowSizeDesktop.X.Offset;
		end;
		v15.Size = UDim2.new(v39, v40, 0, (v37()));
		v15.Position = u1.DefaultWindowPosition;
	else
		local v41 = v21();
		if v23 == 1 then
			v15.Size = u1.DefaultWindowSizePhone;
		elseif v23 == 2 then
			v15.Size = u1.DefaultWindowSizeTablet;
		else
			v15.Size = u1.DefaultWindowSizeDesktop;
		end;
		v15.Position = u1.DefaultWindowPosition;
	end;
	if v23 == 1 then
		u1.ChatWindowTextSize = u1.ChatWindowTextSizePhone;
		u1.ChatChannelsTabTextSize = u1.ChatChannelsTabTextSizePhone;
		u1.ChatBarTextSize = u1.ChatBarTextSizePhone;
	end;
	local function v42(p12)
		v15.Active = p12;
		v15.Draggable = p12;
	end;
	local function u8(p13)
		if v23 == 1 then
			p13 = p13 or u1.ChatChannelsTabTextSizePhone;
		else
			p13 = p13 or u1.ChatChannelsTabTextSize;
		end;
		return math.max(32, p13 + 8) + 2;
	end;
	local function u9()
		local v43 = nil;
		local v44 = u8();
		v43 = v37();
		if not u1.ShowChannelsBar then
			v18.Size = UDim2.new(1, 0, 1, -(v43 + 2 + 2));
			v18.Position = UDim2.new(0, 0, 0, 2);
			return;
		end;
		v18.Size = UDim2.new(1, 0, 1, -(v44 + v43 + 2 + 2));
		v18.Position = UDim2.new(0, 0, 0, v44 + 2);
	end;
	local function v45(p14)
		v17.Size = UDim2.new(1, 0, 0, (u8(p14)));
		u9();
	end;
	local function u10(p15)
		local v46 = nil;
		v19.Visible = p15;
		v19.Draggable = p15;
		v46 = v16.Size.Y.Offset;
		if p15 then
			v16.Size = UDim2.new(1, -v46 - 2, 0, v46);
			if bubbleChatOnly() then
				return;
			end;
		else
			v16.Size = UDim2.new(1, 0, 0, v46);
			if not bubbleChatOnly() then
				v16.Position = UDim2.new(0, 0, 1, -v46);
			end;
			return;
		end;
		v16.Position = UDim2.new(0, 0, 1, -v46);
	end;
	local function v47(p16)
		local v48 = v37(p16);
		v16.Size = UDim2.new(1, 0, 0, v48);
		if not bubbleChatOnly() then
			v16.Position = UDim2.new(0, 0, 1, -v48);
		end;
		v19.Size = UDim2.new(0, v48, 0, v48);
		v19.Position = UDim2.new(1, -v48, 1, -v48);
		u9();
		u10(u1.WindowResizable);
	end;
	local function v49(p17)
		v17.Visible = p17;
		u9();
	end;
	v45(u1.ChatChannelsTabTextSize);
	v47(u1.ChatBarTextSize);
	v42(u1.WindowDraggable);
	u10(u1.WindowResizable);
	v49(u1.ShowChannelsBar);
	u1.SettingsChanged:connect(function(p18, p19)
		if p18 == "WindowDraggable" then
			v42(p19);
			return;
		end;
		if p18 == "WindowResizable" then
			u10(p19);
			return;
		end;
		if p18 == "ChatChannelsTabTextSize" then
			v45(p19);
			return;
		end;
		if p18 == "ChatBarTextSize" then
			v47(p19);
			return;
		end;
		if p18 == "ShowChannelsBar" then
			v49(p19);
		end;
	end);
	p3.GuiObject = v15;
	p3.GuiObjects.BaseFrame = v15;
	p3.GuiObjects.ChatBarParentFrame = v16;
	p3.GuiObjects.ChannelsBarParentFrame = v17;
	p3.GuiObjects.ChatChannelParentFrame = v18;
	p3.GuiObjects.ChatResizerFrame = v19;
	p3.GuiObjects.ResizeIcon = v20;
	p3:AnimGuiObjects();
end;
function v9.GetChatBar(p20)
	return p20.ChatBar;
end;
function v9.RegisterChatBar(p21, p22)
	p21.ChatBar = p22;
	p21.ChatBar:CreateGuiObjects(p21.GuiObjects.ChatBarParentFrame);
end;
function v9.RegisterChannelsBar(p23, p24)
	p23.ChannelsBar = p24;
	p23.ChannelsBar:CreateGuiObjects(p23.GuiObjects.ChannelsBarParentFrame);
end;
function v9.RegisterMessageLogDisplay(p25, p26)
	p25.MessageLogDisplay = p26;
	p25.MessageLogDisplay.GuiObject.Parent = p25.GuiObjects.ChatChannelParentFrame;
end;
local u11 = require(l__Parent__8:WaitForChild("ChatChannel"));
function v9.AddChannel(p27, p28)
	if p27:GetChannel(p28) then
		error("Channel '" .. p28 .. "' already exists!");
		return;
	end;
	local v50 = u11.new(p28, p27.MessageLogDisplay);
	p27.Channels[p28:lower()] = v50;
	v50:SetActive(false);
	local v51 = p27.ChannelsBar:AddChannelTab(p28);
	v51.NameTag.MouseButton1Click:connect(function()
		p27:SwitchCurrentChannel(p28);
	end);
	v50:RegisterChannelTab(v51);
	return v50;
end;
function v9.GetFirstChannel(p29)
	local v52, v53, v54 = pairs(p29.Channels);
	local v55, v56 = v52(v53, v54);
	if not v55 then
		return nil;
	end;
	return v56;
end;
function v9.RemoveChannel(p30, p31)
	if not p30:GetChannel(p31) then
		error("Channel '" .. p31 .. "' does not exist!");
	end;
	local v57 = p31:lower();
	local v58 = false;
	if p30.Channels[v57] == p30:GetCurrentChannel() then
		v58 = true;
		p30:SwitchCurrentChannel(nil);
	end;
	p30.Channels[v57]:Destroy();
	p30.Channels[v57] = nil;
	p30.ChannelsBar:RemoveChannelTab(p31);
	if v58 then
		if p30:GetChannel(u1.GeneralChannelName) ~= nil and v57 ~= u1.GeneralChannelName:lower() then
			local v59 = u1.GeneralChannelName;
		else
			local v60 = p30:GetFirstChannel();
			v59 = v60 and v60.Name or nil;
		end;
		p30:SwitchCurrentChannel(v59);
	end;
	if not u1.ShowChannelsBar and p30.ChatBar.TargetChannel == p31 then
		p30.ChatBar:SetChannelTarget(u1.GeneralChannelName);
	end;
end;
function v9.GetChannel(p32, p33)
	return p33 and p32.Channels[p33:lower()] or nil;
end;
function v9.GetTargetMessageChannel(p34)
	if not u1.ShowChannelsBar then
		return p34.ChatBar.TargetChannel;
	end;
	local v61 = p34:GetCurrentChannel();
	return v61 and v61.Name;
end;
function v9.GetCurrentChannel(p35)
	return p35.CurrentChannel;
end;
function v9.SwitchCurrentChannel(p36, p37)
	if not u1.ShowChannelsBar then
		local v62 = p36:GetChannel(p37);
		if v62 then
			p36.ChatBar:SetChannelTarget(v62.Name);
		end;
		p37 = u1.GeneralChannelName;
	end;
	local v63 = p36:GetCurrentChannel();
	local v64 = p36:GetChannel(p37);
	if v64 == nil then
		error(string.format("Channel '%s' does not exist.", p37));
	end;
	if v64 ~= v63 then
		if v63 then
			v63:SetActive(false);
			p36.ChannelsBar:GetChannelTab(v63.Name):SetActive(false);
		end;
		if v64 then
			v64:SetActive(true);
			p36.ChannelsBar:GetChannelTab(v64.Name):SetActive(true);
		end;
		p36.CurrentChannel = v64;
	end;
end;
function v9.UpdateFrameVisibility(p38)
	p38.GuiObject.Visible = p38.Visible and p38.CoreGuiEnabled;
end;
function v9.GetVisible(p39)
	return p39.Visible;
end;
function v9.SetVisible(p40, p41)
	p40.Visible = p41;
	p40:UpdateFrameVisibility();
end;
function v9.GetCoreGuiEnabled(p42)
	return p42.CoreGuiEnabled;
end;
function v9.SetCoreGuiEnabled(p43, p44)
	p43.CoreGuiEnabled = p44;
	p43:UpdateFrameVisibility();
end;
function v9.EnableResizable(p45)
	p45.GuiObjects.ChatResizerFrame.Active = true;
end;
function v9.DisableResizable(p46)
	p46.GuiObjects.ChatResizerFrame.Active = false;
end;
local u12 = require(l__Parent__8:WaitForChild("CurveUtil"));
function v9.FadeOutBackground(p47, p48)
	p47.ChannelsBar:FadeOutBackground(p48);
	p47.MessageLogDisplay:FadeOutBackground(p48);
	p47.ChatBar:FadeOutBackground(p48);
	p47.AnimParams.Background_TargetTransparency = 1;
	p47.AnimParams.Background_NormalizedExptValue = u12:NormalizedDefaultExptValueInSeconds(p48);
end;
function v9.FadeInBackground(p49, p50)
	p49.ChannelsBar:FadeInBackground(p50);
	p49.MessageLogDisplay:FadeInBackground(p50);
	p49.ChatBar:FadeInBackground(p50);
	p49.AnimParams.Background_TargetTransparency = 0.6;
	p49.AnimParams.Background_NormalizedExptValue = u12:NormalizedDefaultExptValueInSeconds(p50);
end;
function v9.FadeOutText(p51, p52)
	p51.MessageLogDisplay:FadeOutText(p52);
	p51.ChannelsBar:FadeOutText(p52);
end;
function v9.FadeInText(p53, p54)
	p53.MessageLogDisplay:FadeInText(p54);
	p53.ChannelsBar:FadeInText(p54);
end;
function v9.AnimGuiObjects(p55)
	p55.GuiObjects.ChatChannelParentFrame.BackgroundTransparency = p55.AnimParams.Background_CurrentTransparency;
	p55.GuiObjects.ChatResizerFrame.BackgroundTransparency = p55.AnimParams.Background_CurrentTransparency;
	p55.GuiObjects.ResizeIcon.ImageTransparency = p55.AnimParams.Background_CurrentTransparency;
end;
function v9.InitializeAnimParams(p56)
	p56.AnimParams.Background_TargetTransparency = 0.6;
	p56.AnimParams.Background_CurrentTransparency = 0.6;
	p56.AnimParams.Background_NormalizedExptValue = u12:NormalizedDefaultExptValueInSeconds(0);
end;
function v9.Update(p57, p58)
	p57.ChatBar:Update(p58);
	p57.ChannelsBar:Update(p58);
	p57.MessageLogDisplay:Update(p58);
	p57.AnimParams.Background_CurrentTransparency = u12:Expt(p57.AnimParams.Background_CurrentTransparency, p57.AnimParams.Background_TargetTransparency, p57.AnimParams.Background_NormalizedExptValue, p58);
	p57:AnimGuiObjects();
end;
function v4.new()
	local v65 = setmetatable({}, v9);
	v65.GuiObject = nil;
	v65.GuiObjects = {};
	v65.ChatBar = nil;
	v65.ChannelsBar = nil;
	v65.MessageLogDisplay = nil;
	v65.Channels = {};
	v65.CurrentChannel = nil;
	v65.Visible = true;
	v65.CoreGuiEnabled = true;
	v65.AnimParams = {};
	v65:InitializeAnimParams();
	return v65;
end;
return v4;
