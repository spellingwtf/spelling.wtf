-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	ReplicatedStorage = game:GetService("ReplicatedStorage"), 
	ReplicatedFirst = game:GetService("ReplicatedFirst"), 
	Lighting = game:GetService("Lighting"), 
	MarketplaceService = game:GetService("MarketplaceService"), 
	UIS = game:GetService("UserInputService"), 
	Players = game:GetService("Players"), 
	RunService = game:GetService("RunService"), 
	UserInputService = game:GetService("UserInputService"), 
	StarterGui = game:GetService("StarterGui")
};
v1.Storage = v1.ReplicatedStorage:WaitForChild("Storage");
v1.ContentProvider = game:GetService("ContentProvider");
if v1.RunService:IsClient() then
	return v1;
end;
v1.ServerStorage = game:GetService("ServerStorage");
return v1;
