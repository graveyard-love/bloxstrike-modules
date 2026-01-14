-- game.ReplicatedStorage.Components.Common.VFXLibary.FlashEffect

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
local v_u_tween = game:GetService("TweenService")
local v_u_lighting = game:GetService("Lighting")
local v_u_workspace = game:GetService("Workspace")
local v_u_run = game:GetService("RunService")
local v_u_localplayer = v_players.LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u_current_camera = v_u_workspace.CurrentCamera
local v_u_debris = v_u_workspace:WaitForChild("Debris")
local v_u1 = require(v_replicatedstorage.Controllers.CaptureController)
local v_u2 = require(v_replicatedstorage.Classes.Sound)
local v_u_new = Color3.new(1, 1, 1)
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local v_u3 = nil
local v_u4 = nil
local v_u5 = nil
local v_u6 = nil
local v_u7 = nil
local v_u8 = nil
local v_u9 = nil
local v_u10 = nil
local v_u11 = nil
local v_u12 = nil
local v_u13 = nil
local v_u14 = nil
local v_u15 = 0
local function v_u16()
	-- upvalues: (ref) v_u6, (ref) v_u7, (ref) v_u3, (ref) v_u4, (ref) v_u5, (ref) v_u10, (ref) v_u8, (ref) v_u9, (ref) v_u13, (ref) v_u14
	if v_u6 then
		v_u6:Cancel()
		v_u6 = nil
	end
	if v_u7 then
		v_u7:Cancel()
		v_u7 = nil
	end
	if v_u3 then
		v_u3:Destroy()
		v_u3 = nil
		v_u4 = nil
	end
	if v_u5 then
		v_u5:Destroy()
		v_u5 = nil
	end
	if v_u10 then
		v_u10:Cancel()
		v_u10 = nil
	end
	if v_u8 then
		v_u8:Destroy()
		v_u8 = nil
		v_u9 = nil
	end
	v_u13 = nil
	v_u14 = nil
end
local function v_u17()
	-- upvalues: (copy) v_u_new, (copy) v_u_playergui
	local v_screengui = Instance.new("ScreenGui")
	v_screengui.Name = "FlashbangEffect"
	v_screengui.DisplayOrder = 999
	v_screengui.IgnoreGuiInset = true
	v_screengui.ResetOnSpawn = false
	local v_frame = Instance.new("Frame")
	v_frame.Name = "FlashOverlay"
	v_frame.Size = UDim2.new(1, 0, 1, 0)
	v_frame.Position = UDim2.new(0, 0, 0, 0)
	v_frame.BackgroundColor3 = v_u_new
	v_frame.BackgroundTransparency = 1
	v_frame.BorderSizePixel = 0
	v_frame.ZIndex = 999
	v_frame.Parent = v_screengui
	v_screengui.Parent = v_u_playergui
	return v_screengui, v_frame
end
local function v_u18(arg1)
	-- upvalues: (ref) v_u15, (ref) v_u13, (ref) v_u14, (ref) v_u3, (ref) v_u4, (ref) v_u5, (copy) v_u17, (copy) v_u_lighting, (ref) v_u6, (ref) v_u7, (copy) v_u_tween, (copy) v_u16
	task.wait(0.05)
	while v_u15 == arg1 do
		local v1 = v_u13
		local v2 = v_u14
		if not (v1 and v2) then
			break
		end
		local v_clock = os.clock()
		if v1 <= v_clock then
			break
		end
		local v3 = v_u3
		local v4 = v_u4
		local v5 = v_u5
		if not (v3 and v4) then
			v3, v4 = v_u17()
			v_u3 = v3
			v_u4 = v4
		end
		if not v5 then
			v5 = Instance.new("ColorCorrectionEffect")
			v5.Name = "FlashbangColorCorrection"
			v5.Brightness = 0
			v5.Contrast = 0
			v5.Saturation = 0
			v5.TintColor = Color3.new(1, 1, 1)
			v5.Parent = v_u_lighting
			v_u5 = v5
		end
		if v_clock < v2 then
			if v_u6 then
				v_u6:Cancel()
				v_u6 = nil
			end
			if v_u7 then
				v_u7:Cancel()
				v_u7 = nil
			end
			v4.BackgroundTransparency = 0
			v5.Brightness = 1
			v5.Saturation = -1
			task.wait(0.05)
		else
			local v6 = v1 - v_clock
			if v6 <= 0 then
				break
			end
			if v_u6 then
				v_u6:Cancel()
				v_u6 = nil
			end
			if v_u7 then
				v_u7:Cancel()
				v_u7 = nil
			end
			v_u6 = v_u_tween:Create(v4, TweenInfo.new(v6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["BackgroundTransparency"] = 1
			})
			v_u7 = v_u_tween:Create(v5, TweenInfo.new(v6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Brightness"] = 0,
				["Saturation"] = 0
			})
			v_u6:Play()
			v_u7:Play()
			while v_u15 == arg1 do
				local v_clock = os.clock()
				if v1 <= v_clock or v_u14 and v_clock < v_u14 then
					break
				end
				task.wait(0.05)
			end
		end
	end
	if v_u15 == arg1 then
		v_u16()
	end
