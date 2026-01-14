-- game.ReplicatedFirst.Provider

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_replicatedfirst = game:GetService("ReplicatedFirst")
local v_u_contentprovider = game:GetService("ContentProvider")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u1 = require(v_u_replicatedstorage:WaitForChild("Shared"):WaitForChild("Janitor"))
local v_playergui = v_u_localplayer:WaitForChild("PlayerGui")
v_playergui.ScreenOrientation = Enum.ScreenOrientation.LandscapeSensor
local v_u_loader = script:WaitForChild("Loader")
local v_u_loading_profile = "Loading Profile"
local v_u2 = 0
local v_u3 = 0
local v_u4 = false
local v_u5 = 0
local v_u_frame = Instance.new("Frame")
v_u_frame.Name = "InputBlocker"
v_u_frame.Size = UDim2.new(1, 0, 1, 0)
v_u_frame.Position = UDim2.new(0, 0, 0, 0)
v_u_frame.BackgroundTransparency = 1
v_u_frame.Active = true
v_u_frame.ZIndex = 6767
v_u_frame.Parent = v_u_loader
v_replicatedfirst:RemoveDefaultLoadingScreen()
v_u_loader.Parent = v_playergui
local function v_u6(arg1)
	repeat
		task.wait()
	until arg1()
end
local function v_u7(self)
	-- upvalues: (ref) v_u4, (copy) v_u_loader, (copy) v_u_tween
	if not v_u4 then
		v_u4 = true
		for _, v1 in ipairs(v_u_loader:GetDescendants()) do
			if v1:IsA("TextLabel") and (v1.Visible and v1.TextTransparency > 0) then
				v_u_tween:Create(v1, TweenInfo.new(0.95), {
					["TextTransparency"] = 1
				}):Play()
			elseif v1:IsA("ImageLabel") and (v1.Visible and v1.ImageTransparency > 0) then
				v_u_tween:Create(v1, TweenInfo.new(0.95), {
					["ImageTransparency"] = 1
				}):Play()
			elseif v1:IsA("Frame") and (v1.Visible and v1.BackgroundTransparency > 0) then
				v_u_tween:Create(v1, TweenInfo.new(0.95), {
					["BackgroundTransparency"] = 1
				}):Play()
			end
		end
		task.delay(1, function()
			-- upvalues: (copy) self
			self:Destroy()
		end)
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_contentprovider, (copy) v_u_loader
	v_u_contentprovider:PreloadAsync(v_u_loader:GetDescendants())
end)
task.spawn(function()
	-- upvalues: (copy) v_u1, (copy) v_u_frame, (copy) v_u_loader, (copy) v_u_run, (ref) v_u3, (ref) v_u_loading_profile, (ref) v_u2, (ref) v_u5, (copy) v_u6, (copy) v_u_localplayer, (ref) v_u4, (copy) v_u7, (copy) v_u_replicatedstorage, (copy) v_u_contentprovider
	local v_u_new = v_u1.new()
	v_u_new:Add(v_u_frame)
	v_u_new:Add(v_u_loader)
	local v_u1 = tick()
	local v_u2 = tick()
	local v_u3 = 0
	v_u_new:Add((v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u3, (ref) v_u_loading_profile, (ref) v_u2, (ref) v_u2, (ref) v_u_loader, (ref) v_u3, (ref) v_u1, (ref) v_u5
		local v1 = 25
		local v2 = tick()
		if v_u3 > 0 and v_u_loading_profile == "Loading Assets" then
			local v_min = math.min(v_u2, v_u3)
			v_u_loader.LoadingScreen.Title.Text = ("Loading Assets (%*/%*)"):format(v_min, v_u3)
			v_u_loader.LoadingScreen.Title.TextTransparency = 1 - v_min / v_u3
			v_u_loader.LoadingScreen.Icon.ImageTransparency = 1 - v_min / v_u3
			if v2 - v_u2 > 0 then
				v1 = math.min(25 + (v_u2 - v_u3) / UNNAMED_2189196774984 * 2, 95)
			end
			v_u3 = v_u2
			v_u2 = v2
		else
			if v2 - v_u1 >= 0.35 then
				v_u5 = (v_u5 + 1) % 3
				v_u1 = v2
			end
			v_u_loader.LoadingScreen.Title.Text = "Loading Profile" .. string.rep(".", v_u5 + 1)
			v_u_loader.LoadingScreen.Title.TextTransparency = 0
		end
		v_u_loader.LoadingScreen.Extra.Progress.Rotation = v_u_loader.LoadingScreen.Extra.Progress.Rotation + arg1 * v1
	end)))
	v_u6(function()
		-- upvalues: (ref) v_u_localplayer
		return v_u_localplayer:GetAttribute("DataLoaded")
	end)
	task.delay(4, function()
		-- upvalues: (ref) v_u4, (ref) v_u7, (copy) v_u_new
		if not v_u4 then
			v_u7(v_u_new)
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_replicatedstorage, (ref) v_u_loading_profile, (ref) v_u3, (ref) v_u_contentprovider, (ref) v_u2
		local v_getdescendants = v_u_replicatedstorage:WaitForChild("Assets"):GetDescendants()
		v_u_loading_profile = "Loading Assets"
		v_u3 = #v_getdescendants
		v_u_contentprovider:PreloadAsync(v_getdescendants, function()
			-- upvalues: (ref) v_u2
			v_u2 = v_u2 + 1
		end)
	end)
end)