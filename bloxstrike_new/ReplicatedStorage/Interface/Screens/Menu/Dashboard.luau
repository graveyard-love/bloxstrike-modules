-- game.ReplicatedStorage.Interface.Screens.Menu.Dashboard

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_policy = game:GetService("PolicyService")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(v_u_replicatedstorage.Database.Custom.Types)
local v_u2 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_u_replicatedstorage.Components.Common.InterfaceAnimations.ActivateButton)
local v_u4 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u5 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u6 = require(v_u_replicatedstorage.Database.Custom.GameStats.Missions)
local v_u_localplayer = v_players.LocalPlayer
local v_u7 = { "News", "RedeemCode", "Verify" }
local v_u8 = { "Container" }
local v_u9 = nil
local v_u10 = false
local v_u11 = nil
local function v_u12(arg1, arg2)
	local v_getchildren = arg1:GetChildren()
	for _, v1 in ipairs(v_getchildren) do
		if v1:IsA("Frame") and not table.find(arg2, v1.ClassName) then
			v1:Destroy()
		end
	end
end
local function v_u13(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u6
	if not arg1 then
		return nil
	end
	local v_get = v_u2.Get(v_u_localplayer, "Missions")
	if not v_get then
		return nil
	end
	local v1 = os.time() * 1000
	local v2 = nil
	for _, v3 in ipairs(v_get) do
		local v_getmissiondefinition = v_u6.GetMissionDefinition(v3.MissionId)
		if v_getmissiondefinition and (v_getmissiondefinition.Type == arg1 and (v3.ExpiresAt > 0 and (v1 < v3.ExpiresAt and (not v2 or v3.ExpiresAt < v2)))) then
			v2 = v3.ExpiresAt
		end
	end
	return v2
end
function v_u1.CreateMissionTemplate(arg1, arg2)
	-- upvalues: (copy) v_u_replicatedstorage, (ref) v_u11, (copy) v_u3, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u5, (copy) v_u4
	local v_clone = v_u_replicatedstorage.Assets.UI.Missions.Template:Clone()
	v_clone.Bar.Progress.Size = UDim2.fromScale(math.min(arg2.Progress / arg2.Target, 1), 1)
	local v_gsub = tostring(arg2.Progress):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	v_clone.Progress.Text = v_gsub .. "/" .. tostring(arg2.Target):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	v_clone.Parent = v_u11.Holder.Missions.Container.Frame.Container
	v_clone.Button.Title.Text = arg2.IsClaimed and "CLAIMED" or "CLAIM"
	v_clone.Progress.Visible = arg2.Progress < arg2.Target
	v_clone.Button.Visible = arg2.Progress >= arg2.Target
	v_clone.Title.Text = arg1.MissionId
	v_clone.Name = arg2.MissionId
	v_clone:SetAttribute("Progress", arg2.Progress)
	v_clone:SetAttribute("Target", arg2.Target)
	if arg1.Rewards[1].type == "Credits" then
		v_clone.ItemTemplate.Amount.Text = tostring(arg1.Rewards[1].amount):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
		v_clone.ItemTemplate.Frame.Icon.Image = "rbxassetid://129921992230064"
	end
	v_u3(v_clone.Button)
	v_clone.Button.MouseButton1Click:Connect(function()
		-- upvalues: (copy) arg2, (ref) v_u2, (ref) v_u_localplayer, (ref) v_u5, (ref) v_u4
		local v_missionid = arg2.MissionId
		local v_get = v_u2.Get(v_u_localplayer, "Missions")
		local v2
		if v_get then
			for _, v2 in ipairs(v_get) do
				if v2.MissionId == v_missionid then
					goto l3
				end
			end
			v2 = nil
		else
			v2 = nil
		end
		::l3::
		v_u5.broadcastRouter("RunInterfaceSound", "UI Click")
		if v2 and not v2.IsClaimed then
			v_u4.Dashboard.MissionCompleted.Send(v2.MissionId)
		end
	end)
end
function v_u1.UpdateCurrentMissions(_)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (ref) v_u11, (copy) v_u_tween
	if not v_u2.Get(v_u_localplayer, "Missions") then
		return
	end
	for _, v1 in ipairs(v_u11.Holder.Missions.Container.Frame.Container:GetChildren()) do
		if v1:IsA("Frame") then
			local v_name = v1.Name
			local v_get = v_u2.Get(v_u_localplayer, "Missions")
			local v3
			if v_get then
				for _, v3 in ipairs(v_get) do
					if v3.MissionId == v_name then
						goto l8
					end
				end
				v3 = nil
			else
				v3 = nil
			end
			::l8::
			if v3 then
				local v_progress = v1:GetAttribute("Progress")
				local v_gsub = tostring(v3.Progress):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
				v1.Progress.Text = v_gsub .. "/" .. tostring(v3.Target):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
				v1.Button.Title.Text = v3.IsClaimed and "CLAIMED" or "CLAIM"
				v1.Progress.Visible = v3.Progress < v3.Target
				v1.Button.Visible = v3.Progress >= v3.Target
				v1.Visible = true
				v1:SetAttribute("Progress", v3.Progress)
				v1:SetAttribute("Target", v3.Target)
				if v_u11.Visible and v_progress < v3.Progress then
					local v_new = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
					v_u_tween:Create(v1.Bar.Progress, v_new, {
						["Size"] = UDim2.fromScale(math.min(v3.Progress / v3.Target, 1), 1)
					}):Play()
				else
					v1.Bar.Progress.Size = UDim2.fromScale(math.min(v3.Progress / v3.Target, 1), 1)
				end
			else
				v1:Destroy()
			end
		end
	end
end
function v_u1.OpenMissionFrame(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (ref) v_u9, (copy) v_u12, (ref) v_u11, (copy) v_u6, (copy) v_u1
	local v_get = v_u2.Get(v_u_localplayer, "Missions")
	if v_u9 ~= arg1 then
		v_u9 = arg1
		if v_get then
			v_u12(v_u11.Holder.Missions.Container.Frame.Container, { "UIListLayout" })
			for _, v1 in ipairs(v_get) do
				local v_getmissiondefinition = v_u6.GetMissionDefinition(v1.MissionId)
				if v_getmissiondefinition and v_getmissiondefinition.Type == arg1 then
					v_u1.CreateMissionTemplate(v_getmissiondefinition, v1)
				end
			end
		end
	end
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u11, (copy) v_u_policy, (copy) v_u_localplayer, (copy) v_u3, (copy) v_u5, (copy) v_u4, (copy) v_u2, (copy) v_u7, (copy) v_u_tween
	arg2.Holder.Advertisement.Visible = false
	local v1, v2 = pcall(function(...)
		-- upvalues: (ref) v_u_policy, (ref) v_u_localplayer
		return v_u_policy:GetPolicyInfoForPlayerAsync(v_u_localplayer)
	end)
	if v1 and (v2 and v2.AllowedExternalLinkReferences) then
		local v_u3 = table.find(v2.AllowedExternalLinkReferences, "Discord") ~= nil
		v_u11.Holder.Advertisement.Visible = v_u3 or false
		v_u11.Holder.Advertisement:GetPropertyChangedSignal("Visible"):Connect(function()
			-- upvalues: (ref) v_u11, (copy) v_u3, (copy) arg1
			if not v_u11.Holder.Advertisement.Visible then
				local v_advertisement = v_u11.Holder.Advertisement
				local v1 = v_u3
				if v1 then
					v1 = arg1.Menu.Dashboard.Visible
				end
				v_advertisement.Visible = v1
			end
		end)
		arg1.Menu.Dashboard:GetPropertyChangedSignal("Visible"):Connect(function()
			-- upvalues: (copy) v_u3, (copy) arg1, (ref) v_u11
			local v1 = v_u3
			if v1 then
				v1 = arg1.Menu.Dashboard.Visible
			end
			if v_u11.Holder.Advertisement.Visible ~= v1 then
				v_u11.Holder.Advertisement.Visible = v1
			end
		end)
	end
	v_u3(v_u11.Container.Reward.Frame.Button)
	v_u11.Container.Reward.Frame.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u5, (ref) v_u4
		v_u5.broadcastRouter("RunInterfaceSound", "UI Click")
		v_u4.Dashboard.RedeemLikeAndFavoriteReward.Send()
	end)
	v_u3(v_u11.Container.RedeemCode.Frame.Button)
	v_u11.Container.RedeemCode.Frame.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u2, (ref) v_u_localplayer, (ref) v_u5, (ref) v_u11, (ref) v_u4
		local v_get = v_u2.Get(v_u_localplayer, "Level")
		v_u5.broadcastRouter("RunInterfaceSound", "UI Click")
		if v_get.Level >= 5 then
			local v_text = v_u11.Container.RedeemCode.Frame.Container.Holder.TextBox.Text
			if tostring(v_text) == "" then
				v_u5.broadcastRouter("CreateMenuNotification", "Error", "Invalid code. Please try again.")
			else
				v_u11.Container.RedeemCode.Frame.Container.Holder.TextBox.Text = ""
				v_u4.Dashboard.RedeemCode.Send(v_text)
			end
		else
			v_u5.broadcastRouter("CreateMenuNotification", "Error", "You need to be atleast level 5 to redeem codes.")
			return
		end
	end)
	for _, v4 in ipairs(v_u11.Container:GetChildren()) do
		if v4:IsA("Frame") then
			v4.Visible = table.find(v_u7, v4.Name)
		end
	end
	local v_u_container = v_u11.Holder.Missions.Container
	local v_u_hide = v_u_container.Hide
	local v_u_position = v_u_container.Position
	local v_u_new = UDim2.new(1.49, v_u_position.X.Offset, v_u_position.Y.Scale, v_u_position.Y.Offset)
	local v_u5 = false
	v_u_container.Position = v_u_position
	v_u_hide.Rotation = 180
	v_u_hide.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u5, (ref) v_u_tween, (copy) v_u_container, (copy) v_u_new, (copy) v_u_hide, (copy) v_u_position
		if v_u5 then
			v_u_tween:Create(v_u_container, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				["Position"] = v_u_position
			}):Play()
			v_u_hide.Rotation = 180
		else
			v_u_tween:Create(v_u_container, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				["Position"] = v_u_new
			}):Play()
			v_u_hide.Rotation = 0
		end
	end)
