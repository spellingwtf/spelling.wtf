local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local Library = {}
Library.__index = Library
local total = 0
local ui = {
	tab = {},
	others = {},
	callback = {},
	sliders = {},
	labels = {},
	setting = {},
	setting_ui = {},
	setting_callback = {}
}
local frame, frame2, nowthing, setting

function getSize(text, size, font)
	local a = TextService:GetTextSize(text, size, font, Vector2.new(9e9, 9e9))
	return {
		x = a.x,
		y = a.y
	}
end

function update()
	local total_a = 0
	for i,v in next, ui.tab do
		v.Position = UDim2.new(0, 0, 0, 18 * (total_a + i))
		total_a += ui.others[i] and #ui.others[i] or 0
	end

	local total_b = 0
	for i,v in next, ui.others do
		for i2,v2 in next, v do
			v2.Position = UDim2.new(0, 15, 0, 18 * (total_b + i + 1))
			total_b += 1
		end
	end
end

function findInTableTable(t, n)
	for i,v in next, t do
		for i2, v2 in next, v do
			if v2 == n then
				return true, i, i2
			end
		end
	end
	return false
end

function Library:InitNew(name)
	local FOlder = game:GetService("RunService"):IsStudio() and game.Players.LocalPlayer.PlayerGui or game.CoreGui.RobloxGui
	
	if FOlder:FindFirstChild("?") then
		FOlder["?"]:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	
	local Frame_1 = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	local Setting = Instance.new("Frame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	
	ScreenGui.Name = "?"
	ScreenGui.Parent = game:GetService("RunService"):IsStudio() and game.Players.LocalPlayer.PlayerGui or game.CoreGui.RobloxGui
	ScreenGui.ResetOnSpawn = false
	ScreenGui.DisplayOrder = 9e9
	
	Frame.Name = "abc"
	Frame.Parent = ScreenGui
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.BackgroundTransparency = 1.000
	Frame.Position = UDim2.new(0, 30, 0, 30)
	Frame.Size = UDim2.new(1, 0, 1, 0)

	Title.Name = "!@#$%^&*)_**()^&*$##%&*^&*&*(*"
	Title.Parent = Frame
	Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Title.BorderSizePixel = 0
	Title.Size = UDim2.new(0, getSize(name, 15, Enum.Font.Code).x + 8, 0, 18)
	Title.Font = Enum.Font.Code
	Title.Text = name
	Title.TextColor3 = Color3.fromRGB(255, 85, 255)
	Title.TextSize = 15.000
	
	Frame_1.Name = "what"
	Frame_1.Parent = ScreenGui
	Frame_1.AnchorPoint = Vector2.new(1, 1)
	Frame_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame_1.BackgroundTransparency = 1.000
	Frame_1.Position = UDim2.new(1, 0, 1, -45)
	Frame_1.Size = UDim2.new(1, 0, 1, 0)

	UIListLayout.Parent = Frame_1
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.Padding = UDim.new(0, 4)
	
	Setting.Name = "Fern#5747"
	Setting.Parent = ScreenGui
	Setting.AnchorPoint = Vector2.new(0.5, 0.5)
	Setting.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	Setting.BackgroundTransparency = 1.000
	Setting.BorderColor3 = Color3.fromRGB(85, 0, 255)
	Setting.BorderSizePixel = 0
	Setting.Position = UDim2.new(0.5, 0, 0.5, 0)
	Setting.Size = UDim2.new(1, 0, 1, 0)
	Setting.Visible = false

	UIListLayout_2.Parent = Setting
	UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout_2.Padding = UDim.new(0, 4)
	
	setting = Setting
	frame2 = Frame_1
	frame = Frame
	
	return Library
end

local TabLibrary = {}
TabLibrary.__index = TabLibrary
local SettingLibrary = {}
SettingLibrary.__index = SettingLibrary
function Library:NewTab(name)
	local Tab = Instance.new("TextLabel")

	table.insert(ui.tab, Tab)
	total += 1
	
	Tab.Name = name
	Tab.Parent = frame
	Tab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Tab.BorderSizePixel = 0
	Tab.Size = UDim2.new(0, getSize(name, 15, Enum.Font.Code).x + 8, 0, 18)
	Tab.Font = Enum.Font.Code
	Tab.Text = name
	Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
	Tab.TextSize = 15
	
	if total == 1 then
		Tab.TextColor3 = Color3.fromRGB(255, 85, 255)
		nowthing = Tab
	end
	
	return setmetatable({
		frame = frame,
		pos = table.find(ui.tab, Tab),
		self = self,
		Tab = Tab
	}, TabLibrary)
end

function Library:SendNotification(text, color)
	local Frame_2 = Instance.new("Frame")
	local Frame_3 = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local Frame_4 = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local realtext = text:gsub("(\\?)<[^<>]->", { [''] = '' })

	Frame_2.Parent = frame2
	Frame_2.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_2.ClipsDescendants = true
	Frame_2.Size = UDim2.new(0, 0, 0, 22)

	Frame_3.Parent = Frame_2
	Frame_3.BackgroundColor3 = color and color or Color3.fromRGB(85, 0, 255)
	Frame_3.BorderSizePixel = 0
	Frame_3.Size = UDim2.new(0, 2, 1, 0)
	Frame_3.ZIndex = 2

	TextLabel.Parent = Frame_2
	TextLabel.AnchorPoint = Vector2.new(0, 0.5)
	TextLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(28, 28, 28)
	TextLabel.Position = UDim2.new(0, 5, 0.5, 0)
	TextLabel.Size = UDim2.new(0, getSize(realtext, 14, Enum.Font.Code).x + 8, 0, 18)
	TextLabel.ZIndex = 2
	TextLabel.Font = Enum.Font.Code
	TextLabel.RichText = true
	TextLabel.Text = text
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 14.000
	TextLabel.TextStrokeTransparency = 0.000

	Frame_4.Parent = TextLabel
	Frame_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame_4.Size = UDim2.new(1, 0, 1, 0)

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
	UIGradient.Rotation = 90
	UIGradient.Parent = Frame_4
	
	task.spawn(function()
		TweenService:Create(Frame_2, TweenInfo.new(0.5), {Size = UDim2.new(0, getSize(realtext, 14, Enum.Font.Code).x + 15, 0, 22)}):Play()
		wait(5.5)
		TweenService:Create(Frame_2, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 22)}):Play()
		wait(0.5)
		Frame_2:Destroy()
	end)
