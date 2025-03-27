local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Enhanced Menu',
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab('Main'),
    ['Visuals'] = Window:AddTab('Visuals'),
    ['Combat'] = Window:AddTab('Combat'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- Main Tab
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('General')

LeftGroupBox:AddToggle('TriggerbotEnabled', {
    Text = 'Triggerbot',
    Default = false,
    Tooltip = 'Enables triggerbot functionality.',
})

LeftGroupBox:AddToggle('CamLock', {
    Text = 'Camera Lock',
    Default = false,
    Tooltip = 'Locks camera to target.',
})

LeftGroupBox:AddSlider('TriggerbotDelay', {
    Text = 'Trigger Delay (ms)',
    Default = 100,
    Min = 0,
    Max = 500,
    Rounding = 0,
})

-- Visuals Tab
local VisualsGroup = Tabs.Visuals:AddLeftGroupbox('Visuals')

VisualsGroup:AddToggle('ESPenabled', {
    Text = 'ESP',
    Default = false,
    Tooltip = 'Enables player ESP.',
})

VisualsGroup:AddSlider('FOV', {
    Text = 'FOV Circle Size',
    Default = 100,
    Min = 10,
    Max = 300,
    Rounding = 0,
})

VisualsGroup:AddColorPicker('FOVColor', {
    Default = Color3.new(1, 0, 0),
    Title = 'FOV Circle Color',
})

-- Combat Tab
local CombatGroup = Tabs.Combat:AddLeftGroupbox('Combat')

CombatGroup:AddDropdown('TargetPriority', {
    Values = {'Closest', 'Health', 'Distance'},
    Default = 1,
    Text = 'Target Priority',
    Tooltip = "How the target is selected."
})

-- UI Settings Tab
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind

-- Addons
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- Triggerbot Logic (Example)
local function triggerbot()
    if not Toggles.TriggerbotEnabled.Value then return end

    local target = nil
    -- Target selection logic based on priority.
    if Options.TargetPriority.Value == "Closest" then
        -- Find closest target.
    elseif Options.TargetPriority.Value == "Health" then
        -- Find target with lowest health.
    elseif Options.TargetPriority.Value == "Distance" then
        --find target based on distance.
    end

    if target then
        wait(Options.TriggerbotDelay.Value / 1000)
        -- Fire weapon at target.
        -- game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position, target.HumanoidRootPart.Position)
        game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(game:GetService('Players').LocalPlayer.Character:FindFirstChildOfClass('Tool'))
        fireclickdetector(game:GetService('Players').LocalPlayer.Character:FindFirstChildOfClass('Tool'):FindFirstChildOfClass("ClickDetector"))
    end
end

-- Camera Lock Logic (Example)
local function camLock()
    if not Toggles.CamLock.Value then return end

    local target = nil
    -- Target selection logic based on priority.
    if Options.TargetPriority.Value == "Closest" then
        -- Find closest target.
    elseif Options.TargetPriority.Value == "Health" then
        -- Find target with lowest health.
    elseif Options.TargetPriority.Value == "Distance" then
        --find target based on distance.
    end

    if target then
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, target.HumanoidRootPart.Position)
    end
end

-- ESP and FOV Circle Logic (Example)
local function visuals()
    -- ESP Logic
    if Toggles.ESPenabled.Value then
        -- Draw ESP boxes around players.
    end

    -- FOV Circle Logic
    if Options.FOV.Value > 0 then
        -- Draw FOV circle on screen.
        local circle = Drawing.new('Circle')
        circle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
        circle.Radius = Options.FOV.Value
        circle.Thickness = 1
        circle.Color = Options.FOVColor.Value
        circle.Filled = false
        circle.Visible = true;

        task.wait()
        circle:Remove();
    end
end

-- Main Loop
task.spawn(function()
    while true do
        wait()
        triggerbot()
        camLock()
        visuals()
        if Library.Unloaded then break end
    end
end)
