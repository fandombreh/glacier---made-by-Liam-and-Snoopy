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