end

function TabLibrary:NewLabel(name)
	local Label = Instance.new("TextLabel")

	if not ui.others[self.pos] then
		ui.others[self.pos] = {}
	end
	table.insert(ui.others[self.pos], Label)
	table.insert(ui.labels, Label)
	total += 1

	Label.Name = name
	Label.Parent = self.frame
	Label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Label.BorderSizePixel = 0
	Label.Size = UDim2.new(0, getSize(name, 15, Enum.Font.Code).x + 8, 0, 18)
	Label.Font = Enum.Font.Code
	Label.Text = name
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.TextSize = 15

	update()
	
	return setmetatable({
		object = Label
	}, SettingLibrary)
end

function TabLibrary:NewButton(name, callback, default)
	local Button = Instance.new("TextLabel")

	if not ui.others[self.pos] then
		ui.others[self.pos] = {}
	end
	table.insert(ui.others[self.pos], Button)
	total += 1

	Button.Name = name
	Button.Parent = self.frame
	Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Button.BorderSizePixel = 0
	Button.Size = UDim2.new(0, getSize(name, 15, Enum.Font.Code).x + 8, 0, 18)
	Button.Font = Enum.Font.Code
	Button.Text = name
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.TextSize = 15

	callback = typeof(callback) == "function" and callback or function() end
	ui.callback[Button] = function()
		callback()
	end
	
	if default then
		callback()
	end

	update()
	
	return setmetatable({
		object = Button
	}, SettingLibrary)
end

function TabLibrary:NewToggle(name, callback, default)
	local Toggle = Instance.new("TextLabel")
	local text = name .. ": " .. (default and "on" or "off")
	local toggle = default or false
	
	if not ui.others[self.pos] then
		ui.others[self.pos] = {}
	end
	table.insert(ui.others[self.pos], Toggle)
	total += 1
	
	Toggle.Name = name
	Toggle.Parent = self.frame
	Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Toggle.BorderSizePixel = 0
	Toggle.Size = UDim2.new(0, getSize(text, 15, Enum.Font.Code).x + 8, 0, 18)
	Toggle.Font = Enum.Font.Code
	Toggle.Text = text
	Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.TextSize = 15
	
	callback = typeof(callback) == "function" and callback or function() end
	ui.callback[Toggle] = function()
		local m = text
		toggle = not toggle
		m = name .. ": " .. (toggle and "on" or "off")
		if rawget(ui.setting, Toggle) then
			m = "*" .. m
		end
		
		Toggle.Size = UDim2.new(0, getSize(m, 15, Enum.Font.Code).x + 8, 0, 18)
		Toggle.Text = m
		callback(toggle)
	end
	callback(toggle)
	
	update()
	
	return setmetatable({
		object = Toggle
	}, SettingLibrary)
