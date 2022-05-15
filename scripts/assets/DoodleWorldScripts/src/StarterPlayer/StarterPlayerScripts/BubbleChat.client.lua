-- Decompiled with the Synapse X Luau decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Chat__3 = game:GetService("Chat");
local l__TextService__4 = game:GetService("TextService");
local v5 = l__Players__1.LocalPlayer;
while v5 == nil do
	l__Players__1.ChildAdded:wait();
	v5 = l__Players__1.LocalPlayer;
end;
local l__PlayerGui__6 = v5:WaitForChild("PlayerGui");
local v7, v8 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserShouldClipInGameChat");
end);
local v9 = 128 - string.len("...") - 1;
local v10 = Instance.new("ScreenGui");
v10.Name = "BubbleChat";
v10.ResetOnSpawn = false;
v10.Parent = l__PlayerGui__6;
local function u1()
	local v11 = {
		data = {}
	};
	local v12 = Instance.new("BindableEvent");
	v11.Emptied = v12.Event;
	function v11.Size(p1)
		return #v11.data;
	end;
	function v11.Empty(p2)
		return v11:Size() <= 0;
	end;
	function v11.PopFront(p3)
		table.remove(v11.data, 1);
		if v11:Empty() then
			v12:Fire();
		end;
	end;
	function v11.Front(p4)
		return v11.data[1];
	end;
	function v11.Get(p5, p6)
		return v11.data[p6];
	end;
	function v11.PushBack(p7, p8)
		table.insert(v11.data, p8);
	end;
	function v11.GetData(p9)
		return v11.data;
	end;
	return v11;
end;
local function u2()
	return {
		Fifo = u1(), 
		BillboardGui = nil
	};
end;
local function u3(p10, p11, p12)
	return p11 + (p12 - p11) * math.min(string.len(p10) / 75, 1);
end;
local function u4(p13, p14, p15)
	local v13 = {
		ComputeBubbleLifetime = function(p16, p17, p18)
			if p18 then
				return u3(p17, 8, 15);
			end;
			return u3(p17, 12, 20);
		end, 
		Origin = nil, 
		RenderBubble = nil, 
		Message = p13
	};
	v13.BubbleDieDelay = v13:ComputeBubbleLifetime(p13, p15);
	v13.BubbleColor = p14;
	v13.IsLocalPlayer = p15;
	return v13;
end;
local u5 = {
	WHITE = "dub", 
	BLUE = "blu", 
	GREEN = "gre", 
	RED = "red"
};
local u6 = {
	Default = Color3.fromRGB(50, 50, 50)
};
function createChatBubbleMain(p19, p20)
	local v14 = Instance.new("ImageLabel");
	v14.Name = "ChatBubble";
	v14.ScaleType = Enum.ScaleType.Slice;
	v14.SliceCenter = p20;
	v14.Image = "rbxasset://textures/" .. tostring(p19) .. ".png";
	v14.ImageColor3 = u6.Default;
	v14.BackgroundTransparency = 1;
	v14.BorderSizePixel = 0;
	v14.Size = UDim2.new(1, 0, 1, 0);
	v14.Position = UDim2.new(0, 0, 0, 0);
	return v14;
end;
function createChatBubbleTail(p21, p22)
	local v15 = Instance.new("ImageLabel");
	v15.Name = "ChatBubbleTail";
	v15.Image = "rbxasset://textures/ui/dialog_tail.png";
	v15.BackgroundTransparency = 1;
	v15.BorderSizePixel = 0;
	v15.Position = p21;
	v15.Size = p22;
	v15.ImageColor3 = u6.Default;
	return v15;
end;
function createChatBubbleWithTail(p23, p24, p25, p26)
	local v16 = createChatBubbleMain(p23, p26);
	createChatBubbleTail(p24, p25).Parent = v16;
	return v16;
end;
function createScaledChatBubbleWithTail(p27, p28, p29, p30)
	local v17 = createChatBubbleMain(p27, p30);
	local v18 = Instance.new("Frame");
	v18.Name = "ChatBubbleTailFrame";
	v18.BackgroundTransparency = 1;
	v18.SizeConstraint = Enum.SizeConstraint.RelativeXX;
	v18.Position = UDim2.new(0.5, 0, 1, 0);
	v18.Size = UDim2.new(p28, 0, p28, 0);
	v18.Parent = v17;
	createChatBubbleTail(p29, UDim2.new(1, 0, 0.5, 0)).Parent = v18;
	return v17;