end
function v_u1.Start()
	-- upvalues: (ref) v_u11, (copy) v_u3, (copy) v_u1, (copy) v_u8, (copy) v_u_run, (ref) v_u9, (copy) v_u13, (copy) v_u2, (copy) v_u_localplayer, (ref) v_u10
	for _, v_u1 in ipairs(v_u11.Holder.Missions.Container.Frame.Bottom.Container:GetChildren()) do
		if v_u1:IsA("TextButton") then
			v_u3(v_u1)
			v_u1.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u1, (copy) v_u1
				v_u1.OpenMissionFrame(v_u1.Name)
			end)
		end
	end
	for _, v2 in ipairs(v_u11.Holder:GetChildren()) do
		if v2:IsA("Frame") and v2.Name ~= "Advertisement" then
			v2.Visible = table.find(v_u8, v2.Name)
		end
	end
	v_u_run.Heartbeat:Connect(function(_)
		-- upvalues: (ref) v_u9, (ref) v_u13, (ref) v_u11
		if v_u9 then
			local v1 = v_u13(v_u9)
			v_u11.Holder.Missions.Container.Frame.Header.Title.Text = ("%* MISSIONS"):format((string.upper(v_u9)))
			if v1 then
				local v_floor = math.floor(math.max(0, v1 - os.time() * 1000) / 1000)
				v_u11.Holder.Missions.Container.Frame.Header.Timer.TextColor3 = v_floor > 600 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 85, 85)
				local v_floor = math.floor(v_floor / 86400)
				local v_floor = math.floor(v_floor % 86400 / 3600)
				v_u11.Holder.Missions.Container.Frame.Header.Timer.Text = string.format("%i:%02i:%02i:%02i", v_floor, v_floor, math.floor(v_floor % 3600 / 60), v_floor % 60)
			else
				v_u11.Holder.Missions.Container.Frame.Header.Timer.TextColor3 = Color3.fromRGB(255, 85, 85)
				v_u11.Holder.Missions.Container.Frame.Header.Timer.Text = string.format("%i:%02i:%02i:%02i", 0, 0, 0, 0)
			end
		else
			v_u11.Holder.Missions.Container.Frame.Header.Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
			v_u11.Holder.Missions.Container.Frame.Header.Timer.Text = string.format("%i:%02i:%02i:%02i", 0, 0, 0, 0)
			v_u11.Holder.Missions.Container.Frame.Header.Title.Text = "MISSIONS"
			return
		end
	end)
	v_u2.CreateListener(v_u_localplayer, "Missions", function(arg1)
		-- upvalues: (ref) v_u10, (ref) v_u1
		if v_u10 then
			v_u1.UpdateCurrentMissions(arg1)
		else
			v_u1.OpenMissionFrame("hourly")
			v_u10 = true
		end
	end)
	v_u2.CreateListener(v_u_localplayer, "LikeAndFavoriteReward", function(arg1)
		-- upvalues: (ref) v_u11
		v_u11.Container.Reward.Visible = not arg1
	end)
end
return v_u1