end
local v_u19 = { -0.5, 0, 0.5 }
local v_u20 = nil
local function v_u21(arg1, arg2)
	-- upvalues: (copy) v_u_debris, (copy) v_u_localplayer, (ref) v_u20, (copy) v_u_workspace, (copy) v_u_new, (copy) v_u19
	local v1 = { v_u_debris }
	local v_character = v_u_localplayer.Character
	if v_character then
		table.insert(v1, v_character)
	end
	local v2 = not v_u20 and v_u_workspace:FindFirstChild("Map")
	if v2 then
		v_u20 = v2:FindFirstChild("Barriers")
	end
	local v3 = v_u20
	if v3 then
		table.insert(v1, v3)
	end
	v_u_new.FilterDescendantsInstances = v1
	for _, v4 in ipairs(v_u19) do
		for _, v5 in ipairs(v_u19) do
			for _, v6 in ipairs(v_u19) do
				local v7 = arg1 + Vector3.new(v4, v5, v6)
				local v8 = arg2 - v7
				local v_magnitude = v8.Magnitude
				if v_magnitude < 0.1 then
					return true
				end
				local v_raycast = v_u_workspace:Raycast(v7, v8, v_u_new)
				if not v_raycast or v_raycast.Distance >= v_magnitude - 0.5 then
					return true
				end
			end
		end
	end
	return false
