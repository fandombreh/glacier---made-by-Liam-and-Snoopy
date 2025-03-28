local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/liam675/skibidiliamgoat/refs/heads/main/imnotgoingnowhere", true))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/LionTheGreatRealFrFr/MobileLinoriaLib/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/LionTheGreatRealFrFr/MobileLinoriaLib/main/addons/SaveManager.lua"))()

if not Library then
    warn("[ERROR] Library failed to load!")
    return
end

local Window = Library:CreateWindow({
    Title = 'Glacier - Made By Liam And Snoopy',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Movement = Window:AddTab('Movement'),
    Visuals = Window:AddTab('Visuals'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

if not Tabs['UI Settings'] then
    warn("[ERROR] UI Settings tab is nil!")
    return
end

-- Camera lock functionality
local cameraLockEnabled = false
local predictionValue = 0.027
local smoothness = 1

local function updateCameraLock()
    if cameraLockEnabled then
        local camera = workspace.CurrentCamera
        local humanoidRootPart = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if camera and humanoidRootPart then
            local targetPosition = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * predictionValue
            local currentPosition = camera.CFrame.p
            local newPosition = currentPosition:Lerp(targetPosition, smoothness * 0.1)
            camera.CFrame = CFrame.new(newPosition, humanoidRootPart.Position)
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(updateCameraLock)

-- Adding the camera lock settings to the Main tab
local MainGroup = Tabs['Main']:AddLeftGroupbox('Camera Settings')

MainGroup:AddToggle('CameraLock', {
    Text = 'Enable Camera Lock',
    Default = false,
    Tooltip = 'Locks the camera in place.',
    Callback = function(value)
        cameraLockEnabled = value
    end
})

MainGroup:AddSlider('PredictionValue', {
    Text = 'Prediction',
    Default = 0.027,
    Min = 0,
    Max = 1,
    Rounding = 3,
    Tooltip = 'Adjust the prediction value.',
    Callback = function(value)
        predictionValue = value
    end
})

MainGroup:AddSlider('Smoothness', {
    Text = 'Smoothness',
    Default = 1,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Tooltip = 'Set the smoothness level for camera lock.',
    Callback = function(value)
        smoothness = value
    end
})

-- Restoring UI Settings tab functionality
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
ThemeManager:SetFolder('EuphoriaHub')
SaveManager:SetFolder('EuphoriaHub/configs')

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function()
    Library:Unload()
end)

MenuGroup:AddLabel('Menu Keybind')
MenuGroup:AddKeyPicker('MenuKeybind', {
    Default = 'End',
    NoUI = true,
    Text = 'Menu Keybind'
})

local ThemeGroup = Tabs['UI Settings']:AddLeftGroupbox('Themes')

ThemeGroup:AddButton('Save Theme', function()
    ThemeManager:SaveTheme()
end)

ThemeGroup:AddButton('Load Theme', function()
    ThemeManager:LoadTheme()
end)

ThemeManager:ApplyToTab(Tabs['UI Settings'])

Library.ToggleKeybind = Library.Options.MenuKeybind
Library:SetWatermarkVisibility(false)
Library.KeybindFrame.Visible = true
Library:OnUnload(function()
    Library.Unloaded = true
end)

print("[SUCCESS] UI Settings tab should now be working!")
