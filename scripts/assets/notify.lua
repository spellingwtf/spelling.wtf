local MainGui
if not is_sirhurt_closure and syn and syn.protect_gui then
    MainGui = Instance.new("ScreenGui")
    MainGui.DisplayOrder = 999
    syn.protect_gui(MainGui)
    MainGui.Parent = game:GetService("CoreGui")
elseif gethui then
    MainGui  = Instance.new("ScreenGui")
    MainGui.DisplayOrder = 999
    MainGui.Parent = gethui()
elseif game:GetService("CoreGui"):FindFirstChild('RobloxGui') then
    MainGui = CoreGui.RobloxGui
end

local NotificationWindow = Instance.new("Frame")
NotificationWindow.BackgroundTransparency = 1
NotificationWindow.Active = false
NotificationWindow.Size = UDim2.new(1, 0, 1, 0)
NotificationWindow.Name = "NotificationWindow"
NotificationWindow.Parent = MainGui
local NotificationSize = UDim2.new(0, 300, 0, 90)

local function bettertween(obj, newpos, dir, style, tim, override)
    coroutine.wrap(function()
        local frame = Instance.new("Frame")
        frame.Visible = false
        frame.Position = obj.Position
        frame.Parent = MainGui
        local connection = frame:GetPropertyChangedSignal("Position"):Connect(function()
            obj.Position = UDim2.new(obj.Position.X.Scale, obj.Position.X.Offset, frame.Position.Y.Scale, frame.Position.Y.Offset)
        end)
        frame:TweenPosition(newpos, dir, style, tim, override)
        frame.Parent = nil
        task.wait(tim)
        connection:Disconnect()
        frame:Destroy()
    end)()
end

local function bettertween2(obj, newpos, dir, style, tim, override)
    coroutine.wrap(function()
        local frame = Instance.new("Frame")
        frame.Visible = false
        frame.Position = obj.Position
        frame.Parent = MainGui
        local connection = frame:GetPropertyChangedSignal("Position"):Connect(function()
            obj.Position = UDim2.new(frame.Position.X.Scale, frame.Position.X.Offset, obj.Position.Y.Scale, obj.Position.Y.Offset)
        end)
        pcall(function()
            frame:TweenPosition(newpos, dir, style, tim, override)
        end)
        frame.Parent = nil
        task.wait(tim)
        connection:Disconnect()
        frame:Destroy()
    end)()
end

local function notify(title, text, showtime) 
    coroutine.wrap(function()
        local showtime = showtime or 1.5
        local title = title or "Notification"
        local text = text or "No text has been put here..."

        local offset = #NotificationWindow:GetChildren()
        local ToastNotification = Instance.new("Frame")
        local Topbar = Instance.new("Frame")
        local Title = Instance.new("TextLabel")
        local Text = Instance.new("TextLabel")
        ToastNotification.Name = "ToastNotification"
        ToastNotification.Parent = NotificationWindow
        ToastNotification.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        ToastNotification.BackgroundTransparency = 0.250
        ToastNotification.BorderSizePixel = 0
        ToastNotification.Position = UDim2.new(1, 0, 1, -((5 + NotificationSize.Y.Offset) * (offset + 1)))
        ToastNotification.Size = NotificationSize
        Topbar.Name = "Topbar"
        Topbar.Parent = ToastNotification
        Topbar.BackgroundColor3 = Color3.new(0, 255, 0)
        Topbar.BackgroundTransparency = 0.6
        Topbar.BorderSizePixel = 0
        Topbar.Size = UDim2.new(0, NotificationSize.X.Offset, 0, NotificationSize.Y.Offset/3.16)
        Title.Name = "Title"
        Title.Parent = Topbar
        Title.BackgroundTransparency = 1.000
        Title.Position = UDim2.new(0.0260000005, 0, 0, 0)
        Title.Size = UDim2.new(0, NotificationSize.X.Offset/1.16326531, 0, NotificationSize.Y.Offset/3.16)
        Title.Font = Enum.Font.GothamBold
        Title.Text = title
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextSize = 16.000
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Text.Name = "Text"
        Text.Parent = ToastNotification
        Text.BackgroundTransparency = 1.000
        Text.Position = UDim2.new(0.0260000005, 0, 0, Topbar.Size.Y.Offset + 5)
        Text.Size = UDim2.new(0, NotificationSize.X.Offset/1.14, 0, NotificationSize.Y.Offset/1.05333333)
        Text.Font = Enum.Font.GothamSemibold
        Text.Text = text
        Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text.TextSize = 16.000
        Text.TextWrapped = true
        Text.TextXAlignment = Enum.TextXAlignment.Left
        Text.TextYAlignment = Enum.TextYAlignment.Top

        bettertween2(ToastNotification, UDim2.new(1, -(NotificationSize.X.Offset + 5), 1, -((5 + NotificationSize.Y.Offset) * (offset + 1))), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.15, true)
        task.wait(0.15)
        Topbar:TweenSize(UDim2.new(0, 0, 0, NotificationSize.Y.Offset/3.16), Enum.EasingDirection.In, Enum.EasingStyle.Linear, showtime, true)
        task.wait(showtime)
        bettertween2(ToastNotification, UDim2.new(1, 0, 1, ToastNotification.Position.Y.Offset), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.15, true)
        task.wait(0.15)
        ToastNotification:Destroy()
    end)()
end

Connections.Notification = NotificationWindow.ChildRemoved:Connect(function()
    for i,v in pairs(NotificationWindow:GetChildren()) do
        bettertween(v, UDim2.new(1, v.Position.X.Offset, 1, -((5 + NotificationSize.Y.Offset) * (i - 1))), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.15, true)
    end
end)
