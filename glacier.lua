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
        if cameraLockEnabled then
            print("Camera Lock enabled. Waiting for target...")
            -- Optional: Set a default target (e.g., player's own head)
            local player = game.Players.LocalPlayer
            SetCameraTarget(player)  -- Replace with dynamic target selection if needed
        else
            print("Camera Lock disabled.")
        end
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
        print("Smoothness adjusted to: ", smoothness) -- Debugging print
    end;
})

game:GetService("RunService").RenderStepped:Connect(function()
    if cameraLockEnabled and targetPart then
        local targetCFrame = targetPart.CFrame
        local predictedPosition = targetCFrame.Position + (targetCFrame.LookVector * prediction)
        local predictedCFrame = CFrame.new(predictedPosition)

        camera.CFrame = camera.CFrame:Lerp(predictedCFrame, smoothness)
    else
        -- Optional: Reset camera to default behavior when camera lock is disabled
        camera.CFrame = workspace.CurrentCamera.CFrame
    end
end)

-- Function to set the lock-on target
function SetCameraTarget(player)
    if player and player.Character and player.Character:FindFirstChild("Head") then
        targetPart = player.Character.Head
        print("Target acquired: ", targetPart.Name)
    else
        targetPart = nil
        print("Failed to acquire target.")
    end
end
