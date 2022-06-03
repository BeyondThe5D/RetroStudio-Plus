if game:IsLoaded() == false then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

CoreGui:WaitForChild("ThemeProvider"):Destroy()
CoreGui:WaitForChild("RobloxGui"):Destroy()

Player.PlayerGui:WaitForChild("MenuGui").GamesPageFrame.Visible = false
Player.PlayerGui.MenuGui.HomePageFrame.Visible = true
Player.PlayerGui.MenuGui.Topbar.Upper.TabButtons.HomeButton.BackgroundTransparency = 0.8
Player.PlayerGui.MenuGui.Topbar.Upper.TabButtons.GamesButton.BackgroundTransparency = 1

local Logo = Player.PlayerGui.MenuGui.Topbar.Upper.Logo
Logo.AnchorPoint = Vector2.new(0,0.5)
Logo.Position = UDim2.new(0, 5, 0.5, 0)

local UpperTabButtons = Player.PlayerGui.MenuGui.Topbar.Upper.TabButtons
UpperTabButtons.Position = UDim2.new(0, 200, 0, 0)
local LowerTabButtons = Player.PlayerGui.MenuGui.Topbar.Lower.TabButtons
LowerTabButtons.Position = UDim2.new(0, 200, 0, 0)

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	RunService.Heartbeat:Wait()
	UpperTabButtons.Position = UDim2.new(0, 200, 0, 0)
	LowerTabButtons.Position = UDim2.new(0, 200, 0, 0)
end)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Escape then
		game:Shutdown()
	end
end)
