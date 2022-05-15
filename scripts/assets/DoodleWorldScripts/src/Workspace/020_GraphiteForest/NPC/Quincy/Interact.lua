-- Decompiled with the Synapse X Luau decompiler.

return function(p1, p2)
	return {
		Dialogue = { {
				Talk = { {
						Talking = "Yo... how did you get here?"
					} }
			} }, 
		NPCId = "123456", 
		Name = "", 
		Idle = "Sitting", 
		NoRotate = true, 
		NoLook = true, 
		RunAtRunTime = function(p3, p4, p5)
			p5.Model.HumanoidRootPart.CFrame = p5.Model.HumanoidRootPart.CFrame - Vector3.new(0, 0.75, 0);
		end
	};
end;
