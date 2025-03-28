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

local cameraLockEnabled = false
local predictionValue = 0.5
local smoothness = 1
local trackingTarget = nil
local isTracking = false
local targetPart = "Head" -- Default target part

local function getTargetPosition(character)
    if character and character:FindFirstChild(targetPart) then
        return character[targetPart].Position
    elseif character and character:FindFirstChild("HumanoidRootPart") then
        return character.HumanoidRootPart.Position
    end
    return nil
end

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
    if cameraLockEnabled and isTracking and trackingTarget and trackingTarget.Character then
        local camera = workspace.CurrentCamera
        local localPlayer = game.Players.LocalPlayer
        local targetPosition = getTargetPosition(trackingTarget.Character)
        
        if camera and localPlayer.Character and targetPosition then
            local currentPosition = camera.CFrame.p
            local lerpFactor = math.clamp(smoothness * 0.05, 0.01, 0.1)
            local newPosition = currentPosition:Lerp(targetPosition, lerpFactor)
            camera.CFrame = CFrame.new(newPosition, targetPosition)
        end
    elseif cameraLockEnabled and not isTracking then
        local camera = workspace.CurrentCamera
        local targetPlayer = getNearestPlayer()
        local localPlayer = game.Players.LocalPlayer
        
        if camera and localPlayer.Character and targetPlayer and targetPlayer.Character then
            local targetPosition = getTargetPosition(targetPlayer.Character)
            if targetPosition then
                local currentPosition = camera.CFrame.p
                local lerpFactor = math.clamp(smoothness * 0.05, 0.01, 0.1)
                local newPosition = currentPosition:Lerp(targetPosition, lerpFactor)
                camera.CFrame = CFrame.new(newPosition, targetPosition)
            end
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(updateCameraLock)

game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
    isTracking = false
end)

local MainGroup = Tabs['Main']:AddLeftGroupbox('Camera Settings')

MainGroup:AddToggle('CameraLock', {
    Text = 'Enable Camera Lock',
    Default = false,
    Callback = function(value)
        cameraLockEnabled = value
    end
})

MainGroup:AddSlider('PredictionValue', {
    Text = 'Prediction',
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 3,
    Callback = function(value)
        predictionValue = value
    end
})

MainGroup:AddSlider('Smoothness', {
    Text = 'Smoothness',
    Default = 1,
    Min = 0.1,
    Max = 10,
    Rounding = 1,
    Callback = function(value)
        smoothness = value
    end
})

MainGroup:AddDropdown('TargetPartDropdown', {
    Values = {"Head", "Torso"},
    Default = "Head",
    Multi = false,
    Text = "Target Part",
    Callback = function(selected)
        targetPart = selected == "Torso" and "HumanoidRootPart" or "Head"
    end
})

game.Players.LocalPlayer.Character.Humanoid.HealthChanged:Connect(function(health)
    if health <= 0 then
        isTracking = false
    end
end)

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
