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
local triggerbotEnabled = false
local triggerDelay = 50

local UserInputService = game:GetService("UserInputService")


local triggerbotHotkey = Enum.KeyCode.T  

local cameraLockHotkey = Enum.KeyCode.C  

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

local function triggerbot()
    while triggerbotEnabled do
        local target = getNearestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            local humanoid = target.Character.Humanoid
            if humanoid.Health > 0 then
                wait(triggerDelay / 1000)
                mouse1click()
            end
        end
        wait(0.1)
    end
end

local function onDamageTaken(damage, attacker)
    if attacker and attacker.Character and attacker.Character:FindFirstChild("HumanoidRootPart") then
        trackingTarget = attacker
        isTracking = true
    end
end

local function onHealthChanged(health)
    if health <= 0 then
        isTracking = false
    end
end

local function updateCameraLock()
    if cameraLockEnabled and isTracking and trackingTarget and trackingTarget.Character and trackingTarget.Character:FindFirstChild("HumanoidRootPart") then
        local camera = workspace.CurrentCamera
        local localPlayer = game.Players.LocalPlayer

        if camera and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = trackingTarget.Character.HumanoidRootPart.Position
            local targetVelocity = trackingTarget.Character.HumanoidRootPart.Velocity

            local predictedPosition = targetPosition + targetVelocity * predictionValue

            local currentPosition = camera.CFrame.p
            local lerpFactor = math.clamp(smoothness * 0.05, 0.01, 0.1)
            local newPosition = currentPosition:Lerp(predictedPosition, lerpFactor)

            camera.CFrame = CFrame.new(newPosition, trackingTarget.Character.HumanoidRootPart.Position)
        end
    elseif cameraLockEnabled and not isTracking then
        local camera = workspace.CurrentCamera
        local targetPlayer = getNearestPlayer()
        local localPlayer = game.Players.LocalPlayer

        if camera and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
            local currentPosition = camera.CFrame.p
            local lerpFactor = math.clamp(smoothness * 0.05, 0.01, 0.1)
            local newPosition = currentPosition:Lerp(targetPosition, lerpFactor)
            camera.CFrame = CFrame.new(newPosition, targetPlayer.Character.HumanoidRootPart.Position)
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(updateCameraLock)

game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
    isTracking = false
end)


UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == triggerbotHotkey then
        triggerbotEnabled = not triggerbotEnabled
        if triggerbotEnabled then
            spawn(triggerbot)
        end
    end

   
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == cameraLockHotkey then
        cameraLockEnabled = not cameraLockEnabled
    end
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

MainGroup:AddToggle('Triggerbot', {
    Text = 'Enable Triggerbot',
    Default = false,
    Callback = function(value)
        triggerbotEnabled = value
        if triggerbotEnabled then
            spawn(triggerbot)
        end
    end
})

MainGroup:AddSlider('TriggerDelay', {
    Text = 'Trigger Delay (ms)',
    Default = 50,
    Min = 0,
    Max = 500,
    Rounding = 0,
    Callback = function(value)
        triggerDelay = value
    end
})

game.Players.LocalPlayer.Character.Humanoid.HealthChanged:Connect(function(health)
    onHealthChanged(health)
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

print("[SUCCESS] Triggerbot with delay added to Main tab!")
