-- Camera Lock Variables
local cameraLockEnabled = false
local smoothness = 0.1  -- Default smoothness
local prediction = 0.027 -- Updated prediction value

local camera = workspace.CurrentCamera
local targetPart = nil -- Target to lock onto

-- Function to set the lock-on target
local function SetCameraTarget(player)
    if player and player.Character and player.Character:FindFirstChild("Head") then
        targetPart = player.Character.Head
        print("Target successfully set to:", targetPart.Name)
    else
        targetPart = nil
        print("No valid target found.")
    end
end

-- UI Controls for Camera Lock
local success, errorMsg = pcall(function()
    local MainGroup = Tabs['Main']:AddLeftGroupbox("Camera Lock")
    
    MainGroup:AddToggle("CameraLockToggle", {
        Text = "Enable Camera Lock",
        Default = false,
        Callback = function(value)
            cameraLockEnabled = value
            print("Camera Lock toggled:", cameraLockEnabled)
    
            if cameraLockEnabled then
                SetCameraTarget(game.Players.LocalPlayer)
            else
                targetPart = nil
                print("Camera Lock disabled and target cleared.")
            end
        end
    })
    
    MainGroup:AddSlider("SmoothnessSlider", {
        Text = "Smoothness",
        Min = 0,
        Max = 1,
        Default = smoothness,
        Increment = 0.01,
        Callback = function(value)
            smoothness = value
            print("Smoothness adjusted to:", smoothness)
        end
    })
end)

if not success then
    print("Error setting up UI Controls:", errorMsg)
end

-- Camera update logic
game:GetService("RunService").RenderStepped:Connect(function()
    print("RenderStepped running...")
    
    if cameraLockEnabled then
        if targetPart then
            local targetCFrame = targetPart.CFrame
            local predictedPosition = targetCFrame.Position + (targetCFrame.LookVector * prediction)
            local predictedCFrame = CFrame.new(predictedPosition)

            camera.CFrame = camera.CFrame:Lerp(predictedCFrame, smoothness)
            print("Camera updated to follow target.")
        else
            print("Camera Lock is enabled but no target is set.")
        end
    end
end)

-- Initial Setup: Lock onto the local player
if game.Players.LocalPlayer then
    SetCameraTarget(game.Players.LocalPlayer)
else
    print("LocalPlayer not found. Ensure this script is run locally.")
end
