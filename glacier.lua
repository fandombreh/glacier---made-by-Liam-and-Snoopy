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

-- Camera Lock and Smoothness Implementation

local cameraLockEnabled = false
local smoothness = 0.1 -- Default smoothness
local prediction = 0.0041 -- Built-in prediction value

local cameraSubject = workspace.CurrentCamera
local lastCameraCFrame = cameraSubject.CFrame

local MovementGroup = Tabs['Movement']:AddLeftGroupbox("Camera Lock")

MovementGroup:AddToggle("Camera Lock", {
    Default = false,
    Callback = function(value)
        cameraLockEnabled = value;
        lastCameraCFrame = cameraSubject.CFrame;
    end;
})

MovementGroup:AddSlider("Smoothness", {
    Min = 0,
    Max = 1,
    Default = smoothness,
    Increment = 0.01,
    Callback = function(value)
        smoothness = value;
    end;
})

local function smoothCFrame(current, target, alpha)
    local currentPos, currentRot = current.Position, current.Rotation
    local targetPos, targetRot = target.Position, target.Rotation

    local newPos = currentPos:Lerp(targetPos, alpha)
    local newRot = currentRot:Lerp(targetRot, alpha)

    return CFrame.new(newPos) * CFrame.fromMatrix(Vector3.new(), newRot)
end

game:GetService("RunService").RenderStepped:Connect(function()
    if cameraLockEnabled then
        local targetCFrame = cameraSubject.CFrame

        local predictedPosition = targetCFrame.Position + (targetCFrame.Position - lastCameraCFrame.Position) * prediction
        local predictedRotation = targetCFrame.Rotation + (targetCFrame.Rotation - lastCameraCFrame.Rotation) * prediction

        local predictedCFrame = CFrame.new(predictedPosition) * CFrame.fromMatrix(Vector3.new(), predictedRotation)

        lastCameraCFrame = cameraSubject.CFrame -- update last frame before lerping

        cameraSubject.CFrame = smoothCFrame(cameraSubject.CFrame, predictedCFrame, smoothness)

    end
end)