end

function TabLibrary:NewSlider(name, callback, min, max, each, default)
	local Slider = Instance.new("TextLabel")
	local text = name .. " < " .. (default and default or 0) .. " > "
	local value = default or 0

	if not ui.others[self.pos] then
		ui.others[self.pos] = {}
	end
	table.insert(ui.others[self.pos], Slider)
	table.insert(ui.sliders, Slider)
	total += 1

	Slider.Name = name
	Slider.Parent = self.frame
	Slider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Slider.BorderSizePixel = 0
	Slider.Size = UDim2.new(0, getSize(text, 15, Enum.Font.Code).x + 8, 0, 18)
	Slider.Font = Enum.Font.Code
	Slider.Text = text
	Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
	Slider.TextSize = 15

	callback = typeof(callback) == "function" and callback or function() end
	ui.callback[Slider] = function(key)
		if key == "Left" then
			if value - each >= min then
				value = value - each
			end
		elseif key == "Right" then
			if value + each <= max then
				value += each
			end
		end
		local check = string.split(each, ".")[2]
		value = check and string.format("%.".. string.sub(check, 1) .."f", value) or value
		text = name .. " < " .. value .. " > "
		Slider.Size = UDim2.new(0, getSize(text, 15, Enum.Font.Code).x + 8, 0, 18)
		Slider.Text = text
		callback(value)
	end
	callback(value)

	update()

	return setmetatable({
		object = Slider
	}, SettingLibrary)
end

--// Setting
function setText(object)
	if not ui.setting[object] then
		ui.setting[object] = {}
		local text = object.Text
		text = "*" .. text

		object.Size = UDim2.new(0, getSize(text, 15, Enum.Font.Code).x + 8, 0, 18)
		object.Font = Enum.Font.Code
		object.Text = text
	end
end
function mkaeThing(object, thing, ...)
	local object = object

	setText(object)

	table.insert(ui.setting[object], {
		{...},
		type = thing,
		default = nil,
	})
end
function spawnSetting(object)	
	local Label = Instance.new("TextLabel")

	Label.Name = object.Name
	Label.Parent = setting
	Label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Label.BorderSizePixel = 0
	Label.Size = UDim2.new(0, getSize("[ " .. object.Name .. " ]", 15, Enum.Font.Code).x + 8, 0, 18)
	Label.Font = Enum.Font.Code
	Label.Text = "[ " .. object.Name .. " ]"
	Label.TextColor3 = Color3.fromRGB(255, 85, 255)
	Label.TextSize = 15
	
	for i,v in next, ui.setting[object] do
		if typeof(v) ~= "table" then continue end
		local args = v[1]
		local name = args[1]
		local callback = args[2]
		
		if v.type == "Toggle" then
			v.default = v.default ~= nil and v.default or args[3] or false
			local Toggle = Instance.new("TextLabel")
			local text = name .. ": " .. (v.default and "on" or "off")
			local toggle = (v.default and v.default) or false

			Toggle.Name = name
			Toggle.Parent = setting
			Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Size = UDim2.new(0, getSize(text, 15, Enum.Font.Code).x + 8, 0, 18)
			Toggle.Font = Enum.Font.Code
			Toggle.Text = text
			Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.TextSize = 15

			callback = typeof(callback) == "function" and callback or function() end
			ui.setting_callback[Toggle] = function()
				toggle = not toggle
				text = name .. ": " .. (toggle and "on" or "off")
				Toggle.Size = UDim2.new(0, getSize(text, 15, Enum.Font.Code).x + 8, 0, 18)
				Toggle.Text = text
				callback(toggle)
				ui.setting[object][i].default = toggle
			end
			callback(toggle)
			ui.setting[object][i].default = toggle
			
			table.insert(ui.setting_ui, Toggle)
			table.insert(ui.setting[object], Toggle)
		end
		
		if v.type == "Slider" then
			v.default = v.default ~= nil and v.default or args[6] or false
			local each = args[5]
			local max = args[4]
			local min = args[3]
			local Slider = Instance.new("TextLabel")
			local text = name .. " < " .. (v.default and v.default or 0) .. " > "
			local value = v.default or 0

			Slider.Name = name
			Slider.Parent = setting
			Slider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Slider.BorderSizePixel = 0
			Slider.Size = UDim2.new(0, getSize(text, 15, Enum.Font.Code).x + 8, 0, 18)
			Slider.Font = Enum.Font.Code
			Slider.Text = text
			Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
			Slider.TextSize = 15

			callback = typeof(callback) == "function" and callback or function() end
			ui.setting_callback[Slider] = function(key)
				if key == "Left" then
					if value - each >= min then
						value = value - each
					end
				elseif key == "Right" then
					if value + each <= max then
						value += each
					end
				end
				local check = string.split(each, ".")[2]
				value = check and string.format("%.".. string.sub(check, 1) .."f", value) or value
				text = name .. " < " .. value .. " > "
				Slider.Size = UDim2.new(0, getSize(text, 15, Enum.Font.Code).x + 8, 0, 18)
				Slider.Text = text
				callback(value)
				ui.setting[object][i].default = value
			end
			callback(value)
			ui.setting[object][i].default = value

			table.insert(ui.setting_ui, Slider)
			table.insert(ui.setting[object], Slider)
			table.insert(ui.sliders, Slider)
		end
	end
	setting.Visible = true
