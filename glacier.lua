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
local lockTargetPart = "Head" -- Default to "Head"

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

local function hasGunEquipped()
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    if character then
        local gunNames = {"Pistol", "AK-47", "Shotgun", "Uzi", "RPG", "Mac-10", "M4A1", "Deagle", "Double Barrel", "Glock", "DB"}
        for _, gunName in ipairs(gunNames) do
            local tool = character:FindFirstChild(gunName)
            if tool then
                return true
            end
        end
    end
    return false
end

local function triggerbot()
    while triggerbotEnabled do
        if hasGunEquipped() then
            local target = getNearestPlayer()
            if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                local humanoid = target.Character.Humanoid
                if humanoid.Health > 0 then
                    wait(triggerDelay / 1000)
                    local mouse = game.Players.LocalPlayer:GetMouse()
                    mouse1click()  -- Adjust this to your method of triggering mouse click
                end
            end
        end
        wait(0.1)
    end
end

local function updateCameraLock()
    if cameraLockEnabled then
        local camera = workspace.CurrentCamera
        local localPlayer = game.Players.LocalPlayer
        local targetPlayer = isTracking and trackingTarget or getNearestPlayer()

        if camera and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer and targetPlayer.Character then
            local targetPart

            if lockTargetPart == "Head" then
                targetPart = targetPlayer.Character:FindFirstChild("Head")
            elseif lockTargetPart == "Torso" then
                -- Prioritize UpperTorso, then LowerTorso, then HumanoidRootPart as a fallback
                targetPart = targetPlayer.Character:FindFirstChild("UpperTorso") or targetPlayer.Character:FindFirstChild("LowerTorso") or targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            end

            if targetPart then
                local targetPosition = targetPart.Position
                local predictedPosition = targetPosition

                if isTracking and trackingTarget and trackingTarget.Character and trackingTarget.Character:FindFirstChild("HumanoidRootPart") then
                    local targetVelocity = trackingTarget.Character.HumanoidRootPart.Velocity
                    predictedPosition = targetPosition + targetVelocity * predictionValue
                end

                local currentPosition = camera.CFrame.p
                local lerpFactor = math.clamp(smoothness * 0.05, 0.01, 0.1)
                local newPosition = currentPosition:Lerp(predictedPosition, lerpFactor)

                camera.CFrame = CFrame.new(newPosition, targetPart.Position)
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
        if cameraLockEnabled then
            local nearestPlayer = getNearestPlayer()
            if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart") then
                trackingTarget = nearestPlayer
                isTracking = true
            end
        else
            trackingTarget = nil
            isTracking = false
        end
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

MainGroup:AddDropdown('LockTargetPart', {
    Text = 'Lock Target Part',
    Default = 'Head', -- Default to "Head"
    Values = {'Head', 'Torso'}, -- Choices for Head or Torso
    Callback = function(value)
        lockTargetPart = value
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
    if health <= 0 then
        isTracking = false
    end
})

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
