local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local CameraUtil = {}

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local originalState = nil

function CameraUtil:Focus(partFrom, partTo, time)
	if not partFrom or not partTo then
		return
	end

	if not originalState then
		originalState = {
			CameraType = camera.CameraType,
			CameraSubject = camera.CameraSubject,
			CFrame = camera.CFrame,
			FieldOfView = camera.FieldOfView,
		}
	end

	camera.CameraType = Enum.CameraType.Scriptable

	local targetCFrame = CFrame.new(partFrom.Position, partTo.Position)

	local tweenInfo = TweenInfo.new(time or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(camera, tweenInfo, { CFrame = targetCFrame })
	tween:Play()

	return tween
end

function CameraUtil:Restore(time)
	if not originalState then
		return
	end

	local tweenInfo = TweenInfo.new(time or 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

	local tween = TweenService:Create(camera, tweenInfo, {
		CFrame = originalState.CFrame,
		FieldOfView = originalState.FieldOfView,
	})

	tween:Play()

	tween.Completed:Connect(function()
		camera.CameraType = originalState.CameraType or Enum.CameraType.Custom

		if originalState.CameraSubject and originalState.CameraSubject.Parent then
			camera.CameraSubject = originalState.CameraSubject
		else
			if player and player.Character then
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					camera.CameraSubject = humanoid
				end
			end
		end

		originalState = nil
	end)

	return tween
end

return CameraUtil