end
function clearSetting(object)
	for i,v in next, setting:GetChildren() do
		if v:IsA("TextLabel") then
			v:Destroy()
			if table.find(ui.setting[object], v) then
				table.remove(ui.setting[object], table.find(ui.setting[object], v))
			end
		end
	end
	ui.setting_ui = {}
	ui.setting_callback = {}
end

function SettingLibrary:NewToggle(...)
	local args = {...}
	if args[3] then
		args[2](args[3])
	end
	mkaeThing(self.object, "Toggle", ...)
end

function SettingLibrary:NewSlider(...)
	local args = {...}
	if args[6] then
		args[2](args[6])
	end
	mkaeThing(self.object, "Slider", ...)
end

local KeyCodes = {
	Enum.KeyCode.Left,
	Enum.KeyCode.Right,
	Enum.KeyCode.Up,
	Enum.KeyCode.Down,
	Enum.KeyCode.RightShift,
	Enum.KeyCode.Return,
	Enum.KeyCode.Backspace
}
UserInputService.InputBegan:Connect(function(input, a)
	if not table.find(KeyCodes, input.KeyCode) then return end
	if a and not input.KeyCode == Enum.KeyCode.Left and not input.KeyCode == Enum.KeyCode.Right then return end
	
	local Key = input.KeyCode
	local findInTab = table.find(ui.tab, nowthing)
	
	local function labelCheck(pos1, pos2, side)
		local findedUI
		local findTest = 0
		repeat
			if side == "up" then
				if pos2 - findTest > 0 then
					findTest += 1
				else
					pos2 = #ui.others[pos1]
					findTest = 0
				end
			else
				if pos2 + findTest <= #ui.others[pos1] then
					findTest += 1
				else
					pos2 = 1
					findTest = 0
				end
			end
			local uia = table.find(ui.labels, ui.others[pos1][side == "up" and (pos2 - findTest) or pos2 + findTest])
			if not uia then
				findedUI = ui.others[pos1][side == "up" and (pos2 - findTest) or pos2 + findTest]
			end
		until findedUI
		return findedUI
	end
	
	local function labelCheck2(t)
		if not t then return end
		for i,v in next, t do
			if not table.find(ui.labels, v) then
				return true
			end
		end
		return false
	end
	
	local function TabLabelCheck(pos, side)
		local findedUI
		local findTest = 0
		repeat
			if side == "up" then
				if pos - findTest > 0 then
					findTest += 1
				else
					pos = #ui.tab
					findTest = 0
				end
			else
				if pos + findTest <= #ui.tab then
					findTest += 1
				else
					pos = 1
					findTest = 0
				end
			end
			local uia = labelCheck2(ui.others[side == "up" and (pos - findTest) or pos + findTest])
			if uia then
				findedUI = ui.tab[side == "up" and (pos - findTest) or pos + findTest]
			end
		until findedUI
		return findedUI
	end
	
	local function Hold(callback)
		local loop = true
		local connect; connect = UserInputService.InputEnded:Connect(function(input)
			if input.KeyCode == Key then
				loop = false
				connect:Disconnect()
			end
		end)

		while loop do
			callback()
			wait(0.1)
		end
	end

	if Key == Enum.KeyCode.RightShift then
		frame.Visible = not frame.Visible
	end
	
	if not frame.Visible then
		return
	end
	
	if Key == Enum.KeyCode.Up then
		nowthing.TextColor3 = Color3.fromRGB(255, 255, 255)
		if findInTab then
			nowthing = TabLabelCheck(findInTab, "up")
		elseif table.find(ui.setting_ui, nowthing) then
			local pos = table.find(ui.setting_ui, nowthing)
			if pos - 1 > 0 then
				nowthing = ui.setting_ui[pos - 1]
			else
				nowthing = ui.setting_ui[#ui.setting_ui]
			end
		else
			local suc, pos1, pos2 = findInTableTable(ui.others, nowthing)
			nowthing = labelCheck(pos1, pos2, "up")
		end
		nowthing.TextColor3 = Color3.fromRGB(255, 85, 255)
	end
	
	if Key == Enum.KeyCode.Down then
		nowthing.TextColor3 = Color3.fromRGB(255, 255, 255)
		if findInTab then
			nowthing = TabLabelCheck(findInTab, "down")
		elseif table.find(ui.setting_ui, nowthing) then
			local pos = table.find(ui.setting_ui, nowthing)
			if pos + 1 <= #ui.setting_ui then
				nowthing = ui.setting_ui[pos + 1]
			else
				nowthing = ui.setting_ui[1]
			end
		else
			local suc, pos1, pos2 = findInTableTable(ui.others, nowthing)
			nowthing = labelCheck(pos1, pos2, "down")
		end
		nowthing.TextColor3 = Color3.fromRGB(255, 85, 255)
	end
	
	if Key == Enum.KeyCode.Right then
		if findInTab then
			local pos = findInTab
			if ui.others[pos] and #ui.others[pos] > 0 and labelCheck2(ui.others[pos]) then
				nowthing.TextColor3 = Color3.fromRGB(255, 255, 255)
				nowthing = labelCheck(pos, 0, "down")
				nowthing.TextColor3 = Color3.fromRGB(255, 85, 255)
			end
		elseif table.find(ui.setting_ui, nowthing) then
			Hold(function()
				rawget(ui.setting_callback, nowthing)("Right")
			end)
		else
			Hold(function()
				rawget(ui.callback, nowthing)("Right")
			end)
		end
	end
	
	if Key == Enum.KeyCode.Left then
		local suc, pos1, pos2 = findInTableTable(ui.others, nowthing)
		if table.find(ui.setting_ui, nowthing) then
			if not table.find(ui.sliders, nowthing) then
				local saved = nowthing
				nowthing.TextColor3 = Color3.fromRGB(255, 255, 255)
				nowthing = nil
				for i,v in next, ui.setting do
					if nowthing then continue end
					if table.find(v, saved) then
						nowthing = i
					end
				end
				nowthing.TextColor3 = Color3.fromRGB(255, 85, 255)
				clearSetting(nowthing)
			else
				Hold(function()
					rawget(ui.setting_callback, nowthing)("Left")
				end)
			end
		elseif not table.find(ui.sliders, nowthing) then
			if suc then
				nowthing.TextColor3 = Color3.fromRGB(255, 255, 255)
				nowthing = ui.tab[pos1]
				nowthing.TextColor3 = Color3.fromRGB(255, 85, 255)
			end
		else
			Hold(function()
				rawget(ui.callback, nowthing)("Left")
			end)
		end
	end
	
	if Key == Enum.KeyCode.Backspace then
		if table.find(ui.setting_ui, nowthing) then
			local saved = nowthing
			nowthing.TextColor3 = Color3.fromRGB(255, 255, 255)
			nowthing = nil
			for i,v in next, ui.setting do
				if nowthing then continue end
				if table.find(v, saved) then
					nowthing = i
				end
			end
			nowthing.TextColor3 = Color3.fromRGB(255, 85, 255)
			clearSetting(nowthing)
		end
	end
	
	if Key == Enum.KeyCode.Return then
		if rawget(ui.setting, nowthing) then
			nowthing.TextColor3 = Color3.fromRGB(255, 255, 255)
			spawnSetting(nowthing)
			nowthing = ui.setting_ui[1]
			nowthing.TextColor3 = Color3.fromRGB(255, 85, 255)
		end
	end
end)

return Library