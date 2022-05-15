-- Decompiled with the Synapse X Luau decompiler.

local v1 = game:GetService("RunService"):IsStudio();
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local l__Event__3 = l__LocalPlayer__2:WaitForChild("Event");
local l__Function__4 = l__LocalPlayer__2:WaitForChild("Function");
local l__Shared__5 = game:GetService("ReplicatedStorage"):WaitForChild("Shared");
local v6 = require(script.Client);
v6.Network = {};
local v7 = game:GetService("ReplicatedStorage").Func:InvokeServer("securitykey");
local u1 = {};
l__Event__3.OnClientEvent:connect(function(p1, ...)
	if not u1[p1] then
		return;
	end;
	u1[p1](...);
end);
local u2 = {};
function l__Function__4.OnClientInvoke(p2, ...)
	if not u2[p2] then
		return;
	end;
	return u2[p2](...);
end;
v6.Network.BindEvent = function(p3, p4, p5)
	u1[p4] = p5;
end;
v6.Network.BindFunction = function(p6, p7, p8)
	u2[p7] = p8;
end;
v6.Network.post = function(p9, ...)
	if not v7 then
		return;
	end;
	l__Event__3:FireServer(v7, ...);
end;
v6.Network.get = function(p10, ...)
	if not v7 then
		return;
	end;
	return l__Function__4:InvokeServer(v7, ...);
end;
v6.Network.UnbindEvent = function(p11, p12)
	if u1[p12] then
		u1[p12] = nil;
	end;
end;
v6.Network:BindEvent("Print", function(p13)
	print(p13);
end);
v6.Network:BindEvent("PublicError", function(p14, p15, p16)
	print("SERVER SCRIPT ERROR: ");
	error(p16 .. "\n" .. p14 .. "\n " .. p15);
end);
local function v8(p17, p18)
	if v6[p17.Name] ~= nil then
		return;
	end;
	if p18 then
		p17 = p17:Clone();
	end;
	p17.Parent = script.Client;
	v6[p17.Name] = require(p17);
end;
v6.p = game.Players.LocalPlayer;
v6.GuiObjs = game.ReplicatedStorage:WaitForChild("Guis");
v6.Fodder = workspace:WaitForChild("Fodder");
v6.pgui = v6.p:WaitForChild("PlayerGui");
v6.guiholder = v6.pgui:WaitForChild("MainGui");
v6.Talky = v6.guiholder:WaitForChild("NPCTalk");
v6.Name = v6.p.Name;
v6.SmallScreen = 0;
v6.TestMode = v1;
for v9, v10 in pairs(l__Shared__5:GetChildren()) do
	v8(v10, true);
end;
v6.GlobalSignal = v6.Utilities.Signal();
v6.Utilities.SetupCF(v6);
v8(script.Client.Gui);
v8(script.Client.Lines);
v8(script.Client.Overworld);
for v11, v12 in pairs(script.Database:GetChildren()) do
	local v13 = require(v12);
	if typeof(v13) == "function" then
		v13 = v13(v6);
	end;
	v6[v12.Name] = v13;
end;
for v14, v15 in pairs(script.Client:GetChildren()) do
	local v16 = require(v15);
	if typeof(v16) == "function" then
		v16 = v16(v6);
	end;
	v6[v15.Name] = v16;
end;
if v6.guiholder.AbsoluteSize.X <= 800 then
	v6.guiholder.MainBattle.Size = UDim2.new(0.8, -50, 0.8, 0);
	v6.guiholder.PartyUI.Size = UDim2.new(0.8, -50, 0.8, 0);
	v6.guiholder.ItemUI.Size = UDim2.new(0.8, -50, 0.8, 0);
	v6.SmallScreen = -36;
else
	v6.SmallScreen = 0;
	v6.guiholder.MainBattle.Size = UDim2.new(0.8, 0, 0.8, 0);
	v6.guiholder.PartyUI.Size = UDim2.new(0.8, 0, 0.8, 0);
	v6.guiholder.ItemUI.Size = UDim2.new(0.8, 0, 0.8, 0);
end;
v6.guiholder:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	if v6.guiholder.AbsoluteSize.X <= 800 then
		v6.SmallScreen = -36;
		return;
	end;
	v6.SmallScreen = 0;
	v6.guiholder.MainBattle.Size = UDim2.new(0.8, 0, 0.8, 0);
	v6.guiholder.PartyUI.Size = UDim2.new(0.8, 0, 0.8, 0);
	v6.guiholder.ItemUI.Size = UDim2.new(0.8, 0, 0.8, 0);
end);
v6.Network:BindEvent("LoadLocation", function(p19, p20, p21, p22, p23)
	v6.StoryWeather = p22;
	v6.DataManager.Chunk.new(v6, p19, p20, true, nil, p23);
	v6.ClientDatabase:PDSEvent("Unanchor");
	_G.ActuallyReady = true;
	v6.Utilities.FastSpawn(function()
		v6.Steps:Start();
	end);
	if p21 then
		v6.WipeoutLocation = p21;
	end;
	print("Everything installed");
	v6.Loaded = true;
end);
v6.Network:BindEvent("LoadedData", function()
	_G.FirstReady = true;
end);
v6.Controls:SetupControls();
v6.Controls:ToggleWalk(false);
game.ReplicatedStorage.Installed:FireServer();
while true do
	v6.Utilities.Halt(0.05);
	if _G.FirstReady then
		break;
	end;
end;
v6.Overworld:Start();
v6.LoadingScreen:Start();
return true;
