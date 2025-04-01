-- Gui to Lua

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ImageButton = Instance.new("ImageButton")
local Frame_2 = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Frame_3 = Instance.new("Frame")
local Frame_4 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Frame_5 = Instance.new("Frame")
local Frame_6 = Instance.new("Frame")
local Frame_7 = Instance.new("Frame")
local TextLabel_2 = Instance.new("TextLabel")
local TextLabel_3 = Instance.new("TextLabel")
local TextLabel_4 = Instance.new("TextLabel")
local Frame_8 = Instance.new("Frame")
local TextLabel_5 = Instance.new("TextLabel")
local ImageButton_2 = Instance.new("ImageButton")
local ImageButton_3 = Instance.new("ImageButton")
local ImageButton_4 = Instance.new("ImageButton")
local Frame_9 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local Frame_10 = Instance.new("Frame")
local Frame_11 = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local Frame_12 = Instance.new("Frame")
local Frame_13 = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local Frame_14 = Instance.new("Frame")
local Frame_15 = Instance.new("Frame")
local UICorner_5 = Instance.new("UICorner")
local Frame_16 = Instance.new("Frame")
local Frame_17 = Instance.new("Frame")
local UICorner_6 = Instance.new("UICorner")
local Frame_18 = Instance.new("Frame")



ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.311327815, 0, 0.216686219, 0)
Frame.Size = UDim2.new(0, 100, 0, 447)

ImageButton.Parent = Frame
ImageButton.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(0, 0, 0.0246085003, 0)
ImageButton.Size = UDim2.new(0, 100, 0, 89)
ImageButton.Image = "http://www.roblox.com/asset/?id=135701229354679"

Frame_2.Parent = Frame
Frame_2.Active = true
Frame_2.BackgroundColor3 = Color3.fromRGB(88, 169, 255)
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(1.64416385, 0, 0, 0)
Frame_2.Size = UDim2.new(0, -64, 0, 447)

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame_2

Frame_3.Parent = UICorner
Frame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(1.65999997, 0, -0.301801801, 0)
Frame_3.Size = UDim2.new(0, 100, 0, 100)

Frame_4.Parent = Frame
Frame_4.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
Frame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_4.BorderSizePixel = 0
Frame_4.Position = UDim2.new(1.00416386, 0, 0, 0)
Frame_4.Size = UDim2.new(0, 425, 0, 447)

TextLabel.Parent = Frame_4
TextLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Size = UDim2.new(0, 423, 0, 32)
TextLabel.Font = Enum.Font.PermanentMarker
TextLabel.Text = "Main tab"
TextLabel.TextColor3 = Color3.fromRGB(88, 169, 255)
TextLabel.TextSize = 45.000

Frame_5.Parent = Frame_4
Frame_5.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
Frame_5.BorderColor3 = Color3.fromRGB(88, 169, 255)
Frame_5.BorderSizePixel = 2
Frame_5.Position = UDim2.new(0.0282352939, 0, 0.0715883672, 0)
Frame_5.Size = UDim2.new(0, 175, 0, 408)

Frame_6.Parent = Frame_4
Frame_6.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
Frame_6.BorderColor3 = Color3.fromRGB(88, 169, 255)
Frame_6.BorderSizePixel = 2
Frame_6.Position = UDim2.new(0.515294135, 0, 0.0715883672, 0)
Frame_6.Size = UDim2.new(0, 175, 0, 408)

Frame_7.Parent = Frame_4
Frame_7.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
Frame_7.BorderColor3 = Color3.fromRGB(88, 169, 255)
Frame_7.BorderSizePixel = 2
Frame_7.Position = UDim2.new(0.294117659, 0, 0.205816552, 0)
Frame_7.Size = UDim2.new(0, 20, 0, 21)

TextLabel_2.Parent = Frame_4
TextLabel_2.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0.0282352939, 0, 0.0715883672, 0)
TextLabel_2.Size = UDim2.new(0, 175, 0, 32)
TextLabel_2.Font = Enum.Font.PermanentMarker
TextLabel_2.Text = "Blatant"
TextLabel_2.TextColor3 = Color3.fromRGB(88, 169, 255)
TextLabel_2.TextSize = 45.000

TextLabel_3.Parent = Frame_4
TextLabel_3.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(0.0282352939, 0, 0.192393735, 0)
TextLabel_3.Size = UDim2.new(0, 98, 0, 32)
TextLabel_3.Font = Enum.Font.PermanentMarker
TextLabel_3.Text = "Camlock (C)"
TextLabel_3.TextColor3 = Color3.fromRGB(88, 169, 255)
TextLabel_3.TextSize = 20.000

TextLabel_4.Parent = Frame_4
TextLabel_4.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.BorderSizePixel = 0
TextLabel_4.Position = UDim2.new(0.548235297, 0, 0.192393735, 0)
TextLabel_4.Size = UDim2.new(0, 105, 0, 32)
TextLabel_4.Font = Enum.Font.PermanentMarker
TextLabel_4.Text = "TriggerBot (T)"
TextLabel_4.TextColor3 = Color3.fromRGB(88, 169, 255)
TextLabel_4.TextSize = 20.000

Frame_8.Parent = Frame_4
Frame_8.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
Frame_8.BorderColor3 = Color3.fromRGB(88, 169, 255)
Frame_8.BorderSizePixel = 2
Frame_8.Position = UDim2.new(0.828235269, 0, 0.205816552, 0)
Frame_8.Size = UDim2.new(0, 20, 0, 21)