end;
function createChatImposter(p31, p32, p33)
	local v19 = Instance.new("ImageLabel");
	v19.Name = "DialogPlaceholder";
	v19.Image = "rbxasset://textures/" .. tostring(p31) .. ".png";
	v19.BackgroundTransparency = 1;
	v19.BorderSizePixel = 0;
	v19.Position = UDim2.new(0, 0, -1.25, 0);
	v19.Size = UDim2.new(1, 0, 1, 0);
	local v20 = Instance.new("ImageLabel");
	v20.Name = "DotDotDot";
	v20.Image = "rbxasset://textures/" .. tostring(p32) .. ".png";
	v20.BackgroundTransparency = 1;
	v20.BorderSizePixel = 0;
	v20.Position = UDim2.new(0.001, 0, p33, 0);
	v20.Size = UDim2.new(1, 0, 0.7, 0);
	v20.Parent = v19;
	return v19;
end;
local u7 = {
	ChatBubble = {}, 
	ChatBubbleWithTail = {}, 
	ScalingChatBubbleWithTail = {}, 
	CharacterSortedMsg = (function()
		local v21 = {
			data = {}
		};
		local u8 = 0;
		function v21.Size(p34)
			return u8;
		end;
		function v21.Erase(p35, p36)
			if v21.data[p36] then
				u8 = u8 - 1;
			end;
			v21.data[p36] = nil;
		end;
		function v21.Set(p37, p38, p39)
			v21.data[p38] = p39;
			if p39 then
				u8 = u8 + 1;
			end;
		end;
		function v21.Get(p40, p41)
			if not p41 then
				return;
			end;
			if not v21.data[p41] then
				v21.data[p41] = u2();
				local u9 = nil;
				u9 = v21.data[p41].Fifo.Emptied:connect(function()
					u9:disconnect();
					v21:Erase(p41);
				end);
			end;
			return v21.data[p41];
		end;
		function v21.GetData(p42)
			return v21.data;
		end;
		return v21;
	end)()
};
local function v22(p43, p44, p45, p46, p47)
	u7.ChatBubble[p43] = createChatBubbleMain(p44, p47);
	if p46 then
		local v23 = -1;
	else
		v23 = 0;
	end;
	u7.ChatBubbleWithTail[p43] = createChatBubbleWithTail(p44, UDim2.new(0.5, -14, 1, v23), UDim2.new(0, 30, 0, 14), p47);
	if p46 then
		local v24 = -1;
	else
		v24 = 0;
	end;
	u7.ScalingChatBubbleWithTail[p43] = createScaledChatBubbleWithTail(p44, 0.5, UDim2.new(-0.5, 0, 0, v24), p47);
end;
v22(u5.WHITE, "ui/dialog_white", "ui/chatBubble_white_notify_bkg", false, Rect.new(5, 5, 15, 15));
v22(u5.BLUE, "ui/dialog_blue", "ui/chatBubble_blue_notify_bkg", true, Rect.new(7, 7, 33, 33));
v22(u5.RED, "ui/dialog_red", "ui/chatBubble_red_notify_bkg", true, Rect.new(7, 7, 33, 33));
v22(u5.GREEN, "ui/dialog_green", "ui/chatBubble_green_notify_bkg", true, Rect.new(7, 7, 33, 33));
function u7.SanitizeChatLine(p48, p49)
	if not (v9 < string.len(p49)) then
		return p49;
	end;
	return string.sub(p49, 1, v9 + string.len("..."));
