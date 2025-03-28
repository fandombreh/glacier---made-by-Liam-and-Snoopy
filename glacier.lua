local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/liam675/skibidiliamgoat/refs/heads/main/imnotgoingnowhere",true))()
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

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function()
    Library:Unload()
end)

MenuGroup:AddLabel('Menu Keybind'):AddKeyPicker('MenuKeybind', {
    Default = 'End',
    NoUI = true,
    Text = 'Menu Keybind'
})

local ThemeGroup = Tabs['UI Settings']:AddLeftGroupbox('Themes')
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
ThemeManager:SetFolder('EuphoriaHub')
SaveManager:SetFolder('EuphoriaHub/configs')
ThemeManager:ApplyToTab(Tabs['UI Settings'])

Library.ToggleKeybind = Options.MenuKeybind
Library:SetWatermarkVisibility(false)
Library.KeybindFrame.Visible = true

Library:OnUnload(function()
    Library.Unloaded = true
end)

-- Camera Lock Variables
local cameraLockEnabled = false
local smoothness = 0.1  -- Default smoothness
local prediction = 0.0041 -- Default prediction

local camera = workspace.CurrentCamera
local targetPart = nil -- Target to lock onto

-- UI Controls for Camera Lock
local MainGroup = Tabs['Main']:AddLeftGroupbox("Camera Lock") 

MainGroup:AddToggle("CameraLockToggle", {
    Text = "Enable Camera Lock",
    Default = false,
    Callback = function(value)
        cameraLockEnabled = value
        print("Camera Lock Enabled:", cameraLockEnabled)
    end;
})

MainGroup:AddSlider("SmoothnessSlider", {
    Text = "Smoothness",
    Min = 0,
    Max = 1,
    Default = smoothness,
    Increment = 0.01,
    Callback = function(value)
        smoothness = value
    end;
})

-- Function to find a target (closest player)
local function GetClosestTarget()
    local closest, distance = nil, math.huge
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer or not localPlayer.Character then return end

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local magnitude = (head.Position - camera.CFrame.Position).Magnitude
            if magnitude < distance then
                closest = head
                distance = magnitude
            end
        end
    end

    return closest
end

-- Update Camera Position
game:GetService("RunService").RenderStepped:Connect(function()
    if cameraLockEnabled then
        if not targetPart or not targetPart.Parent then
            targetPart = GetClosestTarget() -- Update target if lost
        end

        if targetPart then
            local targetCFrame = targetPart.CFrame
            local predictedPosition = targetCFrame.Position + (targetCFrame.LookVector * prediction)
            local predictedCFrame = CFrame.new(predictedPosition)

            camera.CFrame = camera.CFrame:Lerp(predictedCFrame, smoothness)
        end
    end
end)