end
return {
	["Flash"] = function(arg1)
		-- upvalues: (copy) v_u_current_camera, (copy) v_u21, (ref) v_u11, (ref) v_u12, (copy) v_u2, (copy) v_u_run, (ref) v_u13, (ref) v_u14, (ref) v_u9, (ref) v_u10, (copy) v_u_tween, (ref) v_u8, (ref) v_u3, (ref) v_u4, (ref) v_u5, (copy) v_u17, (copy) v_u_lighting, (ref) v_u6, (ref) v_u7, (ref) v_u15, (copy) v_u18, (copy) v_u1, (copy) v_u_playergui
		local v_position = arg1.Position
		local v_position = v_u_current_camera.CFrame.Position
		local v_lookvector = v_u_current_camera.CFrame.LookVector
		local v1 = v_position - v_position
		local v_magnitude = v1.Magnitude
		if v_magnitude > 100 then
			return
		elseif v_u21(v_position, v_position) then
			if v_u11 then
				if v_u12 then
					v_u12:Disconnect()
					v_u12 = nil
				end
				if v_u11.Parent then
					v_u11:Stop()
					v_u11:Destroy()
				end
				v_u11 = nil
			end
			local v_u_play = v_u2.new("Flashbang"):play({
				["Parent"] = v_u_current_camera,
				["Name"] = "Flashed"
			})
			if v_u_play then
				v_u11 = v_u_play
				local v_u2 = tick()
				local v_u_volume = v_u_play.Volume
				v_u12 = v_u_run.Heartbeat:Connect(function()
					-- upvalues: (copy) v_u2, (ref) v_u12, (copy) v_u_play, (ref) v_u11, (copy) v_u_volume
					local v1 = tick() - v_u2
					if v1 >= 4 then
						if v_u12 then
							v_u12:Disconnect()
							v_u12 = nil
						end
						if v_u_play and v_u_play.Parent then
							v_u_play:Stop()
							v_u_play:Destroy()
						end
						if v_u11 == v_u_play then
							v_u11 = nil
							return
						end
					else
						if v_u_play and v_u_play.Parent then
							v_u_play.Volume = v_u_volume * (v1 >= 4 and 0 or 1 - v1 * 0.225)
							return
						end
						if not (v_u_play and v_u_play.Parent) then
							if v_u12 then
								v_u12:Disconnect()
								v_u12 = nil
							end
							if v_u11 == v_u_play then
								v_u11 = nil
							end
						end
					end
				end)
			end
			local v_dot = v_lookvector:Dot(v1.Unit)
			local v3
			if v_dot >= 0 then
				v3 = 0.5 + 0.5 * v_dot
			else
				v3 = math.pow(v_dot + 1, 1.5) * 0.5
			end
			local v_u4 = (0.05 + 4.95 * v3) * (v_magnitude <= 20 and 1 or (v_magnitude >= 100 and 0 or 1 - (v_magnitude - 20) / 80))
			if v_u4 < 0.025 then
				return
			else
				local function v_u5()
					-- upvalues: (ref) v_u13, (copy) v_u4, (ref) v_u14, (ref) v_u9, (ref) v_u10, (ref) v_u_tween, (ref) v_u8, (ref) v_u3, (ref) v_u4, (ref) v_u5, (ref) v_u17, (ref) v_u_lighting, (ref) v_u6, (ref) v_u7, (ref) v_u15, (ref) v_u18
					local v_clock = os.clock()
					local v_min = math.min(5, (v_u13 and (math.max(0, v_u13 - v_clock) or 0) or 0) + v_u4)
					local v_max = math.max(v_u14 or 0, v_clock + 0.05 + v_u4 * 0.3)
					v_u14 = math.min(v_clock + v_min, v_max)
					if v_u4 >= 0.5 and v_u9 then
						if v_u10 then
							v_u10:Cancel()
							v_u10 = nil
						end
						v_u9.ImageTransparency = 0
						local v_u_create = v_u_tween:Create(v_u9, TweenInfo.new(v_min * 1.25 + 0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							["ImageTransparency"] = 1
						})
						v_u10 = v_u_create
						v_u_create:Play()
						v_u_create.Completed:Connect(function()
							-- upvalues: (ref) v_u8, (ref) v_u9, (ref) v_u10, (copy) v_u_create
							if v_u8 then
								v_u8:Destroy()
								v_u8 = nil
								v_u9 = nil
							end
							if v_u10 == v_u_create then
								v_u10 = nil
							end
						end)
					end
					local v1 = v_u3
					local v2 = v_u4
					local v3 = v_u5
					if not (v1 and v2) then
						v1, v2 = v_u17()
						v_u3 = v1
						v_u4 = v2
					end
					if not v3 then
						v3 = Instance.new("ColorCorrectionEffect")
						v3.Name = "FlashbangColorCorrection"
						v3.Brightness = 0
						v3.Contrast = 0
						v3.Saturation = 0
						v3.TintColor = Color3.new(1, 1, 1)
						v3.Parent = v_u_lighting
						v_u5 = v3
					end
					if v_u6 then
						v_u6:Cancel()
						v_u6 = nil
					end
					if v_u7 then
						v_u7:Cancel()
						v_u7 = nil
					end
					local v_create = v_u_tween:Create(v2, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["BackgroundTransparency"] = 0
					})
					local v_create = v_u_tween:Create(v3, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["Brightness"] = 1,
						["Saturation"] = -1
					})
					v_create:Play()
					v_create:Play()
					local v_u4 = v_u15 + 1
					task.spawn(function()
						-- upvalues: (ref) v_u18, (copy) v_u4
						v_u18(v_u4)
					end)
				end
				if v_u4 >= 0.5 then
					v_u1.CaptureScreenshot(function(arg1)
						-- upvalues: (ref) v_u10, (ref) v_u8, (ref) v_u_playergui, (ref) v_u9, (ref) v_u13, (ref) v_u_tween
						if v_u10 then
							v_u10:Cancel()
							v_u10 = nil
						end
						if v_u8 then
							if v_u9 then
								v_u9.Image = arg1
								v_u9.ImageTransparency = 0
							end
						else
							local v_screengui = Instance.new("ScreenGui")
							v_screengui.Name = "FlashScreenshot"
							v_screengui.DisplayOrder = 998
							v_screengui.IgnoreGuiInset = true
							v_screengui.ResetOnSpawn = false
							v_screengui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
							local v_imagelabel = Instance.new("ImageLabel")
							v_imagelabel.Name = "ScreenshotImage"
							v_imagelabel.Size = UDim2.new(1, 0, 1, 0)
							v_imagelabel.Position = UDim2.new(0, 0, 0, 0)
							v_imagelabel.BackgroundTransparency = 1
							v_imagelabel.BorderSizePixel = 0
							v_imagelabel.Image = arg1
							v_imagelabel.ImageTransparency = 0
							v_imagelabel.ScaleType = Enum.ScaleType.Fit
							v_imagelabel.ZIndex = 998
							v_imagelabel.Parent = v_screengui
							v_screengui.Parent = v_u_playergui
							v_u8 = v_screengui
							v_u9 = v_imagelabel
						end
						if v_u9 then
							local v_clock = os.clock()
							local v1 = ((not v_u13 or v_clock >= v_u13) and 0 or math.max(0, v_u13 - v_clock)) + 0.25
							if v_u10 then
								v_u10:Cancel()
								v_u10 = nil
							end
							local v_u_create = v_u_tween:Create(v_u9, TweenInfo.new(v1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								["ImageTransparency"] = 1
							})
							v_u10 = v_u_create
							v_u_create:Play()
							v_u_create.Completed:Connect(function()
								-- upvalues: (ref) v_u8, (ref) v_u9, (ref) v_u10, (copy) v_u_create
								if v_u8 then
									v_u8:Destroy()
									v_u8 = nil
									v_u9 = nil
								end
								if v_u10 == v_u_create then
									v_u10 = nil
								end
							end)
						end
					end):catch(function() end)
					task.delay(0.01, function()
						-- upvalues: (copy) v_u5
						v_u5()
					end)
				else
					v_u5()
				end
			end
		else
			return
		end
	end,
	["IsFlashed"] = function()
		-- upvalues: (ref) v_u13
		if v_u13 then
			return os.clock() < v_u13
		else
			return false
		end
	end
}