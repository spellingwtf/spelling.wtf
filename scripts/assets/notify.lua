local Utilities = loadstring(game:HttpGet("https://spelling.wtf/scripts/assets/Utilities.lua"))()

local MainGui
if not is_sirhurt_closure and syn and syn.protect_gui then
    MainGui = Utilities.Create("ScreenGui")({
        DisplayOrder = 999
    })
    syn.protect_gui(MainGui)
    MainGui.Parent = game:GetService("CoreGui")
elseif gethui then
    MainGui = Utilities.Create("ScreenGui")({
        DisplayOrder = 999,
        Parent = gethui()
    })
elseif game:GetService("CoreGui"):FindFirstChild('RobloxGui') then
    MainGui = game:GetService("CoreGui").RobloxGui
end

local NotificationWindow = Utilities.Create("Frame")({
    BackgroundTransparency = 1,
    Active = false,
    Size = UDim2.fromScale(1, 1),
    Name = "NotificationWindow",
    Parent = MainGui
})
local NotificationSize = UDim2.new(0, 300, 0, 90)

local function bettertween(obj, newpos, dir, style, tim, override)
    coroutine.wrap(function()
        local frame = Utilities.Create("Frame")({
            Visible = false,
            Position = obj.Position,
            Parent = MainGui
        })
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
        local frame = Utilities.Create("Frame")({
            Visible = false,
            Position = obj.Position,
            Parent = MainGui
        })
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

local Notifications = {}

Notifications.Notify = function(title, text, showtime) 
    coroutine.wrap(function()
        local showtime = showtime or 1.5
        local title = title or "Notification"
        local text = text or "No text has been put here..."

        local offset = #NotificationWindow:GetChildren()
        local ToastNotification = Utilities.Create("Frame")({
            Name = "ToastNotification",
            Parent = NotificationWindow,
            BackgroundColor3 = Color3.fromRGB(10, 10, 10),
            BackgroundTransparency = 0.250,
            BorderSizePixel = 0,
            Position = UDim2.new(1, 0, 1, -((5 + NotificationSize.Y.Offset) * (offset + 1))),
            Size = NotificationSize
        })
        local Topbar = Utilities.Create("Frame")({
            Name = "Topbar",
            Parent = ToastNotification,
            BackgroundColor3 = Color3.new(0, 255, 0),
            BackgroundTransparency = 0.6,
            BorderSizePixel = 0,
            Size = UDim2.new(0, NotificationSize.X.Offset, 0, NotificationSize.Y.Offset/3.16)
        })
        local Title = Utilities.Create("TextLabel")({
            Name = "Title",
            Parent = Topbar,
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0.0260000005, 0, 0, 0),
            Size = UDim2.new(0, NotificationSize.X.Offset/1.16326531, 0, NotificationSize.Y.Offset/3.16),
            Font = Enum.Font.GothamBold,
            Text = title,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 16.000, 
            TextXAlignment = Enum.TextXAlignment.Left
        })
        local Text = Utilities.Create("TextLabel")({
            Name = "Text",
            Parent = ToastNotification,
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0.0260000005, 0, 0, Topbar.Size.Y.Offset + 5),
            Size = UDim2.new(0, NotificationSize.X.Offset/1.14, 0, NotificationSize.Y.Offset/1.05333333),
            Font = Enum.Font.GothamSemibold,
            Text = text,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 16.000,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top
        })

        bettertween2(ToastNotification, UDim2.new(1, -(NotificationSize.X.Offset + 5), 1, -((5 + NotificationSize.Y.Offset) * (offset + 1))), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.15, true)
        task.wait(0.15)
        Topbar:TweenSize(UDim2.new(0, 0, 0, NotificationSize.Y.Offset/3.16), Enum.EasingDirection.In, Enum.EasingStyle.Linear, showtime, true)
        task.wait(showtime)
        bettertween2(ToastNotification, UDim2.new(1, 0, 1, ToastNotification.Position.Y.Offset), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.15, true)
        task.wait(0.15)
        ToastNotification:Destroy()
    end)()
end

Notifications.NotificationConnection = NotificationWindow.ChildRemoved:Connect(function()
    for i,v in pairs(NotificationWindow:GetChildren()) do
        bettertween(v, UDim2.new(1, v.Position.X.Offset, 1, -((5 + NotificationSize.Y.Offset) * (i - 1))), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.15, true)
    end
end)

Notifications.Uninject = function()
    Notifications.NotificationConnection:Disconnect()
    MainGui:Destroy()
    Notifications.Notify = nil
    Notifications.Uninject = nil
end

return Notifications