end;
local function u10(p50)
	local v25 = Instance.new("BillboardGui");
	v25.Adornee = p50;
	v25.Size = UDim2.new(0, 400, 0, 250);
	v25.StudsOffset = Vector3.new(0, 1.5, 2);
	v25.Parent = v10;
	local v26 = Instance.new("Frame");
	v26.Name = "BillboardFrame";
	v26.Size = UDim2.new(1, 0, 1, 0);
	v26.Position = UDim2.new(0, 0, -0.5, 0);
	v26.BackgroundTransparency = 1;
	v26.Parent = v25;
	local u11 = nil;
	u11 = v26.ChildRemoved:connect(function()
		if #v26:GetChildren() <= 1 then
			u11:disconnect();
			v25:Destroy();
		end;
	end);
	u7:CreateSmallTalkBubble(u5.WHITE).Parent = v26;
	return v25;
end;
function u7.CreateBillboardGuiHelper(p51, p52, p53)
	if p52 and not u7.CharacterSortedMsg:Get(p52).BillboardGui then
		if not p53 and p52:IsA("BasePart") then
			u7.CharacterSortedMsg:Get(p52).BillboardGui = u10(p52);
			return;
		end;
		if p52:IsA("Model") then
			local l__Head__27 = p52:FindFirstChild("Head");
			if l__Head__27 and l__Head__27:IsA("BasePart") then
				u7.CharacterSortedMsg:Get(p52).BillboardGui = u10(l__Head__27);
			end;
		end;
	end;
end;
local function u12(p54)
	if not p54 or not l__Players__1.LocalPlayer.Character then
		return;
	end;
	return p54:IsDescendantOf(l__Players__1.LocalPlayer.Character);
end;
function u7.SetBillboardLODNear(p55, p56)
	local v28 = u12(p56.Adornee);
	p56.Size = UDim2.new(0, 400, 0, 250);
	if v28 then
		local v29 = 1.5;
	else
		v29 = 2.5;
	end;
	if v28 then
		local v30 = 2;
	else
		v30 = 0.1;
	end;
	p56.StudsOffset = Vector3.new(0, v29, v30);
	p56.Enabled = true;
	local v31 = p56.BillboardFrame:GetChildren();
	for v32 = 1, #v31 do
		v31[v32].Visible = true;
	end;
	p56.BillboardFrame.SmallTalkBubble.Visible = false;
end;
function u7.SetBillboardLODDistant(p57, p58)
	p58.Size = UDim2.new(4, 0, 3, 0);
	if u12(p58.Adornee) then
		local v33 = 2;
	else
		v33 = 0.1;
	end;
	p58.StudsOffset = Vector3.new(0, 3, v33);
	p58.Enabled = true;
	local v34 = p58.BillboardFrame:GetChildren();
	for v35 = 1, #v34 do
		v34[v35].Visible = false;
	end;
	p58.BillboardFrame.SmallTalkBubble.Visible = true;
end;
function u7.SetBillboardLODVeryFar(p59, p60)
	p60.Enabled = false;
