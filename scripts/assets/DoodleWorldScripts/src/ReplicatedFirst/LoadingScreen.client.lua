-- Decompiled with the Synapse X Luau decompiler.

local l__ReplicatedFirst__1 = game:GetService("ReplicatedFirst");
local l__PlayerGui__2 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
l__ReplicatedFirst__1:WaitForChild("Loading"):Clone().Parent = l__PlayerGui__2;
l__ReplicatedFirst__1:WaitForChild("Cinematic"):Clone().Parent = l__PlayerGui__2;
l__ReplicatedFirst__1:RemoveDefaultLoadingScreen();
