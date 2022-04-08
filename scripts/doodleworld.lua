local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
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
        task.wait(1.5)
    until string.match(LocalPlayer.PlayerGui.MainGui.MainBattle.BottomBar.Say.Text, "^You r")
end
while true do task.wait()
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
    if LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.Shiny.Visible == true and getgenv().autofarm_settings.catch_when_shiny == true then
        print("found shiny doodle")
    elseif LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.TextColor3 ~= Color3.fromRGB(255,255,255) and getgenv().autofarm_settings.catch_when_skin == true then
        print("found skin")
    elseif LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.AlreadyCaught.Visible == false and getgenv().autofarm_settings.catch_when_havent_caught_before == true then
        print("found doodle that hasnt been caught before")
    elseif table.find(getgenv().autofarm_settings.specific_doodles, LocalPlayer.PlayerGui.MainGui.MainBattle.FrontBox.NameLabel.Text) and getgenv().autofarm_settings.catch_when_specific_doodle == true then
        print("found specific doodle")
    else
        run()
    end
    repeat
        task.wait()
    until LocalPlayer.PlayerGui.MainGui.MainBattle.Visible == false
    print("healing")
    Client.Network:post("PlayerData", "Heal")
end