end;
local function u13(p61)
	if not p61 then
		return 100000;
	end;
	return (p61.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude;
end;
function u7.SetBillboardGuiLOD(p62, p63, p64)
	if not p64 then
		return;
	end;
	if p64:IsA("Model") then
		local l__Head__36 = p64:FindFirstChild("Head");
		if not l__Head__36 then
			p64 = p64.PrimaryPart;
		else
			p64 = l__Head__36;
		end;
	end;
	local v37 = u13(p64);
	if v37 < 65 then
		u7:SetBillboardLODNear(p63);
		return;
	end;
	if v37 >= 65 and v37 < 100 then
		u7:SetBillboardLODDistant(p63);
		return;
	end;
	u7:SetBillboardLODVeryFar(p63);
end;
function u7.CameraCFrameChanged(p65)
	for v38, v39 in pairs(u7.CharacterSortedMsg:GetData()) do
		local l__BillboardGui__40 = v39.BillboardGui;
		if l__BillboardGui__40 then
			u7:SetBillboardGuiLOD(l__BillboardGui__40, v38);
		end;
	end;
end;
local l__Enum_Font_GothamSemibold__14 = Enum.Font.GothamSemibold;
local u15 = v7 or v8;
local l__Enum_FontSize_Size18__16 = Enum.FontSize.Size18;
function u7.CreateBubbleText(p66, p67)
	local v41 = Instance.new("TextLabel");
	v41.Name = "BubbleText";
	v41.BackgroundTransparency = 1;
	v41.Position = UDim2.new(0, 15, 0, 0);
	v41.Size = UDim2.new(1, -30, 1, 0);
	v41.Font = l__Enum_Font_GothamSemibold__14;
	if u15 then
		v41.ClipsDescendants = true;
	end;
	v41.TextColor3 = Color3.new(1, 1, 1);
	v41.TextWrapped = true;
	v41.FontSize = l__Enum_FontSize_Size18__16;
	v41.Text = p67;
	v41.Visible = false;
	v41.AutoLocalize = false;
	local v42 = v41:Clone();
	v41.ZIndex = 2;
	v42.Position = v41.Position + UDim2.new(0, 1, 0, 1);
	v42.Size = UDim2.new(1, 0, 1, 0);
	v42.AnchorPoint = Vector2.new(0, 0);
	v42.TextColor3 = Color3.new(0, 0, 0);
	v42.Parent = v41;
	return v41;
end;
function u7.CreateSmallTalkBubble(p68, p69)
	local v43 = u7.ScalingChatBubbleWithTail[p69]:Clone();
	v43.Name = "SmallTalkBubble";
	v43.ImageColor3 = u6.Default;
	v43.AnchorPoint = Vector2.new(0, 0.5);
	v43.Position = UDim2.new(0, 0, 0.5, 0);
	v43.Visible = false;
	local v44 = u7:CreateBubbleText("...");
	v44.TextScaled = true;
	v44.TextWrapped = false;
	v44.Visible = true;
	v44.Parent = v43;
	return v43;
end;
function u7.UpdateChatLinesForOrigin(p70, p71, p72)
	local l__Fifo__45 = u7.CharacterSortedMsg:Get(p71).Fifo;
	local v46 = l__Fifo__45:Size();
	local v47 = l__Fifo__45:GetData();
	if #v47 <= 1 then
		return;
	end;
	for v48 = #v47 - 1, 1, -1 do
		local l__RenderBubble__49 = v47[v48].RenderBubble;
		if not l__RenderBubble__49 then
			return;
		end;
		if v46 - v48 + 1 > 1 then
			local l__ChatBubbleTail__50 = l__RenderBubble__49:FindFirstChild("ChatBubbleTail");
			if l__ChatBubbleTail__50 then
				l__ChatBubbleTail__50:Destroy();
			end;
			local l__BubbleText__51 = l__RenderBubble__49:FindFirstChild("BubbleText");
			if l__BubbleText__51 then
				l__BubbleText__51.TextTransparency = 0.5;
			end;
		end;
		l__RenderBubble__49:TweenPosition(UDim2.new(l__RenderBubble__49.Position.X.Scale, l__RenderBubble__49.Position.X.Offset, 1, p72 - l__RenderBubble__49.Size.Y.Offset - 14), Enum.EasingDirection.Out, Enum.EasingStyle.Bounce, 0.1, true);
		p72 = p72 - l__RenderBubble__49.Size.Y.Offset - 14;
	end;
end;
function u7.DestroyBubble(p73, p74, p75)
	if not p74 then
		return;
	end;
	if p74:Empty() then
		return;
	end;
	local l__RenderBubble__52 = p74:Front().RenderBubble;
	if l__RenderBubble__52 then
		local u17 = l__RenderBubble__52;
		spawn(function()
			while p74:Front().RenderBubble ~= p75 do
				wait();			
			end;
			u17 = p74:Front().RenderBubble;
			local l__BubbleText__53 = u17:FindFirstChild("BubbleText");
			local l__ChatBubbleTail__54 = u17:FindFirstChild("ChatBubbleTail");
			while u17 and u17.ImageTransparency < 1 do
				local v55 = wait();
				if u17 then
					local v56 = v55 * 1.5;
					u17.ImageTransparency = u17.ImageTransparency + v56;
					if l__BubbleText__53 then
						l__BubbleText__53.TextTransparency = l__BubbleText__53.TextTransparency + v56;
					end;
					if l__ChatBubbleTail__54 then
						l__ChatBubbleTail__54.ImageTransparency = l__ChatBubbleTail__54.ImageTransparency + v56;
					end;
				end;			
			end;
			if u17 then
				u17:Destroy();
				p74:PopFront();
			end;
		end);
		return;
	end;
	p74:PopFront();
end;
function u7.CreateChatLineRender(p76, p77, p78, p79, p80)
	if not p77 then
		return;
	end;
	if not u7.CharacterSortedMsg:Get(p77).BillboardGui then
		u7:CreateBillboardGuiHelper(p77, p79);
	end;
	local l__BillboardGui__57 = u7.CharacterSortedMsg:Get(p77).BillboardGui;
	if l__BillboardGui__57 then
		local v58 = u7.ChatBubbleWithTail[p78.BubbleColor]:Clone();
		v58.Visible = false;
		local v59 = u7:CreateBubbleText(p78.Message);
		v59.Parent = v58;
		v58.Parent = l__BillboardGui__57.BillboardFrame;
		p78.RenderBubble = v58;
		local v60 = l__TextService__4:GetTextSize(v59.Text, 18, l__Enum_Font_GothamSemibold__14, Vector2.new(400, 250));
		local v61 = math.max((v60.X + 30) / 400, 0.1);
		v58.Size = UDim2.new(0, 0, 0, 0);
		v58.Position = UDim2.new(0.5, 0, 1, 0);
		local v62 = v60.Y / 18 * 28;
		v58:TweenSizeAndPosition(UDim2.new(v61, 0, 0, v62), UDim2.new((1 - v61) / 2, 0, 1, -v62), Enum.EasingDirection.Out, Enum.EasingStyle.Elastic, 0.1, true, function()
			v59.Visible = true;
		end);
		u7:SetBillboardGuiLOD(l__BillboardGui__57, p78.Origin);
		u7:UpdateChatLinesForOrigin(p78.Origin, -v62);
		delay(p78.BubbleDieDelay, function()
			u7:DestroyBubble(p80, v58);
		end);
	end;
end;
local function u18(p81, p82, p83)
	local v63 = u4(p82, u5.WHITE, p83);
	if p81 then
		v63.User = p81.Name;
		v63.Origin = p81.Character;
	end;
	return v63;
end;
function u7.OnPlayerChatMessage(p84, p85, p86, p87)
	if not u7:BubbleChatEnabled() then
		return;
	end;
	local l__LocalPlayer__64 = l__Players__1.LocalPlayer;
	local v65 = false;
	if l__LocalPlayer__64 ~= nil then
		v65 = p85 ~= l__LocalPlayer__64;
	end;
	local v66 = u18(p85, u7:SanitizeChatLine(p86), not v65);
	if p85 and v66.Origin then
		local l__Fifo__67 = u7.CharacterSortedMsg:Get(v66.Origin).Fifo;
		l__Fifo__67:PushBack(v66);
		u7:CreateChatLineRender(p85.Character, v66, true, l__Fifo__67);
	end;
end;
local function u19(p88, p89, p90, p91)
	local v68 = u4(p89, p91, p90);
	v68.Origin = p88;
	return v68;
end;
function u7.OnGameChatMessage(p92, p93, p94, p95)
	local l__LocalPlayer__69 = l__Players__1.LocalPlayer;
	local v70 = false;
	if l__LocalPlayer__69 ~= nil then
		v70 = l__LocalPlayer__69.Character ~= p93;
	end;
	local v71 = u5.WHITE;
	if p95 == Enum.ChatColor.Blue then
		v71 = u5.BLUE;
	elseif p95 == Enum.ChatColor.Green then
		v71 = u5.GREEN;
	elseif p95 == Enum.ChatColor.Red then
		v71 = u5.RED;
	end;
	local v72 = u19(p93, u7:SanitizeChatLine(p94), not v70, v71);
	u7.CharacterSortedMsg:Get(v72.Origin).Fifo:PushBack(v72);
	u7:CreateChatLineRender(p93, v72, false, u7.CharacterSortedMsg:Get(v72.Origin).Fifo);
end;
function u7.BubbleChatEnabled(p96)
	local l__ClientChatModules__73 = l__Chat__3:FindFirstChild("ClientChatModules");
	if l__ClientChatModules__73 then
		local l__ChatSettings__74 = l__ClientChatModules__73:FindFirstChild("ChatSettings");
		if l__ChatSettings__74 then
			local v75 = require(l__ChatSettings__74);
			if v75.BubbleChatEnabled ~= nil then
				return v75.BubbleChatEnabled;
			end;
		end;
	end;
	return l__Players__1.BubbleChat;
end;
function u7.ShowOwnFilteredMessage(p97)
	local v76 = nil;
	local l__ClientChatModules__77 = l__Chat__3:FindFirstChild("ClientChatModules");
	if l__ClientChatModules__77 then
		v76 = l__ClientChatModules__77:FindFirstChild("ChatSettings");
		if not v76 then
			return false;
		end;
	else
		return false;
	end;
	return require(v76).ShowUserOwnFilteredMessage;
end;
function findPlayer(p98)
	local v78, v79, v80 = pairs(l__Players__1:GetPlayers());
	while true do
		local v81, v82 = v78(v79, v80);
		if v81 then

		else
			break;
		end;
		v80 = v81;
		if v82.Name == p98 then
			return v82;
		end;	
	end;
end;
l__Chat__3.Chatted:connect(function(p99, p100, p101)
	u7:OnGameChatMessage(p99, p100, p101);
end);
local v83 = nil;
if game.Workspace.CurrentCamera then
	v83 = game.Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):connect(function(p102)
		u7:CameraCFrameChanged();
	end);
