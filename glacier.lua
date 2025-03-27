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
        print("Camera Lock toggled: ", cameraLockEnabled) -- Debugging print

        if cameraLockEnabled then
            -- Attempt to set a default target (local player example)
            local player = game.Players.LocalPlayer
            SetCameraTarget(player)

            if targetPart then
                print("Target successfully set to: ", targetPart.Name)
            else
                print("No target found. Ensure a valid target exists.")
            end
        else
            -- Reset the target when disabled
            targetPart = nil
            print("Camera Lock disabled and target cleared.")
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
        print("Camera updated to follow target.")
    elseif cameraLockEnabled and not targetPart then
        print("Camera Lock is enabled but no target is set.")
    end
end)

-- Function to set the lock-on target
function SetCameraTarget(player)
    if player and player.Character and player.Character:FindFirstChild("Head") then
        targetPart = player.Character.Head
    else
        targetPart = nil
    end
end

-- Example Usage: Lock onto a player (local player example)
local targetPlayer = game.Players.LocalPlayer
SetCameraTarget(targetPlayer)
