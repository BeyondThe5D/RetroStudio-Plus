if game.PlaceId == 5846386835 then
	if game:IsLoaded() == false then
		game.Loaded:Wait()
	end
	
	wait()
	
	local Players = game:GetService("Players")
	local CoreGui = game:GetService("CoreGui")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")

	local Player = Players.LocalPlayer

	CoreGui:WaitForChild("ThemeProvider"):Destroy()
	CoreGui:WaitForChild("RobloxGui"):Destroy()

	local Logo = Player.PlayerGui:WaitForChild("MenuGui"):WaitForChild("Topbar"):WaitForChild("Upper"):WaitForChild("Logo")
	Logo.AnchorPoint = Vector2.new(0,0.5)
	Logo.Position = UDim2.new(0, 5, 0.5, 0)

	local UpperTabButtons = Player.PlayerGui.MenuGui.Topbar.Upper:WaitForChild("TabButtons")
	UpperTabButtons.Position = UDim2.new(0, 200, 0, 0)
	
	local LowerTabButtons = Player.PlayerGui.MenuGui.Topbar:WaitForChild("Lower"):WaitForChild("TabButtons")
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

	syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/BeyondThe5D/RetroStudio-Plus/main/Game%20Conversation.lua'))()")
end