end;
local u20 = v83;
game.Workspace.Changed:connect(function(p103)
	if p103 == "CurrentCamera" then
		if u20 then
			u20:disconnect();
		end;
		if game.Workspace.CurrentCamera then
			u20 = game.Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):connect(function(p104)
				u7:CameraCFrameChanged();
			end);
		end;
	end;
end);
local u21 = nil;
function getAllowedMessageTypes()
	if u21 then
		return u21;
	end;
	local l__ClientChatModules__84 = l__Chat__3:FindFirstChild("ClientChatModules");
	if l__ClientChatModules__84 then

	else
		return { "Message", "Whisper" };
	end;
	local l__ChatSettings__85 = l__ClientChatModules__84:FindFirstChild("ChatSettings");
	if l__ChatSettings__85 then
		local v86 = require(l__ChatSettings__85);
		if v86.BubbleChatMessageTypes then
			u21 = v86.BubbleChatMessageTypes;
			return u21;
		end;
	end;
	local l__ChatConstants__87 = l__ClientChatModules__84:FindFirstChild("ChatConstants");
	if l__ChatConstants__87 then
		local v88 = require(l__ChatConstants__87);
		u21 = { v88.MessageTypeDefault, v88.MessageTypeWhisper };
	end;
	return u21;
end;
function checkAllowedMessageType(p105)
	local v89 = getAllowedMessageTypes();
	local v90 = #v89;
	local v91 = 1 - 1;
	while true do
		if v89[v91] == p105.MessageType then
			return true;
		end;
		if 0 <= 1 then
			if v91 < v90 then

			else
				break;
			end;
		elseif v90 < v91 then

		else
			break;
		end;
		v91 = v91 + 1;	
	end;
	return false;
end;
local v92 = l__ReplicatedStorage__2:WaitForChild("DefaultChatSystemChatEvents");
local l__OnMessageDoneFiltering__93 = v92:WaitForChild("OnMessageDoneFiltering");
v92:WaitForChild("OnNewMessage").OnClientEvent:connect(function(p106, p107)
	if not checkAllowedMessageType(p106) then
		return;
	end;
	local v94 = findPlayer(p106.FromSpeaker);
	if not v94 then
		return;
	end;
	if (not p106.IsFiltered or p106.FromSpeaker == v5.Name) and (p106.FromSpeaker ~= v5.Name or u7:ShowOwnFilteredMessage()) then
		return;
	end;
	u7:OnPlayerChatMessage(v94, p106.Message, nil);
end);
l__OnMessageDoneFiltering__93.OnClientEvent:connect(function(p108, p109)
	if not checkAllowedMessageType(p108) then
		return;
	end;
	local v95 = findPlayer(p108.FromSpeaker);
	if not v95 then
		return;
	end;
	if p108.FromSpeaker == v5.Name and not u7:ShowOwnFilteredMessage() then
		return;
	end;
	u7:OnPlayerChatMessage(v95, p108.Message, nil);
end);
