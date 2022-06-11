if game:IsLoaded() == false then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local Rendering = settings().Rendering
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local function SimulateOutlines()
	local function UpdateOutline(object)
		if object:IsA("Part")
			and object.Shape == Enum.PartType.Block
			and not object.Parent:FindFirstChildOfClass("Humanoid")
			and not object:FindFirstChildWhichIsA("DataModelMesh") or (object:FindFirstChildWhichIsA("BlockMesh") and object:FindFirstChildWhichIsA("BlockMesh").Scale == Vector3.new(1, 1, 1)
			and object:FindFirstChildWhichIsA("BlockMesh").Offset == Vector3.new(0, 0, 0))
		then
			local Outline = Instance.new("SelectionBox")
			Outline.Name = "Outline"
			Outline.Color3 = Color3.fromRGB(36, 36, 36)
			Outline.LineThickness = 0.001
			if Outline.SurfaceColor3.R ~= Outline.SurfaceColor3.G then
				local RandomValue = math.random(255)
				Outline.SurfaceColor3 = Color3.fromRGB(RandomValue, RandomValue, RandomValue)
			end
			Outline.SurfaceTransparency = 0.975+(Outline.Transparency/4)
			Outline.Transparency = 0.8+(object.Transparency/5)
			Outline.Adornee = object
			Outline.Parent = object

			object:GetPropertyChangedSignal("Transparency"):Connect(function()
				Outline.SurfaceTransparency = 0.975+(Outline.Transparency/4)
				Outline.Transparency = 0.8+(object.Transparency/5)
			end)
		end
	end

	for _, objects in pairs(workspace:GetDescendants()) do
		UpdateOutline(objects)
	end

	workspace.DescendantAdded:Connect(function(object)
		spawn(function()
			RunService.RenderStepped:Wait()
			UpdateOutline(object)
		end)
	end)
end

local function SimulateHRPSoundRemoval()
	local function RemoveHumanoidRootPartSounds(character)
		for _, sounds in pairs(character:WaitForChild("HumanoidRootPart"):GetChildren()) do
			if sounds:IsA("Sound") then
				sounds:Destroy()
			end
		end
	end

	RemoveHumanoidRootPartSounds(Character)

	Player.CharacterAdded:Connect(function(character)
		RemoveHumanoidRootPartSounds(character)
	end)
end

local function SimulateOldConsole()
	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.F9 then
			keypress(0x77)
		end
	end)

	CoreGui.ChildAdded:Connect(function(object)
		if object.Name == "DevConsoleMaster" then
			RunService.RenderStepped:Wait()
			object:Destroy()
		end
	end)
end

local function SimulateOldSliders(autographics,gamesettings)
	local GraphicsLevel = 16

	local QualityAutoCheckBox = autographics

	QualityAutoCheckBox.Changed:Connect(function(property)
		if QualityAutoCheckBox.Text == "X" then
			Rendering.QualityLevel = Enum.QualityLevel.Automatic
		else
			Rendering.QualityLevel = "Level" .. string.format("%0.2i", GraphicsLevel)
		end
	end)

	for _,buttons in pairs(gamesettings:GetChildren()) do
		if buttons:FindFirstChild("SliderSteps") then
			if buttons.SliderSteps.Value == 10 then
				buttons.SliderPosition.Changed:Connect(function(graphicslevel)
					GraphicsLevel = math.floor(1.6 * graphicslevel)
					Rendering.QualityLevel = "Level" .. string.format("%0.2i", GraphicsLevel)
				end)
			end

			if buttons.SliderSteps.Value == 256 then
				buttons.SliderPosition.Value = UserGameSettings.MasterVolume * 256
				buttons.SliderPosition.Changed:Connect(function(volumelevel)
					UserGameSettings.MasterVolume = (volumelevel - 1) / 255
				end)
			end
		end
	end

	Rendering.QualityLevel = Enum.QualityLevel.Level16
end

CoreGui:WaitForChild("ThemeProvider"):Destroy()
CoreGui:WaitForChild("RobloxGui"):Destroy()

