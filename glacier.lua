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

-- Camera Lock Variables
local cameraLockEnabled = false
local predictionValue = 0.5
local smoothness = 1
local trackingTarget = nil
local isTracking = false
local targetPart = "Head"

-- Triggerbot Variables
local triggerbotEnabled = false
local triggerDelay = 100 -- Default 100ms
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")

-- Function to Check if Target is Valid
local function isTargetValid(target)
    if target and target.Parent then
        local character = target.Parent
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        return humanoid and humanoid.Health > 0 and character ~= LocalPlayer.Character
    end
    return false
end

-- Function to Predict Target Position Based on Velocity and Prediction Value
local function predictTargetPosition(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.RootPart then
        local velocity = humanoid.RootPart.AssemblyLinearVelocity
        local targetPosition = character:FindFirstChild(targetPart)
        if targetPosition then
            -- Predict the target's position based on their velocity and prediction value
            local predictedPosition = targetPosition.Position + velocity * predictionValue
            return predictedPosition
        end
    end
    return nil
end

-- Triggerbot Function
local function triggerShot()
    if triggerbotEnabled and Mouse.Target and isTargetValid(Mouse.Target) then
        wait(triggerDelay / 1000) -- Convert ms to seconds
        -- Simulate mouse click using VirtualInputManager
        game:GetService("VirtualInputManager"):SendInputBegin(Enum.UserInputType.MouseButton1)
        game:GetService("VirtualInputManager"):SendInputEnd(Enum.UserInputType.MouseButton1)
    end
end

RunService.RenderStepped:Connect(triggerShot)

-- Camera Lock Functions
local function getTargetPosition(character)
    if character and character:FindFirstChild(targetPart) then
        return character[targetPart].Position
    elseif character and character:FindFirstChild("HumanoidRootPart") then
        return character.HumanoidRootPart.Position
    end
    return nil
end

local function getNearestPlayer()
    local nearestPlayer, shortestDistance = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance, nearestPlayer = distance, player
            end
        end
    end
    return nearestPlayer
end

local function updateCameraLock()
    if cameraLockEnabled and isTracking and trackingTarget and trackingTarget.Character then
        local camera, targetPosition = workspace.CurrentCamera, predictTargetPosition(trackingTarget.Character)
        if camera and LocalPlayer.Character and targetPosition then
            local currentPosition = camera.CFrame.p
            local lerpFactor = math.clamp(smoothness * 0.05, 0.01, 0.1)
            camera.CFrame = CFrame.new(currentPosition:Lerp(targetPosition, lerpFactor), targetPosition)
        end
    elseif cameraLockEnabled and not isTracking then
        local camera, targetPlayer = workspace.CurrentCamera, getNearestPlayer()
        if camera and LocalPlayer.Character and targetPlayer and targetPlayer.Character then
            local targetPosition = getTargetPosition(targetPlayer.Character)
            if targetPosition then
                local currentPosition = camera.CFrame.p
                local lerpFactor = math.clamp(smoothness * 0.05, 0.01, 0.1)
                camera.CFrame = CFrame.new(currentPosition:Lerp(targetPosition, lerpFactor), targetPosition)
            end
        end
    end
end

RunService.RenderStepped:Connect(updateCameraLock)

-- UI Components
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

-- Triggerbot UI Components
local TriggerbotGroup = Tabs['Main']:AddRightGroupbox('Triggerbot Settings')

TriggerbotGroup:AddToggle('Triggerbot', {
    Text = 'Enable Triggerbot',
    Default = false,
    Callback = function(value)
        triggerbotEnabled = value
    end
})

TriggerbotGroup:AddSlider('TriggerDelay', {
    Text = 'Trigger Delay (ms)',
    Default = 100,
    Min = 0,
    Max = 500,
    Rounding = 1,
    Callback = function(value)
        triggerDelay = value
    end
})

-- Handle Character Reset
LocalPlayer.Character.Humanoid.Died:Connect(function()
    isTracking = false
end)

LocalPlayer.Character.Humanoid.HealthChanged:Connect(function(health)
    if health <= 0 then
        isTracking = false
    end
end)

-- UI Settings
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
