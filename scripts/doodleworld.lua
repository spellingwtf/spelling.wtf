local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")
local Client = require(LocalPlayer.Packer.Client)
local CurrentRoute
for i,v in pairs(workspace:GetChildren()) do
    if v:IsA("Model") and string.find(v.Name, "_") and v ~= LocalPlayer.Character then
        CurrentRoute = v
    end
end
local function run()
    repeat
        repeat task.wait() until getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Run.MouseButton1Click)[1] ~= nil
        getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Run.MouseButton1Click)[1]:Fire()
        print("ran")
        task.wait(2)
    until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^You r")
end
local function catch()
    repeat task.wait() until LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Visible == true
    local bagbutton = game.Players.LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Items
    VirtualInputManager:SendMouseMoveEvent(bagbutton.AbsolutePosition.X + bagbutton.AbsoluteSize.X / 2, bagbutton.AbsolutePosition.Y + bagbutton.AbsoluteSize.Y / 2, bagbutton)
    VirtualInputManager:SendMouseButtonEvent(bagbutton.AbsolutePosition.X + bagbutton.AbsoluteSize.X / 2, bagbutton.AbsolutePosition.Y + bagbutton.AbsoluteSize.Y / 2, 1, false, bagbutton, 1)
end
local function kill()
    local noteffectivemoves = {}
    local foundeffective = false
    repeat
        repeat
            task.wait()
            if string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The wild "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted") then return end
        until getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Fight.MouseButton1Click)[1] ~= nil
        for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
            getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Fight.MouseButton1Click)[1]:Fire()
            if v.Effective.Visible == true and tonumber(string.split(v.Uses.Text, "/")[1]) ~= 0 and tonumber(string.split(v.Uses.Text, "/")[1]) <= tonumber(string.split(v.Uses.Text, "/")[2]) and v.Effective.Image ~= 4597964542 and v.Effective.Image ~= 4597964185 then
                getconnections(v.MouseButton1Click)[1]:Fire()
                foundeffective = true
                break
            elseif v.Effective.Visible == false and tonumber(string.split(v.Uses.Text, "/")[1]) ~= 0 and tonumber(string.split(v.Uses.Text, "/")[1]) <= tonumber(string.split(v.Uses.Text, "/")[2]) then
                repeat task.wait() until LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Visible == true
                getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Switch.MouseButton1Click)[1]:Fire()
                repeat task.wait() until LocalPlayer.PlayerGui.MainGui.PartyUI.Visible == true
                getconnections(LocalPlayer.PlayerGui.MainGui.PartyUI.Party1.Activated)[1]:Fire()
                repeat task.wait() until LocalPlayer.PlayerGui.MainGui:FindFirstChild("PartyChoice")
                getconnections(LocalPlayer.PlayerGui.MainGui.PartyChoice.Stats.MouseButton1Click)[1]:Fire()
                repeat task.wait() until LocalPlayer.PlayerGui.MainGui.Stats.Visible == true
                getconnections(LocalPlayer.PlayerGui.MainGui.Stats.Tabs.Moves.MouseButton1Click)[1]:Fire()
                repeat task.wait() until LocalPlayer.PlayerGui.MainGui.Stats.PaperFront.Moves.Visible == true
                local movebutton
                for i2,v2 in pairs(LocalPlayer.PlayerGui.MainGui.Stats.PaperFront.Moves.Holder:GetChildren()) do
                    if v2:IsA("ImageButton") and v2:FindFirstChild("MoveName") and v2.MoveName.Text == v.MoveName.Text then
                        movebutton = v2
                        break
                    end
                end
                repeat
                    task.wait()
                    VirtualInputManager:SendMouseMoveEvent(movebutton.AbsolutePosition.X + movebutton.AbsoluteSize.X / 2, movebutton.AbsolutePosition.Y + movebutton.AbsoluteSize.Y / 2, movebutton)
                until LocalPlayer.PlayerGui.MainGui.Stats.PaperFront.Moves.MoveDescription.MoveName.Label.Text == v.MoveName.Text
                local movepower = LocalPlayer.PlayerGui.MainGui.Stats.PaperFront.Moves.MoveDescription.StatHolder.Power.Desc.Label.Text
                if movepower == "--" or movepower == "Varies" then movepower = 0 end
                movepower = tonumber(movepower)
                local movename = LocalPlayer.PlayerGui.MainGui.Stats.PaperFront.Moves.MoveDescription.MoveName.Label.Text
                noteffectivemoves[movename] = movepower
                getconnections(LocalPlayer.PlayerGui.MainGui.Stats.Close.MouseButton1Click)[1]:Fire()
                getconnections(LocalPlayer.PlayerGui.MainGui.PartyUI.CloseBar.Cancel.MouseButton1Click)[1]:Fire()
            end
        end
        if foundeffective == false then
            local strongestmove 
            local num = 0
            for i,v in pairs(noteffectivemoves) do
                if v > num then
                    num = v
                    strongestmove = i
                end
            end
            getconnections(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Actions.Fight.MouseButton1Click)[1]:Fire()
            for i,v in pairs(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Moves:GetChildren()) do
                if v.MoveName.Text == strongestmove then
                    getconnections(v.MouseButton1Click)[1]:Fire()
                    break
                end
            end
        end
        print("attacked")
    until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "The wild "..LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text.." fainted")
end
while getgenv().autofarm_settings.enabled == true do task.wait()
    print("healing")
    Client.Network:post("PlayerData", "Heal")
    print("starting battle")
    if CurrentRoute.Name == "007_Lakewood" then
        Client.Network:post("RequestWild", CurrentRoute.Name, "Lake")
    elseif CurrentRoute.Name == "011_Sewer" then
        Client.Network:post("RequestWild", "011_RealSewer", "Sewer")
    else
        Client.Network:post("RequestWild", CurrentRoute.Name, "WildGrass")
    end
    repeat task.wait() until LocalPlayer.PlayerGui.MainGui.MainBattle.Visible == true
    task.wait(1)
    if LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.Shiny.Visible == true then
        print("found shiny doodle")
        if getgenv().autofarm_settings.kill_when_shiny == true or getgenv().autofarm_settings.kill_all == true then
            kill()
        end
    elseif tostring(LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.UIGradient.Color.Keypoints[1]) ~= "0 1 1 1 0 " then
        print("found skin")
        if getgenv().autofarm_settings.kill_when_skin == true or getgenv().autofarm_settings.kill_all == true then
            kill()
        end
    elseif LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.AlreadyCaught.Visible == false then
        print("found doodle that hasnt been caught before")
        if getgenv().autofarm_settings.kill_when_havent_caught_before == true or getgenv().autofarm_settings.kill_all == true then
            kill()
        end
    elseif table.find(getgenv().autofarm_settings.specific_doodles, LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text) then
        print("found specific doodle")
        if getgenv().autofarm_settings.kill_when_specific_doodle == true or getgenv().autofarm_settings.kill_all == true then
            kill()
        end
    else
        if getgenv().autofarm_settings.kill_all == true then
            kill()
        else
            run()
        end
    end
    repeat
        task.wait()
    until LocalPlayer.PlayerGui.MainGui.MainBattle.Visible == false
end
