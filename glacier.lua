local repo = "https://github.com/fandombreh/glacier---made-by-Liam-and-Snoopy/edit/main/glacier.lua"
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local CustomColors = {
    WindowBackgroundColor = Color3.fromRGB(40, 40, 40),
    TabBackgroundColor = Color3.fromRGB(50, 50, 50),
    GroupboxBackgroundColor = Color3.fromRGB(60, 60, 60),
    ButtonBackgroundColor = Color3.fromRGB(70, 70, 70),
    TextColor = Color3.fromRGB(255, 255, 255),
    AccentColor = Color3.fromRGB(0, 150, 255),
    SliderColor = Color3.fromRGB(0, 150, 255),
    ToggleOnColor = Color3.fromRGB(0, 200, 100),
    ToggleOffColor = Color3.fromRGB(150, 150, 150),
    DropdownBackgroundColor = Color3.fromRGB(70, 70, 70),
    DropdownTextColor = Color3.fromRGB(255, 255, 255),
    KeyPickerBackgroundColor = Color3.fromRGB(70, 70, 70),
    KeyPickerTextColor = Color3.fromRGB(255, 255, 255),
    ColorPickerBackgroundColor = Color3.fromRGB(70, 70, 70),
    ColorPickerTextColor = Color3.fromRGB(255, 255, 255),
    LabelTextColor = Color3.fromRGB(255, 255, 255),
}

local Window = Library:CreateWindow({
    Title = 'Enhanced Menu',
    Center = true,
    AutoShow = true,
    BackgroundColor = CustomColors.WindowBackgroundColor,
    TextColor = CustomColors.TextColor,
    AccentColor = CustomColors.AccentColor,
})

local Tabs = {
    Main = Window:AddTab('Main', {BackgroundColor = CustomColors.TabBackgroundColor, TextColor = CustomColors.TextColor}),
    ['Visuals'] = Window:AddTab('Visuals', {BackgroundColor = CustomColors.TabBackgroundColor, TextColor = CustomColors.TextColor}),
    ['Combat'] = Window:AddTab('Combat', {BackgroundColor = CustomColors.TabBackgroundColor, TextColor = CustomColors.TextColor}),
    ['UI Settings'] = Window:AddTab('UI Settings', {BackgroundColor = CustomColors.TabBackgroundColor, TextColor = CustomColors.TextColor}),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('General', {BackgroundColor = CustomColors.GroupboxBackgroundColor, TextColor = CustomColors.TextColor})

LeftGroupBox:AddToggle('TriggerbotEnabled', {
    Text = 'Triggerbot',
    Default = false,
    Tooltip = 'Enables triggerbot functionality.',
    ToggleOnColor = CustomColors.ToggleOnColor,
    ToggleOffColor = CustomColors.ToggleOffColor,
    TextColor = CustomColors.TextColor,
})

LeftGroupBox:AddToggle('CamLock', {
    Text = 'Camera Lock',
    Default = false,
    Tooltip = 'Locks camera to target.',
    ToggleOnColor = CustomColors.ToggleOnColor,
    ToggleOffColor = CustomColors.ToggleOffColor,
    TextColor = CustomColors.TextColor,
})

LeftGroupBox:AddSlider('TriggerbotDelay', {
    Text = 'Trigger Delay (ms)',
    Default = 100,
    Min = 0,
    Max = 500,
    Rounding = 0,
    SliderColor = CustomColors.SliderColor,
    TextColor = CustomColors.TextColor,
})

local VisualsGroup = Tabs.Visuals:AddLeftGroupbox('Visuals', {BackgroundColor = CustomColors.GroupboxBackgroundColor, TextColor = CustomColors.TextColor})

VisualsGroup:AddToggle('ESPenabled', {
    Text = 'ESP',
    Default = false,
    Tooltip = 'Enables player ESP.',
    ToggleOnColor = CustomColors.ToggleOnColor,
    ToggleOffColor = CustomColors.ToggleOffColor,
    TextColor = CustomColors.TextColor,
})

VisualsGroup:AddSlider('FOV', {
    Text = 'FOV Circle Size',
    Default = 100,
    Min = 10,
    Max = 300,
    Rounding = 0,
    SliderColor = CustomColors.SliderColor,
    TextColor = CustomColors.TextColor,
})

VisualsGroup:AddColorPicker('FOVColor', {
    Default = Color3.new(1, 0, 0),
    Title = 'FOV Circle Color',
    BackgroundColor = CustomColors.ColorPickerBackgroundColor,
    TextColor = CustomColors.ColorPickerTextColor,
})

local CombatGroup = Tabs.Combat:AddLeftGroupbox('Combat', {BackgroundColor = CustomColors.GroupboxBackgroundColor, TextColor = CustomColors.TextColor})

CombatGroup:AddDropdown('TargetPriority', {
    Values = {'Closest', 'Health', 'Distance'},
    Default = 1,
    Text = 'Target Priority',
    Tooltip = "How the target is selected.",
    BackgroundColor = CustomColors.DropdownBackgroundColor,
    TextColor = CustomColors.DropdownTextColor,
})

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu', {BackgroundColor = CustomColors.GroupboxBackgroundColor, TextColor = CustomColors.TextColor})
MenuGroup:AddButton('Unload', function() Library:Unload() end, {BackgroundColor = CustomColors.ButtonBackgroundColor, TextColor = CustomColors.TextColor})
MenuGroup:AddLabel('Menu bind', {TextColor = CustomColors.LabelTextColor}):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind', BackgroundColor = CustomColors.KeyPickerBackgroundColor, TextColor = CustomColors.KeyPickerTextColor })
Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

local function triggerbot()
    if not Toggles.TriggerbotEnabled.Value then return end

    local target = nil
    if Options.TargetPriority.Value == "Closest" then
    elseif Options.TargetPriority.Value == "Health" then
    elseif Options.TargetPriority.Value == "Distance" then
    end

    if target then
        wait(Options.TriggerbotDelay.Value / 1000)
        game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(game:GetService('Players').LocalPlayer.Character:FindFirstChildOfClass('Tool'))
        fireclickdetector(game:GetService('Players').LocalPlayer.Character:FindFirstChildOfClass('Tool'):FindFirstChildOfClass("ClickDetector"))
    end
end

local function camLock()
    if not Toggles.CamLock.Value then return end

    local target = nil
    if Options.TargetPriority.Value == "Closest" then
    elseif Options.TargetPriority.Value == "Health" then
    elseif Options.TargetPriority.Value == "Distance" then
    end

    if target then
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, target.HumanoidRootPart.Position)
    end
end

local function visuals()
    if Toggles.ESPenabled.Value then
    end

    if Options.FOV.Value > 0 then
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

task.spawn(function()
    while true do
        wait()
        triggerbot()
        camLock()
        visuals()
        if Library.Unloaded then break end
    end
end)
