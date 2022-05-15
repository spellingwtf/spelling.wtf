-- Decompiled with the Synapse X Luau decompiler.

local v1, v2 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserChatHistorySinksInput");
end);
local v3 = {
	ScrollBarThickness = 4
};
local l__Parent__4 = script.Parent;
local v5 = {};
v5.__index = v5;
local u1 = require(game:GetService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("ChatSettings"));
local u2 = v1 or v2;
function v5.Destroy(p1)
	p1.GuiObject:Destroy();
	p1.Destroyed = true;
end;
function v5.SetActive(p2, p3)
	p2.GuiObject.Visible = p3;
end;
function v5.UpdateMessageFiltered(p4, p5)
	local v6 = nil;
	local v7 = 1;
	local l__MessageObjectLog__8 = p4.MessageObjectLog;
	while v7 <= #l__MessageObjectLog__8 do
		local v9 = l__MessageObjectLog__8[v7];
		if v9.ID == p5.ID then
			v6 = v9;
			break;
		end;
		v7 = v7 + 1;	
	end;
	if v6 then
		v6.UpdateTextFunction(p5);
		p4:PositionMessageLabelInWindow(v6, v7);
	end;
end;
local u3 = require(l__Parent__4:WaitForChild("MessageLabelCreator")).new();
function v5.AddMessage(p6, p7)
	p6:WaitUntilParentedCorrectly();
	local v10 = u3:CreateMessageLabel(p7, p6.CurrentChannelName);
	if v10 == nil then
		return;
	end;
	table.insert(p6.MessageObjectLog, v10);
	p6:PositionMessageLabelInWindow(v10, #p6.MessageObjectLog);
end;
function v5.AddMessageAtIndex(p8, p9, p10)
	local v11 = u3:CreateMessageLabel(p9, p8.CurrentChannelName);
	if v11 == nil then
		return;
	end;
	table.insert(p8.MessageObjectLog, p10, v11);
	p8:PositionMessageLabelInWindow(v11, p10);
end;
function v5.RemoveLastMessage(p11)
	p11:WaitUntilParentedCorrectly();
	p11.MessageObjectLog[1]:Destroy();
	table.remove(p11.MessageObjectLog, 1);
end;
function v5.IsScrolledDown(p12)
	local l__Offset__12 = p12.Scroller.CanvasSize.Y.Offset;
	local l__Y__13 = p12.Scroller.AbsoluteWindowSize.Y;
	local v14 = true;
	if not (l__Offset__12 < l__Y__13) then
		v14 = l__Offset__12 - p12.Scroller.CanvasPosition.Y <= l__Y__13 + 5;
	end;
	return v14;
end;
function v5.UpdateMessageTextHeight(p13, p14)
	local l__BaseFrame__15 = p14.BaseFrame;
	for v16 = 1, 10 do
		if p14.BaseMessage.TextFits then
			break;
		end;
		l__BaseFrame__15.Size = UDim2.new(1, 0, 0, p14.GetHeightFunction(p13.Scroller.AbsoluteSize.X - v16));
	end;
end;
function v5.PositionMessageLabelInWindow(p15, p16, p17)
	p15:WaitUntilParentedCorrectly();
	local l__BaseFrame__17 = p16.BaseFrame;
	local v18 = 1;
	if p15.MessageObjectLog[p17 - 1] then
		if p17 == #p15.MessageObjectLog then
			v18 = p15.MessageObjectLog[p17 - 1].BaseFrame.LayoutOrder + 1;
		else
			v18 = p15.MessageObjectLog[p17 - 1].BaseFrame.LayoutOrder;
		end;
	end;
	l__BaseFrame__17.LayoutOrder = v18;
	l__BaseFrame__17.Size = UDim2.new(1, 0, 0, p16.GetHeightFunction(p15.Scroller.AbsoluteSize.X));
	l__BaseFrame__17.Parent = p15.Scroller;
	if p16.BaseMessage then
		p15:UpdateMessageTextHeight(p16);
	end;
	if p15:IsScrolledDown() then
		p15.Scroller.CanvasPosition = Vector2.new(0, math.max(0, p15.Scroller.CanvasSize.Y.Offset - p15.Scroller.AbsoluteSize.Y));
	end;
end;
function v5.ReorderAllMessages(p18)
	p18:WaitUntilParentedCorrectly();
	if p18.GuiObject.AbsoluteSize.Y < 1 then
		return;
	end;
	for v19, v20 in pairs(p18.MessageObjectLog) do
		p18:UpdateMessageTextHeight(v20);
	end;
	if not p18:IsScrolledDown() then
		p18.Scroller.CanvasPosition = p18.Scroller.CanvasPosition;
		return;
	end;
	p18.Scroller.CanvasPosition = Vector2.new(0, math.max(0, p18.Scroller.CanvasSize.Y.Offset - p18.Scroller.AbsoluteSize.Y));
end;
function v5.Clear(p19)
	for v21, v22 in pairs(p19.MessageObjectLog) do
		v22:Destroy();
	end;
	p19.MessageObjectLog = {};
end;
function v5.SetCurrentChannelName(p20, p21)
	p20.CurrentChannelName = p21;
end;
function v5.FadeOutBackground(p22, p23)

end;
function v5.FadeInBackground(p24, p25)

end;
local u4 = require(l__Parent__4:WaitForChild("CurveUtil"));
function v5.FadeOutText(p26, p27)
	for v23 = 1, #p26.MessageObjectLog do
		if p26.MessageObjectLog[v23].FadeOutFunction then
			p26.MessageObjectLog[v23].FadeOutFunction(p27, u4);
		end;
	end;
end;
function v5.FadeInText(p28, p29)
	for v24 = 1, #p28.MessageObjectLog do
		if p28.MessageObjectLog[v24].FadeInFunction then
			p28.MessageObjectLog[v24].FadeInFunction(p29, u4);
		end;
	end;
end;
function v5.Update(p30, p31)
	for v25 = 1, #p30.MessageObjectLog do
		if p30.MessageObjectLog[v25].UpdateAnimFunction then
			p30.MessageObjectLog[v25].UpdateAnimFunction(p31, u4);
		end;
	end;
end;
function v5.WaitUntilParentedCorrectly(p32)
	while not p32.GuiObject:IsDescendantOf(game:GetService("Players").LocalPlayer) do
		p32.GuiObject.AncestryChanged:wait();	
	end;
end;
local function u5()
	local v26 = Instance.new("Frame");
	v26.Selectable = false;
	v26.Size = UDim2.new(1, 0, 1, 0);
	v26.BackgroundTransparency = 1;
	local v27 = Instance.new("ScrollingFrame");
	v27.Selectable = u1.GamepadNavigationEnabled;
	v27.Name = "Scroller";
	v27.BackgroundTransparency = 1;
	v27.BorderSizePixel = 0;
	v27.Position = UDim2.new(0, 0, 0, 3);
	v27.Size = UDim2.new(1, -4, 1, -6);
	v27.CanvasSize = UDim2.new(0, 0, 0, 0);
	v27.ScrollBarThickness = v3.ScrollBarThickness;
	v27.Active = u2;
	v27.Parent = v26;
	local v28 = Instance.new("UIListLayout");
	v28.SortOrder = Enum.SortOrder.LayoutOrder;
	v28.Parent = v27;
	return v26, v27, v28;
end;
function v3.new()
	local v29 = setmetatable({}, v5);
	v29.Destroyed = false;
	local v30, v31, v32 = u5();
	v29.GuiObject = v30;
	v29.Scroller = v31;
	v29.Layout = v32;
	v29.MessageObjectLog = {};
	v29.Name = "MessageLogDisplay";
	v29.GuiObject.Name = "Frame_" .. v29.Name;
	v29.CurrentChannelName = "";
	v29.GuiObject:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		spawn(function()
			v29:ReorderAllMessages();
		end);
	end);
	local u6 = true;
	v29.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		local l__AbsoluteContentSize__33 = v29.Layout.AbsoluteContentSize;
		v29.Scroller.CanvasSize = UDim2.new(0, 0, 0, l__AbsoluteContentSize__33.Y);
		if u6 then
			v29.Scroller.CanvasPosition = Vector2.new(0, l__AbsoluteContentSize__33.Y - v29.Scroller.AbsoluteWindowSize.Y);
		end;
	end);
	v29.Scroller:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		u6 = v29:IsScrolledDown();
	end);
	return v29;
end;
return v3;
