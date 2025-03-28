local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/liam675/skibidiliamgoat/refs/heads/main/imnotgoingnowhere", true))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/LionTheGreatRealFrFr/MobileLinoriaLib/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/LionTheGreatRealFrFr/MobileLinoriaLib/main/addons/SaveManager.lua"))()

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

-- Camera lock functionality
local cameraLockEnabled = false
local predictionValue = 0.027
local smoothness = 1

local function getNearestPlayer()
    local localPlayer = game.Players.LocalPlayer
    local nearestPlayer = nil
    local shortestDistance = math.huge

    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end

    return nearestPlayer
end

local function updateCameraLock()
    if cameraLockEnabled then
        local camera = workspace.CurrentCamera
        local localPlayer = game.Players.LocalPlayer
        local targetPlayer = getNearestPlayer()

        if camera and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = targetPlayer.Character.HumanoidRootPart.Position + targetPlayer.Character.HumanoidRootPart.CFrame.LookVector * predictionValue
            local currentPosition = camera.CFrame.p
            local newPosition = currentPosition:Lerp(targetPosition, smoothness * 0.05) -- Adjusted smoothness multiplier
            camera.CFrame = CFrame.new(newPosition, targetPlayer.Character.HumanoidRootPart.Position)
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(updateCameraLock)

-- Adding the camera lock settings to the Main tab
local MainGroup = Tabs['Main']:AddLeftGroupbox('Camera Settings')

MainGroup:AddToggle('CameraLock', {
    Text = 'Enable Camera Lock',
    Default = false,
    Tooltip = 'Locks the camera onto the nearest player.',
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
    Min = 0.1, -- changed min to 0.1 to avoid divide by zero or other issues.
    Max = 10,
    Rounding = 1,
    Tooltip = 'Adjust the smoothness level for camera lock.',
    Callback = function(value)
        smoothness = value
    end
})

-- UI Settings tab setup
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
ThemeManager:ApplyToTab(Tabs['UI Settings'])

Library.ToggleKeybind = Library.Options.MenuKeybind

Library:SetWatermarkVisibility(false)

Library.KeybindFrame.Visible = true
Library:OnUnload(function()
    Library.Unloaded = true
end)

print("[SUCCESS] UI Settings tab should now be working!")