TextLabel_5.Parent = Frame_4
TextLabel_5.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.BorderSizePixel = 0
TextLabel_5.Position = UDim2.new(0.515294135, 0, 0.0715883672, 0)
TextLabel_5.Size = UDim2.new(0, 175, 0, 32)
TextLabel_5.Font = Enum.Font.PermanentMarker
TextLabel_5.Text = "Legit"
TextLabel_5.TextColor3 = Color3.fromRGB(88, 169, 255)
TextLabel_5.TextSize = 45.000

ImageButton_2.Parent = Frame
ImageButton_2.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
ImageButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageButton_2.BorderSizePixel = 0
ImageButton_2.Position = UDim2.new(0.159999996, 0, 0.297297329, 0)
ImageButton_2.Size = UDim2.new(0, 67, 0, 66)
ImageButton_2.Image = "http://www.roblox.com/asset/?id=115660408858928"
ImageButton_2.ImageColor3 = Color3.fromRGB(0, 0, 0)

ImageButton_3.Parent = Frame
ImageButton_3.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
ImageButton_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageButton_3.BorderSizePixel = 0
ImageButton_3.Position = UDim2.new(0.159999996, 0, 0.635482907, 0)
ImageButton_3.Size = UDim2.new(0, 67, 0, 66)
ImageButton_3.Image = "http://www.roblox.com/asset/?id=92973960206244"

ImageButton_4.Parent = Frame
ImageButton_4.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
ImageButton_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageButton_4.BorderSizePixel = 0
ImageButton_4.Position = UDim2.new(0.159999996, 0, 0.468513906, 0)
ImageButton_4.Size = UDim2.new(0, 67, 0, 66)
ImageButton_4.Image = "http://www.roblox.com/asset/?id=122547257222971"

Frame_9.Parent = Frame
Frame_9.Active = true
Frame_9.BackgroundColor3 = Color3.fromRGB(88, 169, 255)
Frame_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_9.BorderSizePixel = 0
Frame_9.Position = UDim2.new(1.00416386, 0, 0.782997608, 0)
Frame_9.Size = UDim2.new(0, -100, 0, 6)

UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = Frame_9

Frame_10.Parent = UICorner_2
Frame_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_10.BorderSizePixel = 0
Frame_10.Position = UDim2.new(1.65999997, 0, -0.301801801, 0)
Frame_10.Size = UDim2.new(0, 100, 0, 100)

Frame_11.Parent = Frame
Frame_11.Active = true
Frame_11.BackgroundColor3 = Color3.fromRGB(88, 169, 255)
Frame_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_11.BorderSizePixel = 0
Frame_11.Position = UDim2.new(0.994163811, 0, 0.615212381, 0)
Frame_11.Size = UDim2.new(0, -100, 0, 6)

UICorner_3.CornerRadius = UDim.new(0, 15)
UICorner_3.Parent = Frame_11

Frame_12.Parent = UICorner_3
Frame_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_12.BorderSizePixel = 0
Frame_12.Position = UDim2.new(1.65999997, 0, -0.301801801, 0)
Frame_12.Size = UDim2.new(0, 100, 0, 100)

Frame_13.Parent = Frame
Frame_13.Active = true
Frame_13.BackgroundColor3 = Color3.fromRGB(88, 169, 255)
Frame_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_13.BorderSizePixel = 0
Frame_13.Position = UDim2.new(1.00416386, 0, 0.429530054, 0)
Frame_13.Size = UDim2.new(0, -100, 0, 6)

UICorner_4.CornerRadius = UDim.new(0, 15)
UICorner_4.Parent = Frame_13

Frame_14.Parent = UICorner_4
Frame_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_14.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_14.BorderSizePixel = 0
Frame_14.Position = UDim2.new(1.65999997, 0, -0.301801801, 0)
Frame_14.Size = UDim2.new(0, 100, 0, 100)

Frame_15.Parent = Frame
Frame_15.Active = true
Frame_15.BackgroundColor3 = Color3.fromRGB(88, 169, 255)
Frame_15.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_15.BorderSizePixel = 0
Frame_15.Position = UDim2.new(1.00416386, 0, 0.255033433, 0)
Frame_15.Size = UDim2.new(0, -100, 0, 6)

UICorner_5.CornerRadius = UDim.new(0, 15)
UICorner_5.Parent = Frame_15

Frame_16.Parent = UICorner_5
Frame_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_16.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_16.BorderSizePixel = 0
Frame_16.Position = UDim2.new(1.65999997, 0, -0.301801801, 0)
Frame_16.Size = UDim2.new(0, 100, 0, 100)

Frame_17.Parent = Frame
Frame_17.Active = true
Frame_17.BackgroundColor3 = Color3.fromRGB(88, 169, 255)
Frame_17.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_17.BorderSizePixel = 0
Frame_17.Position = UDim2.new(3.19916415, 0, 0.49776274, 0)
Frame_17.Rotation = 90.000
Frame_17.Size = UDim2.new(0, -441, 0, 6)

UICorner_6.CornerRadius = UDim.new(0, 15)
UICorner_6.Parent = Frame_17

Frame_18.Parent = UICorner_6
Frame_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_18.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_18.BorderSizePixel = 0
Frame_18.Position = UDim2.new(1.65999997, 0, -0.301801801, 0)
Frame_18.Size = UDim2.new(0, 100, 0, 100)


local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local camLockEnabled = false
local triggerBotEnabled = false


local function isGunOut()
    local character = LocalPlayer.Character
    if character and character:FindFirstChildOfClass("Tool") then
        return true
    end
