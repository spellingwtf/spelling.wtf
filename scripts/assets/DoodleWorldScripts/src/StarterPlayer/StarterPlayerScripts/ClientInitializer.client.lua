-- Decompiled with the Synapse X Luau decompiler.

local l__StarterGui__1 = game:GetService("StarterGui");
l__StarterGui__1:SetCoreGuiEnabled(Enum.CoreGuiType.All, false);
l__StarterGui__1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
local l__RUN__2 = game.ReplicatedStorage.RUN;
local v3 = l__RUN__2:InvokeServer();
v3.Parent = game.Players.LocalPlayer;
local v4 = require(v3);
l__RUN__2:Destroy();
game:GetService("RunService").Heartbeat:wait();
script:Destroy();
