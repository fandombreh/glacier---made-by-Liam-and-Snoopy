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
local targetPart = "Head"
local cameraLockKey = Enum.KeyCode.C  -- Default Keybind

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local function getClosestPlayerToMouse()
    local closestPlayer, shortestDistance = nil, math.huge
    local mousePosition = UserInputService:GetMouseLocation()

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(targetPart) then
            local screenPosition, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character[targetPart].Position)
            if onScreen then
                local distance = (Vector2.new(screenPosition.X, screenPosition.Y) - mousePosition).Magnitude
                if distance < shortestDistance then
                    shortestDistance, closestPlayer = distance, player
                end
            end
        end
    end
    return closestPlayer
end

local function updateCameraLock()
    if cameraLockEnabled then
        if isTracking and trackingTarget and trackingTarget.Character then
            local camera, targetPosition = workspace.CurrentCamera, trackingTarget.Character:FindFirstChild(targetPart)
            if camera and LocalPlayer.Character and targetPosition then
                local currentPosition = camera.CFrame.p
                local lerpFactor = math.clamp(smoothness * 0.05, 0.01, 0.1)
                camera.CFrame = CFrame.new(currentPosition:Lerp(targetPosition.Position, lerpFactor), targetPosition.Position)
            end
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == cameraLockKey then
        if isTracking then
            trackingTarget = nil
            isTracking = false
        else
            trackingTarget = getClosestPlayerToMouse()
            isTracking = trackingTarget ~= nil
        end
    end
end)

RunService.RenderStepped:Connect(updateCameraLock)

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

-- Camera Lock Keybind
MainGroup:AddKeyPicker('CameraLockKeybind', {
    Default = 'C',
    NoUI = false,
    Text = 'Camera Lock Keybind',
    Callback = function(key)
        cameraLockKey = Enum.KeyCode[key]
    end
})

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function()
    Library:Unload()
end)