local Years = {
	[199] = function()
		Player.PlayerGui:WaitForChild("RobloxGui"):WaitForChild("TopBarContainer").Position = UDim2.new(0, -48, 0, -36)
		Player.PlayerGui.RobloxGui.TopBarContainer.Size = UDim2.new(1, 48, 0, 36)

		if Player.PlayerGui.RobloxGui:FindFirstChild("ChatWindowContainer") then
			local ChatWindowContainer = Player.PlayerGui.RobloxGui.ChatWindowContainer
			ChatWindowContainer.Position = UDim2.new(0, 0, 0, 2)
			ChatWindowContainer.Size = UDim2.new(0.3, 0, 0.25, -2)
			ChatWindowContainer.Changed:Connect(function()
				ChatWindowContainer.Position = UDim2.new(0, 0, 0, 2)
			end)
		end

		if Player.PlayerGui.RobloxGui:FindFirstChild("ChatBarContainer") then
			Player.PlayerGui.RobloxGui.ChatBarContainer.Position = UDim2.new(0, 0, 0.215, 37)
		end

		Player.PlayerGui.RobloxGui:WaitForChild("SettingsMenu"):WaitForChild("SettingsShield"):WaitForChild("SettingClipFrame"):WaitForChild("RootMenuFrame"):WaitForChild("ScreenshotButton").MouseButton1Down:Connect(function()
			CoreGui:TakeScreenshot()
		end)

		Player.PlayerGui.RobloxGui.SettingsMenu.SettingsShield.SettingClipFrame.RootMenuFrame:WaitForChild("RecordVideoButton").MouseButton1Down:Connect(function()
			CoreGui:ToggleRecording()
		end)

		Player.PlayerGui.RobloxGui.SettingsMenu.SettingsShield.SettingClipFrame:WaitForChild("GameSettingsMenuFrame"):WaitForChild("FullScreenTextCheckBox").MouseButton1Down:Connect(function()
			GuiService:ToggleFullscreen()
		end)

		SimulateOldSliders(Player.PlayerGui.RobloxGui.SettingsMenu.SettingsShield.SettingClipFrame:WaitForChild("GameSettingsMenuFrame"):WaitForChild("QualityAutoCheckBox"),Player.PlayerGui.RobloxGui.SettingsMenu.SettingsShield.SettingClipFrame.GameSettingsMenuFrame)
		SimulateOldConsole()
		SimulateOutlines()
		SimulateHRPSoundRemoval()
	end,
	[185] = function() -- Unsure if accurate

		Player.PlayerGui:WaitForChild("RobloxGui"):WaitForChild("ControlFrame"):WaitForChild("UserSettingsShield"):WaitForChild("Settings"):WaitForChild("SettingsStyle"):WaitForChild("GameMainMenu"):WaitForChild("ScreenshotButton").MouseButton1Down:Connect(function()
			CoreGui:TakeScreenshot()
		end)

		Player.PlayerGui.RobloxGui.ControlFrame.UserSettingsShield.Settings.SettingsStyle.GameMainMenu:WaitForChild("RecordVideoButton").MouseButton1Down:Connect(function()
			CoreGui:ToggleRecording()
		end)

		Player.PlayerGui.RobloxGui.ControlFrame.UserSettingsShield.Settings.SettingsStyle:WaitForChild("GameSettingsMenu"):WaitForChild("FullscreenCheckbox").MouseButton1Down:Connect(function()
			GuiService:ToggleFullscreen()
		end)

		SimulateOldSliders(Player.PlayerGui.RobloxGui.ControlFrame.UserSettingsShield.Settings.SettingsStyle.GameSettingsMenu:WaitForChild("AutoGraphicsButton"),Player.PlayerGui.RobloxGui.ControlFrame.UserSettingsShield.Settings.SettingsStyle.GameSettingsMenu)
		SimulateOldConsole()
		SimulateOutlines()
		SimulateHRPSoundRemoval()
	end,
}

Years[ReplicatedStorage.RobloxVersion.Value]()

if Player.UserId == 2601528367 then
	Character:WaitForChild("Head"):WaitForChild("face"):Destroy()
	Player.CharacterAdded:Connect(function(character)
		character:WaitForChild("Head"):WaitForChild("face"):Destroy()
	end)
end
