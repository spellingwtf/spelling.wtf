-- services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

--vars
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local ViewportSize = workspace.CurrentCamera.ViewportSize
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local Library = {}

function Library:validate(defaults, options)
	for i,v in pairs(defaults) do
		if options[i] == nil then
			options[i] = v
		end
	end
	return options
end

function Library:tween(object, goal, callback)
	local tween = TweenService:Create(object, tweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end
	
function Library:Init(options)
	options = Library:validate({
		name = "UI Library Test",
        size = UDim2.new(0, 400, 0, 300)
	}, options or {})	
	
	local GUI = {
		CurrentTab = nil
	}
	
	--Main Frame
	do
		-- StarterGui.ui
		GUI["1"] = Instance.new("ScreenGui", RunService:IsStudio() and Players.LocalPlayer:WaitForChild("PlayerGui") or CoreGui);
		GUI["1"]["IgnoreGuiInset"] = true;
		GUI["1"]["Name"] = [[ui]];

		-- StarterGui.ui.Main
		GUI["2"] = Instance.new("Frame", GUI["1"]);
		GUI["2"]["BorderSizePixel"] = 0;
		GUI["2"]["BackgroundColor3"] = Color3.fromRGB(49, 49, 49);
		GUI["2"]["AnchorPoint"] = Vector2.new(0, 0);
		GUI["2"]["Size"] = options.size;
		GUI["2"]["Position"] = UDim2.fromOffset((ViewportSize.X / 2) - (GUI["2"].Size.X.Offset / 2), (ViewportSize.Y / 2) - (GUI["2"].Size.Y.Offset / 2));
		GUI["2"]["Name"] = [[Main]];

		-- StarterGui.ui.Main.UICorner
		GUI["3"] = Instance.new("UICorner", GUI["2"]);
		GUI["3"]["CornerRadius"] = UDim.new(0, 6); 
		
		-- StarterGui.ui.Main.DropShadowHolder
		GUI["4"] = Instance.new("Frame", GUI["2"]);
		GUI["4"]["ZIndex"] = 0;
		GUI["4"]["BorderSizePixel"] = 0;
		GUI["4"]["BackgroundTransparency"] = 1;
		GUI["4"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["4"]["Name"] = [[DropShadowHolder]];

		-- StarterGui.ui.Main.DropShadowHolder.DropShadow
		GUI["5"] = Instance.new("ImageLabel", GUI["4"]);
		GUI["5"]["ZIndex"] = 0;
		GUI["5"]["BorderSizePixel"] = 0;
		GUI["5"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
		GUI["5"]["ScaleType"] = Enum.ScaleType.Slice;
		GUI["5"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["5"]["ImageTransparency"] = 0.5;
		GUI["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["5"]["Image"] = [[rbxassetid://6014261993]];
		GUI["5"]["Size"] = UDim2.new(1, 47, 1, 47);
		GUI["5"]["Name"] = [[DropShadow]];
		GUI["5"]["BackgroundTransparency"] = 1;
		GUI["5"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
		
		-- StarterGui.ui.Main.TopBar
		GUI["6"] = Instance.new("Frame", GUI["2"]);
		GUI["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["6"]["Size"] = UDim2.new(1, 0, 0, 30);
		GUI["6"]["Name"] = [[TopBar]];

		-- StarterGui.ui.Main.TopBar.UICorner
		GUI["7"] = Instance.new("UICorner", GUI["6"]);
		GUI["7"]["CornerRadius"] = UDim.new(0, 6);

		-- StarterGui.ui.Main.TopBar.Extension
		GUI["8"] = Instance.new("Frame", GUI["6"]);
		GUI["8"]["BorderSizePixel"] = 0;
		GUI["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["8"]["AnchorPoint"] = Vector2.new(0, 1);
		GUI["8"]["Size"] = UDim2.new(1, 0, 0.5, 0);
		GUI["8"]["Position"] = UDim2.new(0, 0, 1, 0);
		GUI["8"]["Name"] = [[Extension]];

		-- StarterGui.ui.Main.TopBar.Extension.UIGradient
		GUI["9"] = Instance.new("UIGradient", GUI["8"]);
		GUI["9"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(110, 42, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 0, 0))};

		-- StarterGui.ui.Main.TopBar.Title
		GUI["a"] = Instance.new("TextLabel", GUI["6"]);
		GUI["a"]["BorderSizePixel"] = 0;
		GUI["a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		GUI["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["a"]["TextSize"] = 14;
		GUI["a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["a"]["Size"] = UDim2.new(0.5, 0, 1, 0);
		GUI["a"]["Text"] = options["name"];
		GUI["a"]["Name"] = [[Title]];
		GUI["a"]["Font"] = Enum.Font.FredokaOne;
		GUI["a"]["BackgroundTransparency"] = 1;

		-- StarterGui.ui.Main.TopBar.Title.UIPadding
		GUI["b"] = Instance.new("UIPadding", GUI["a"]);
		GUI["b"]["PaddingTop"] = UDim.new(0, 1);
		GUI["b"]["PaddingLeft"] = UDim.new(0, 8);

		-- StarterGui.ui.Main.TopBar.Close
		GUI["c"] = Instance.new("ImageLabel", GUI["6"]);
		GUI["c"]["BorderSizePixel"] = 0;
		GUI["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["c"]["AnchorPoint"] = Vector2.new(1, 0.5);
		GUI["c"]["Image"] = [[rbxassetid://10950230015]];
		GUI["c"]["Size"] = UDim2.new(0, 18, 0, 18);
		GUI["c"]["Name"] = [[Close]];
		GUI["c"]["BackgroundTransparency"] = 1;
		GUI["c"]["Position"] = UDim2.new(1, -6, 0.5, 0);

		-- StarterGui.ui.Main.TopBar.UIGradient
		GUI["d"] = Instance.new("UIGradient", GUI["6"]);
		GUI["d"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(110, 42, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 0, 0))};

		-- StarterGui.ui.Main.TopBar.Line
		GUI["e"] = Instance.new("Frame", GUI["6"]);
		GUI["e"]["BorderSizePixel"] = 0;
		GUI["e"]["BackgroundColor3"] = Color3.fromRGB(82, 82, 82);
		GUI["e"]["AnchorPoint"] = Vector2.new(0, 1);
		GUI["e"]["Size"] = UDim2.new(1, 0, 0, 1);
		GUI["e"]["Position"] = UDim2.new(0, 0, 1, 0);
		GUI["e"]["Name"] = [[Line]];
		
		-- StarterGui.ui.Main.ContentContainer
		GUI["f"] = Instance.new("Frame", GUI["2"]);
		GUI["f"]["BorderSizePixel"] = 0;
		GUI["f"]["BackgroundColor3"] = Color3.fromRGB(55, 55, 55);
		GUI["f"]["AnchorPoint"] = Vector2.new(1, 0);
		GUI["f"]["BackgroundTransparency"] = 1;
		GUI["f"]["Size"] = UDim2.new(1, -133, 1, -42);
		GUI["f"]["Position"] = UDim2.new(1, -6, 0, 36);
		GUI["f"]["Name"] = [[ContentContainer]];
	end
		
	--Navigation
	do
		-- StarterGui.ui.Main.Navigation
		GUI["5b"] = Instance.new("Frame", GUI["2"]);
		GUI["5b"]["BorderSizePixel"] = 0;
		GUI["5b"]["BackgroundColor3"] = Color3.fromRGB(66, 66, 66);
		GUI["5b"]["Size"] = UDim2.new(0, 120, 1, -30);
		GUI["5b"]["Position"] = UDim2.new(0, 0, 0, 30);
		GUI["5b"]["Name"] = [[Navigation]];

		-- StarterGui.ui.Main.Navigation.UICorner
		GUI["5c"] = Instance.new("UICorner", GUI["5b"]);
		GUI["5c"]["CornerRadius"] = UDim.new(0, 6);

		-- StarterGui.ui.Main.Navigation.Hide
		GUI["5d"] = Instance.new("Frame", GUI["5b"]);
		GUI["5d"]["BorderSizePixel"] = 0;
		GUI["5d"]["BackgroundColor3"] = Color3.fromRGB(66, 66, 66);
		GUI["5d"]["Size"] = UDim2.new(1, 0, 0, 20);
		GUI["5d"]["Name"] = [[Hide]];

		-- StarterGui.ui.Main.Navigation.Hide2
		GUI["5e"] = Instance.new("Frame", GUI["5b"]);
		GUI["5e"]["BorderSizePixel"] = 0;
		GUI["5e"]["BackgroundColor3"] = Color3.fromRGB(66, 66, 66);
		GUI["5e"]["AnchorPoint"] = Vector2.new(1, 0);
		GUI["5e"]["Size"] = UDim2.new(0, 20, 1, 0);
		GUI["5e"]["Position"] = UDim2.new(1, 0, 0, 0);
		GUI["5e"]["Name"] = [[Hide2]];

		-- StarterGui.ui.Main.Navigation.ButtonHolder
		GUI["5f"] = Instance.new("Frame", GUI["5b"]);
		GUI["5f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["5f"]["BackgroundTransparency"] = 1;
		GUI["5f"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["5f"]["Name"] = [[ButtonHolder]];

		-- StarterGui.ui.Main.Navigation.ButtonHolder.UIPadding
		GUI["60"] = Instance.new("UIPadding", GUI["5f"]);
		GUI["60"]["PaddingTop"] = UDim.new(0, 8);
		GUI["60"]["PaddingBottom"] = UDim.new(0, 8);

		-- StarterGui.ui.Main.Navigation.ButtonHolder.UIListLayout
		GUI["61"] = Instance.new("UIListLayout", GUI["5f"]);
		GUI["61"]["Padding"] = UDim.new(0, 1);
		GUI["61"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
		
		-- StarterGui.ui.Main.Navigation.Line
		GUI["68"] = Instance.new("Frame", GUI["5b"]);
		GUI["68"]["BorderSizePixel"] = 0;
		GUI["68"]["BackgroundColor3"] = Color3.fromRGB(82, 82, 82);
		GUI["68"]["Size"] = UDim2.new(0, 1, 1, 0);
		GUI["68"]["Position"] = UDim2.new(1, 0, 0, 0);
		GUI["68"]["Name"] = [[Line]];
	end
	
	function GUI:Tab(options)
		options = Library:validate({
			name = "Preview Tab",
			icon = "rbxassetid://10950556704"
		}, options or {})
		
		local Tab = {
			Hover = false,
			Active = false
		}
		
		-- Render
		do
			-- StarterTab.ui.Main.Navigation.ButtonHolder.Inactive
			Tab["65"] = Instance.new("TextLabel", GUI["5f"]);
			Tab["65"]["BorderSizePixel"] = 0;
			Tab["65"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			Tab["65"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["65"]["TextSize"] = 12;
			Tab["65"]["TextColor3"] = Color3.fromRGB(200, 200, 200);
			Tab["65"]["Size"] = UDim2.new(1, 0, 0, 24);
			Tab["65"]["Text"] = options.name
			Tab["65"]["Name"] = [[Inactive]];
			Tab["65"]["Font"] = Enum.Font.FredokaOne;
			Tab["65"]["BackgroundTransparency"] = 1;

			-- StarterTab.ui.Main.Navigation.ButtonHolder.Inactive.UIPadding
			Tab["66"] = Instance.new("UIPadding", Tab["65"]);
			Tab["66"]["PaddingLeft"] = UDim.new(0, 28);

			-- StarterTab.ui.Main.Navigation.ButtonHolder.Inactive.Icon
			Tab["67"] = Instance.new("ImageLabel", Tab["65"]);
			Tab["67"]["BorderSizePixel"] = 0;
			Tab["67"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["67"]["ImageColor3"] = Color3.fromRGB(200, 200, 200);
			Tab["67"]["AnchorPoint"] = Vector2.new(0, 0.5);
			Tab["67"]["Image"] = options.icon;
			Tab["67"]["Size"] = UDim2.new(0, 20, 0, 20);
			Tab["67"]["Name"] = [[Icon]];
			Tab["67"]["BackgroundTransparency"] = 1;
			Tab["67"]["Position"] = UDim2.new(0, -24, 0.5, 0);
			
			-- StarterGui.ui.Main.ContentContainer.HomeTab
			Tab["10"] = Instance.new("ScrollingFrame", GUI["f"]);
			Tab["10"]["BorderSizePixel"] = 0;
			Tab["10"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["10"]["BackgroundTransparency"] = 1;
			Tab["10"]["Size"] = UDim2.new(1, 0, 1, 0);
			Tab["10"]["Selectable"] = false;
			Tab["10"]["ScrollBarThickness"] = 0;
			Tab["10"]["Name"] = [[HomeTab]];
			Tab["10"]["SelectionGroup"] = false;
			Tab["10"]["Visible"] = false;
			
			-- StarterGui.ui.Main.ContentContainer.HomeTab.UIPadding
			Tab["17"] = Instance.new("UIPadding", Tab["10"]);
			Tab["17"]["PaddingTop"] = UDim.new(0, 1);
			Tab["17"]["PaddingRight"] = UDim.new(0, 1);
			Tab["17"]["PaddingBottom"] = UDim.new(0, 1);
			Tab["17"]["PaddingLeft"] = UDim.new(0, 1);
			
			-- StarterGui.ui.Main.ContentContainer.HomeTab.UIListLayout
			GUI["18"] = Instance.new("UIListLayout", Tab["10"]);
			GUI["18"]["Padding"] = UDim.new(0, 6);
			GUI["18"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
		end
		
		-- Methods
		function Tab:Activate()
			if not Tab.Active then
				if GUI.CurrentTab ~= nil then
					GUI.CurrentTab:Deactivate()
				end
				
				Tab.Active = true
				Library:tween(Tab["65"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
				Library:tween(Tab["67"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
				Library:tween(Tab["65"], {BackgroundTransparency = 0.8})
				Tab["10"].Visible = true
				
				GUI.CurrentTab = Tab
			end
		end
				
		function Tab:Deactivate()
			if Tab.Active then
				Tab.Active = false
				Tab.Hover = false
				Library:tween(Tab["65"], {TextColor3 = Color3.fromRGB(200, 200, 200)})
				Library:tween(Tab["67"], {ImageColor3 = Color3.fromRGB(200, 200, 200)})
				Library:tween(Tab["65"], {BackgroundTransparency = 1})
				Tab["10"].Visible = false
			end
		end
		
		-- Logic
		do
			Tab["65"].MouseEnter:Connect(function()
				Tab.Hover = true

				if not Tab.Active then
					Library:tween(Tab["65"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
					Library:tween(Tab["67"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
				end
			end)

			Tab["65"].MouseLeave:Connect(function()
				Tab.Hover = false

				if not Tab.Active then
					Library:tween(Tab["65"], {TextColor3 = Color3.fromRGB(200, 200, 200)})
					Library:tween(Tab["67"], {ImageColor3 = Color3.fromRGB(200, 200, 200)})
				end
			end)

			UserInputService.InputBegan:Connect(function(input, gpe)
				if gpe then return end

				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if Tab.Hover == true then
						Tab:Activate()
					end
				end
			end)
			
			if GUI.CurrentTab == nil then
				Tab:Activate()
			end
		end
		
		function Tab:Button(options)
			options = Library:validate({
				name = "Preview Button",
				callback = function() end
			}, options or {})
			
			local Button = {
				Hover = false,
				MouseDown = false
			}
			
			-- Render
			do
				-- StarterGui.ui.Main.ContentContainer.HomeTab.Button
				Button["11"] = Instance.new("Frame", Tab["10"]);
				Button["11"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
				Button["11"]["Size"] = UDim2.new(1, 0, 0, 32);
				Button["11"]["Name"] = [[Button]];

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Button.UICorner
				Button["12"] = Instance.new("UICorner", Button["11"]);
				Button["12"]["CornerRadius"] = UDim.new(0, 4);

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Button.UIStroke
				Button["13"] = Instance.new("UIStroke", Button["11"]);
				Button["13"]["Color"] = Color3.fromRGB(82, 82, 82);
				Button["13"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Button.Title
				Button["14"] = Instance.new("TextLabel", Button["11"]);
				Button["14"]["BorderSizePixel"] = 0;
				Button["14"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Button["14"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Button["14"]["TextSize"] = 14;
				Button["14"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Button["14"]["Size"] = UDim2.new(1, -20, 1, 0);
				Button["14"]["Text"] = options.name;
				Button["14"]["Name"] = [[Title]];
				Button["14"]["Font"] = Enum.Font.FredokaOne;
				Button["14"]["BackgroundTransparency"] = 1;

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Button.UIPadding
				Button["15"] = Instance.new("UIPadding", Button["11"]);
				Button["15"]["PaddingTop"] = UDim.new(0, 6);
				Button["15"]["PaddingRight"] = UDim.new(0, 6);
				Button["15"]["PaddingBottom"] = UDim.new(0, 6);
				Button["15"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Button.Icon
				Button["16"] = Instance.new("ImageLabel", Button["11"]);
				Button["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Button["16"]["AnchorPoint"] = Vector2.new(1, 0);
				Button["16"]["Image"] = [[rbxassetid://10951601354]];
				Button["16"]["Size"] = UDim2.new(0, 20, 0, 20);
				Button["16"]["Name"] = [[Icon]];
				Button["16"]["BackgroundTransparency"] = 1;
				Button["16"]["Position"] = UDim2.new(1, 0, 0, 0);
			end
			
			-- Methods
			function Button:SetText(text)
				Button["14"].Text = text
				options.name = text
			end
			
			function Button:SetCallback(fn)
				options.callback = fn
			end
			
			-- Logic
			do
				Button["11"].MouseEnter:Connect(function()
					Button.Hover = true
					
					Library:tween(Button["13"], {Color = Color3.fromRGB(102, 102, 102)})
				end)	
				
				Button["11"].MouseLeave:Connect(function()
					Button.Hover = false
					
					if not Button.MouseDown then
						Library:tween(Button["13"], {Color = Color3.fromRGB(82, 82, 82)})
					end
				end)
				
				UserInputService.InputBegan:Connect(function(input, gpe)
					if gpe then return end
					
					if input.UserInputType == Enum.UserInputType.MouseButton1 and Button.Hover then
						Button.MouseDown = true
						Library:tween(Button["11"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Library:tween(Button["13"], {Color = Color3.fromRGB(200, 200, 200)})
						options.callback()
					end
				end)
				
				UserInputService.InputEnded:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Button.MouseDown = false
						
						if Button.Hover then
							Library:tween(Button["11"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Library:tween(Button["13"], {Color = Color3.fromRGB(102, 102, 102)})
						else
							Library:tween(Button["11"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Library:tween(Button["13"], {Color = Color3.fromRGB(82, 82, 82)})
						end
					end
				end)
			end
			
			return Button
		end
		
		function Tab:Warning(options)
			options = Library:validate({
				message = "Preview Warning",
			}, options or {})
			
			local Warning = {}
			
			-- Render
			do
				-- StarterGui.ui.Main.ContentContainer.HomeTab.Warning
				Warning["19"] = Instance.new("Frame", Tab["10"]);
				Warning["19"]["BackgroundColor3"] = Color3.fromRGB(44, 37, 4);
				Warning["19"]["Size"] = UDim2.new(1, 0, 0, 26);
				Warning["19"]["Name"] = [[Warning]];

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Warning.UICorner
				Warning["1a"] = Instance.new("UICorner", Warning["19"]);
				Warning["1a"]["CornerRadius"] = UDim.new(0, 4);

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Warning.UIStroke
				Warning["1b"] = Instance.new("UIStroke", Warning["19"]);
				Warning["1b"]["Color"] = Color3.fromRGB(166, 138, 12);
				Warning["1b"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
				
				-- StarterGui.ui.Main.ContentContainer.HomeTab.Warning.Title
				Warning["1c"] = Instance.new("TextLabel", Warning["19"]);
				Warning["1c"]["BorderSizePixel"] = 0;
				Warning["1c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Warning["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Warning["1c"]["TextSize"] = 14;
				Warning["1c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Warning["1c"]["Size"] = UDim2.new(1, 0, 1, 0);
				Warning["1c"]["Text"] = options.message;
				Warning["1c"]["Name"] = [[Title]];
				Warning["1c"]["Font"] = Enum.Font.FredokaOne;
				Warning["1c"]["BackgroundTransparency"] = 1;
				Warning["1c"]["TextWrapped"] = true
				Warning["1c"]["TextYAlignment"] = Enum.TextYAlignment.Top
				
				-- StarterGui.ui.Main.ContentContainer.HomeTab.Warning.UIPadding
				Warning["1d"] = Instance.new("UIPadding", Warning["19"]);
				Warning["1d"]["PaddingTop"] = UDim.new(0, 6);
				Warning["1d"]["PaddingRight"] = UDim.new(0, 6);
				Warning["1d"]["PaddingBottom"] = UDim.new(0, 6);
				Warning["1d"]["PaddingLeft"] = UDim.new(0, 32);
				
				-- StarterGui.ui.Main.ContentContainer.HomeTab.Warning.Icon
				Warning["1e"] = Instance.new("ImageLabel", Warning["19"]);
				Warning["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Warning["1e"]["ImageColor3"] = Color3.fromRGB(166, 138, 12);
				Warning["1e"]["Image"] = [[rbxassetid://10951979459]];
				Warning["1e"]["Size"] = UDim2.new(0, 20, 0, 20);
				Warning["1e"]["Name"] = [[Icon]];
				Warning["1e"]["BackgroundTransparency"] = 1;
				Warning["1e"]["Position"] = UDim2.new(0, -26, 0, -3);
			end
			
			-- Methods
			function Warning:SetText(text)
				options.message = text
				Warning:_update()
			end
			
			function Warning:_update()
				Warning["1c"].Text = options.message
				
				Warning["1c"].Size = UDim2.new(Warning["1c"].Size.X.Scale, Warning["1c"].Size.X.Offset, 0, math.huge)
				Warning["1c"].Size = UDim2.new(Warning["1c"].Size.X.Scale, Warning["1c"].Size.X.Offset, 0, Warning["1c"].TextBounds.Y)
				Library:tween(Warning["19"], {Size = UDim2.new(Warning["19"].Size.X.Scale, Warning["19"].Size.X.Offset, 0, Warning["1c"].TextBounds.Y + 12)})
			end
			
			Warning:_update()
			return Warning
		end
		
		function Tab:Toggle(options)
			options = Library:validate({
				title = "Preview Toggle",
				callback = function() end
			}, options or {})
			
			local Toggle = {
				Hover = false,
				MouseDown = false,
				State = false
			}
			
			-- Render
			do
				-- StarterGui.ui.Main.ContentContainer.HomeTab.ToggleInactive
				Toggle["47"] = Instance.new("Frame", Tab["10"]);
				Toggle["47"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
				Toggle["47"]["Size"] = UDim2.new(1, 0, 0, 32);
				Toggle["47"]["Name"] = [[ToggleInactive]];

				-- StarterGui.ui.Main.ContentContainer.HomeTab.ToggleInactive.UICorner
				Toggle["48"] = Instance.new("UICorner", Toggle["47"]);
				Toggle["48"]["CornerRadius"] = UDim.new(0, 4);

				-- StarterGui.ui.Main.ContentContainer.HomeTab.ToggleInactive.UIStroke
				Toggle["49"] = Instance.new("UIStroke", Toggle["47"]);
				Toggle["49"]["Color"] = Color3.fromRGB(82, 82, 82);
				Toggle["49"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

				-- StarterGui.ui.Main.ContentContainer.HomeTab.ToggleInactive.Title
				Toggle["4a"] = Instance.new("TextLabel", Toggle["47"]);
				Toggle["4a"]["BorderSizePixel"] = 0;
				Toggle["4a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Toggle["4a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Toggle["4a"]["TextSize"] = 14;
				Toggle["4a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Toggle["4a"]["Size"] = UDim2.new(1, -26, 1, 0);
				Toggle["4a"]["Text"] = options.title;
				Toggle["4a"]["Name"] = [[Title]];
				Toggle["4a"]["Font"] = Enum.Font.FredokaOne;
				Toggle["4a"]["BackgroundTransparency"] = 1;

				-- StarterGui.ui.Main.ContentContainer.HomeTab.ToggleInactive.UIPadding
				Toggle["4b"] = Instance.new("UIPadding", Toggle["47"]);
				Toggle["4b"]["PaddingTop"] = UDim.new(0, 6);
				Toggle["4b"]["PaddingRight"] = UDim.new(0, 6);
				Toggle["4b"]["PaddingBottom"] = UDim.new(0, 6);
				Toggle["4b"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.ui.Main.ContentContainer.HomeTab.ToggleInactive.CheckmarkHolder
				Toggle["4c"] = Instance.new("Frame", Toggle["47"]);
				Toggle["4c"]["BackgroundColor3"] = Color3.fromRGB(64, 64, 64);
				Toggle["4c"]["AnchorPoint"] = Vector2.new(1, 0.5);
				Toggle["4c"]["Size"] = UDim2.new(0, 16, 0, 16);
				Toggle["4c"]["Position"] = UDim2.new(1, -3, 0.5, 0);
				Toggle["4c"]["Name"] = [[CheckmarkHolder]];

				-- StarterGui.ui.Main.ContentContainer.HomeTab.ToggleInactive.CheckmarkHolder.UICorner
				Toggle["4d"] = Instance.new("UICorner", Toggle["4c"]);
				Toggle["4d"]["CornerRadius"] = UDim.new(0, 2);

				-- StarterGui.ui.Main.ContentContainer.HomeTab.ToggleInactive.CheckmarkHolder.UIStroke
				Toggle["4e"] = Instance.new("UIStroke", Toggle["4c"]);
				Toggle["4e"]["Color"] = Color3.fromRGB(82, 82, 82);
				Toggle["4e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

				-- StarterGui.ui.Main.ContentContainer.HomeTab.ToggleInactive.CheckmarkHolder.Checkmark
				Toggle["4f"] = Instance.new("ImageLabel", Toggle["4c"]);
				Toggle["4f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Toggle["4f"]["ImageTransparency"] = 1;
				Toggle["4f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Toggle["4f"]["Image"] = [[rbxassetid://10958472742]];
				Toggle["4f"]["Size"] = UDim2.new(1, -2, 1, -2);
				Toggle["4f"]["Name"] = [[Checkmark]];
				Toggle["4f"]["BackgroundTransparency"] = 1;
				Toggle["4f"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
			end
			
			-- Methods
			do
				function Toggle:Toggle(b)
					if b == nil then
						Toggle.State = not Toggle.State
					else
						Toggle.State = b
					end
					
					if Toggle.State == true then
						Library:tween(Toggle["4c"], {BackgroundColor3 = Color3.fromRGB(115, 191, 92)})
						Library:tween(Toggle["4f"], {ImageTransparency = 0})
					else
						Library:tween(Toggle["4c"], {BackgroundColor3 = Color3.fromRGB(64, 64, 64)})
						Library:tween(Toggle["4f"], {ImageTransparency = 1})
					end
					
					options.callback(Toggle.State)
				end
			end
			
			
			-- Logic
			do
				Toggle["47"].MouseEnter:Connect(function()
					Toggle.Hover = true

					Library:tween(Toggle["49"], {Color = Color3.fromRGB(102, 102, 102)})
				end)	

				Toggle["47"].MouseLeave:Connect(function()
					Toggle.Hover = false

					if not Toggle.MouseDown then
						Library:tween(Toggle["49"], {Color = Color3.fromRGB(82, 82, 82)})
					end
				end)

				UserInputService.InputBegan:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 and Toggle.Hover then
						Toggle.MouseDown = true
						Library:tween(Toggle["47"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Library:tween(Toggle["49"], {Color = Color3.fromRGB(200, 200, 200)})
						Toggle:Toggle()
					end
				end)

				UserInputService.InputEnded:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Toggle.MouseDown = false

						if Toggle.Hover then
							Library:tween(Toggle["47"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Library:tween(Toggle["49"], {Color = Color3.fromRGB(102, 102, 102)})
						else
							Library:tween(Toggle["47"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Library:tween(Toggle["49"], {Color = Color3.fromRGB(82, 82, 82)})
						end
					end
				end)
			end
			
			return Toggle
		end
		
		function Tab:Slider(options)
			options = Library:validate({
				title = "Preview Slider",
				min = 0,
				max = 100,
				default = 50,
				callback = function(v) print(v) end
			}, options or {})
			
			local Slider = {
				MouseDown = false,
				Hover = false,
				Connection = nil,
				Options = options
			}
			
			-- Render
			do
				-- StarterGui.ui.Main.ContentContainer.HomeTab.Slider
				Slider["2b"] = Instance.new("Frame", Tab["10"]);
				Slider["2b"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
				Slider["2b"]["Size"] = UDim2.new(1, 0, 0, 38);
				Slider["2b"]["Name"] = [[Slider]];

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Slider.UICorner
				Slider["2c"] = Instance.new("UICorner", Slider["2b"]);
				Slider["2c"]["CornerRadius"] = UDim.new(0, 4);

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Slider.UIStroke
				Slider["2d"] = Instance.new("UIStroke", Slider["2b"]);
				Slider["2d"]["Color"] = Color3.fromRGB(82, 82, 82);
				Slider["2d"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Slider.Title
				Slider["2e"] = Instance.new("TextLabel", Slider["2b"]);
				Slider["2e"]["BorderSizePixel"] = 0;
				Slider["2e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Slider["2e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["2e"]["TextSize"] = 14;
				Slider["2e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["2e"]["Size"] = UDim2.new(1, -24, 1, -10);
				Slider["2e"]["Text"] = options.title;
				Slider["2e"]["Name"] = [[Title]];
				Slider["2e"]["Font"] = Enum.Font.FredokaOne;
				Slider["2e"]["BackgroundTransparency"] = 1;

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Slider.UIPadding
				Slider["2f"] = Instance.new("UIPadding", Slider["2b"]);
				Slider["2f"]["PaddingTop"] = UDim.new(0, 6);
				Slider["2f"]["PaddingRight"] = UDim.new(0, 6);
				Slider["2f"]["PaddingBottom"] = UDim.new(0, 6);
				Slider["2f"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Slider.Value
				Slider["30"] = Instance.new("TextLabel", Slider["2b"]);
				Slider["30"]["BorderSizePixel"] = 0;
				Slider["30"]["TextXAlignment"] = Enum.TextXAlignment.Right;
				Slider["30"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["30"]["TextSize"] = 14;
				Slider["30"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["30"]["AnchorPoint"] = Vector2.new(1, 0);
				Slider["30"]["Size"] = UDim2.new(0, 24, 1, -10);
				Slider["30"]["Text"] = options.default;
				Slider["30"]["Name"] = [[Value]];
				Slider["30"]["Font"] = Enum.Font.FredokaOne;
				Slider["30"]["BackgroundTransparency"] = 1;
				Slider["30"]["Position"] = UDim2.new(1, 0, 0, 0);

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Slider.SliderBack
				Slider["31"] = Instance.new("Frame", Slider["2b"]);
				Slider["31"]["BackgroundColor3"] = Color3.fromRGB(13, 13, 13);
				Slider["31"]["AnchorPoint"] = Vector2.new(0, 1);
				Slider["31"]["Size"] = UDim2.new(1, 0, 0, 4);
				Slider["31"]["Position"] = UDim2.new(0, 0, 1, 0);
				Slider["31"]["Name"] = [[SliderBack]];

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Slider.SliderBack.UICorner
				Slider["32"] = Instance.new("UICorner", Slider["31"]);
				Slider["32"]["CornerRadius"] = UDim.new(0, 4);

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Slider.SliderBack.UIStroke
				Slider["33"] = Instance.new("UIStroke", Slider["31"]);
				Slider["33"]["Color"] = Color3.fromRGB(64, 64, 64);
				Slider["33"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Slider.SliderBack.Dragggable
				Slider["34"] = Instance.new("Frame", Slider["31"]);
				Slider["34"]["BackgroundColor3"] = Color3.fromRGB(57, 57, 57);
				Slider["34"]["Size"] = UDim2.new(0.5, 0, 1, 0);
				Slider["34"]["Name"] = [[Dragggable]];

				-- StarterGui.ui.Main.ContentContainer.HomeTab.Slider.SliderBack.Dragggable.UICorner
				Slider["35"] = Instance.new("UICorner", Slider["34"]);
				Slider["35"]["CornerRadius"] = UDim.new(0, 4);
			end
			
			-- Methods
			function Slider:SetValue(v)
				if v == nil then
					local percentage = math.clamp((Mouse.X - Slider["31"].AbsolutePosition.X) / (Slider["31"].AbsoluteSize.X), 0, 1)
					local value = math.floor(((options.max - options.min) * percentage) + options.min)
					
					Slider["30"].Text = value
					Slider["34"].Size = UDim2.fromScale(percentage, 1)
				else
					Slider["30"].Text = v
					Slider["34"].Size = UDim2.fromScale(((v - options.min) / (options.max - options.min)), 1)
				end
				options.callback(Slider:GetValue())
			end
			
			function Slider:GetValue()
				return tonumber(Slider["30"].Text)
			end
			
			-- Logic
			do
				Slider["2b"].MouseEnter:Connect(function()
					Slider.Hover = true

					Library:tween(Slider["2d"], {Color = Color3.fromRGB(102, 102, 102)})
					Library:tween(Slider["33"], {Color = Color3.fromRGB(102, 102, 102)})
					Library:tween(Slider["34"], {BackgroundColor3 = Color3.fromRGB(102, 102, 102)})
				end)	

				Slider["2b"].MouseLeave:Connect(function()
					Slider.Hover = false

					if not Slider.MouseDown then
						Library:tween(Slider["2d"], {Color = Color3.fromRGB(82, 82, 82)})
						Library:tween(Slider["33"], {Color = Color3.fromRGB(82, 82, 82)})
						Library:tween(Slider["34"], {BackgroundColor3 = Color3.fromRGB(82, 82, 82)})
					end
				end)

				UserInputService.InputBegan:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 and Slider.Hover then
						Slider.MouseDown = true
						Library:tween(Slider["2b"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Library:tween(Slider["2d"], {Color = Color3.fromRGB(200, 200, 200)})
						Library:tween(Slider["33"], {Color = Color3.fromRGB(200, 200, 200)})
						Library:tween(Slider["34"], {BackgroundColor3 = Color3.fromRGB(200, 200, 200)})
						
						if not Slider.Connection then
							Slider.Connection = RunService.RenderStepped:Connect(function()
								Slider:SetValue()
							end)
						end
					end
				end)

				UserInputService.InputEnded:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Slider.MouseDown = false

						if Slider.Hover then
							Library:tween(Slider["2b"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Library:tween(Slider["2d"], {Color = Color3.fromRGB(102, 102, 102)})
							Library:tween(Slider["33"], {Color = Color3.fromRGB(102, 102, 102)})
							Library:tween(Slider["34"], {BackgroundColor3 = Color3.fromRGB(102, 102, 102)})
						else
							Library:tween(Slider["2b"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Library:tween(Slider["2d"], {Color = Color3.fromRGB(82, 82, 82)})
							Library:tween(Slider["33"], {Color = Color3.fromRGB(82, 82, 82)})
							Library:tween(Slider["34"], {BackgroundColor3 = Color3.fromRGB(82, 82, 82)})
						end
						
						if Slider.Connection then Slider.Connection:Disconnect() end
						Slider.Connection = nil
					end
				end)
			end
			
			return Slider
		end
		
		return Tab
	end
	
	return GUI
end

return Library