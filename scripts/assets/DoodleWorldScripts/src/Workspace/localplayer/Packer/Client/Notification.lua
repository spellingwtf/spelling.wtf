-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = {};
	p1.Network:BindEvent("Notification", function(p2)
		if p1.Settings and p1.Settings:Get("ShowNotifs") == true then
			p2 = p2;
			p1.Services.StarterGui:SetCore("SendNotification", p2);
		end;
	end);
	return {};
end;
