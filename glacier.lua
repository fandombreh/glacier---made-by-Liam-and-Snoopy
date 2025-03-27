local repo = "https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/"
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

-- UI Settings Tab - Color Pickers
Tabs['UI Settings']:AddColorPicker('WindowBackgroundColor', {
    Default = CustomColors.WindowBackgroundColor,
    Title = 'Window Background',
})
Tabs['UI Settings']:AddColorPicker('TabBackgroundColor', {
    Default = CustomColors.TabBackgroundColor,
    Title = 'Tab Background',
})
Tabs['UI Settings']:AddColorPicker('GroupboxBackgroundColor', {
    Default = CustomColors.GroupboxBackgroundColor,
    Title = 'Groupbox Background',
})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Apply custom colors *before* ThemeManager applies its defaults
for _, tab in pairs(Tabs) do
    ThemeManager:ApplyCustomColors(tab, {
        BackgroundColor = tab.Config.BackgroundColor,
        TextColor = tab.Config.TextColor,
    })
end

ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- Update functions to change window and tabs background colors.
local function updateBackgroundColors()
    Window:SetBackgroundColor(Options.WindowBackgroundColor.Value)
    for _, tab in pairs(Tabs) do
        tab:SetBackgroundColor(Options.TabBackgroundColor.Value)
        for _, groupbox in pairs(tab.LeftGroupboxes) do
            groupbox:SetBackgroundColor(Options.GroupboxBackgroundColor.Value)
        end
    end
end

-- Connect the color pickers to the update function.
Options.WindowBackgroundColor:OnChanged(updateBackgroundColors)
Options.TabBackgroundColor:OnChanged(updateBackgroundColors)
Options.GroupboxBackgroundColor:OnChanged(updateBackgroundColors)

local function triggerbot()
    if not Toggles.TriggerbotEnabled.Value then return end

    local target = nil
    if Options.TargetPriority.Value == "Closest" then
    elseif Options.TargetPriority.Value == "Health" then
    elseif Options.TargetPriority.Value == "Distance" then
    end

    if target
