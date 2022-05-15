-- Decompiled with the Synapse X Luau decompiler.

return function(p1, p2)
	local v1 = {};
	local v2 = {};
	local v3 = {};
	local v4 = {};
	local u1 = false;
	local function u2(p3)
		local v5 = 0;
		for v6, v7 in pairs(p3.Parent:GetChildren()) do
			if v7:IsA("Model") and ((v7.Name == "Box" or v7.Name == "SupahBox") and v7.Part.BrickColor ~= BrickColor.new("Lime green")) then
				v5 = v5 + 1;
			end;
		end;
		return v5;
	end;
	v4[1] = function(p4)
		local v8 = nil;
		local v9 = nil;
		v8, v9 = p1:GetProgression();
		if v9 ~= "22" or v8["22"] ~= 3 then
			p1.Dialogue:SaySimple("This box is empty.");
			return;
		end;
		if v9 == "22" and v8["22"] == 3 then
			if p4.Name == "SupahBox" and u1 == false and not p1.Battle.RequestBattle and not p1.TrainerEncounter then
				u1 = true;
				p1.Sound:Play("ChildLaughter", math.random(80, 90) / 100, 1, {
					ReverbSoundEffect = {}, 
					DistortionSoundEffect = {}, 
					PitchShiftSoundEffect = {
						Octave = 1.5
					}
				});
				p1.Dialogue:SaySimple("This box is where that strange noise is coming from!");
				p1.Dialogue:SaySimple("You peek inside...");
				p1.Dialogue:SaySimple("It's a Doodle!");
				p1.Dialogue:SaySimple("The Doodle attacks you!");
				local v10, v11 = p1.Battle:WildBattle("GenericIndoors", "GlubbieSpecial");
				if v10:Wait() == true then
					p1.Music:PlaySong("SummersCircle");
					game.Lighting.Ambient = Color3.fromRGB(101, 111, 130);
					game.Lighting.Brightness = 1.01;
					p1.Dialogue:SaySimple("The Glubbie scurries away, leaving the house.");
					p1.Dialogue:SaySimple("Looks like it's time to tell Cassidy what happened. She should still be outside.");
					p1.ClientDatabase:PDSEvent("SetSwitch", "22", 4);
					u1 = false;
					return;
				else
					u1 = false;
					p1.Menu:Invisible();
					p1.Wipeout[v11].func();
					return;
				end;
			end;
			local v12 = math.random(1, 8);
			local v13 = u2(p4);
			if p4.Part.BrickColor ~= BrickColor.new("Lime green") then
				if v12 == 1 then
					p1.Dialogue:SaySimple("There's a creepy Skrappey toy in this box! It's junk, though. Boxes left: " .. v13 .. ".");
				elseif v12 == 2 then
					p1.Dialogue:SaySimple("Wow... there's something moving in this box!");
					p1.Dialogue:SaySimple("Just kidding. It's just lint. Boxes left: " .. v13 .. ".");
				elseif v12 == 3 then
					p1.Dialogue:SaySimple("Boo! Haha, just kidding. Boxes left: " .. v13 .. ".");
				elseif v12 == 4 then
					p1.Dialogue:SaySimple("...what's this? A voodoo doll of someone who looks very familiar... Boxes left: " .. v13 .. ".");
				else
					p1.Dialogue:SaySimple("There's nothing in this box. Boxes left: " .. v13 .. ".");
				end;
			end;
			p4.Part.BrickColor = BrickColor.new("Lime green");
		end;
	end;
	v3.Talk = v4;
	v2[1] = v3;
	v1.Dialogue = v2;
	v1.Name = "";
	v1.NPCId = 1;
	return v1;
end;
