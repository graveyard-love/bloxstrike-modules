-- game.ReplicatedStorage.Controllers.EndScreenController

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_players = game:GetService("Players")
local v2 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u3 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u4 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
local v_u5 = require(v_u_replicatedstorage.Database.Components.Libraries.Cases)
local v_u6 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u7 = require(v_u_replicatedstorage.Controllers.SpectateController)
local v_u8 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u9 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u10 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u11 = require(v_u_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u12 = require(v_u_replicatedstorage.Database.Custom.GameStats.LevelsIcon)
local v_u13 = require(v_u_replicatedstorage.Classes.Sound)
local v_u_angles = CFrame.Angles(-1.5707963267948966, 0, 0)
local v_u_new = CFrame.new(0, 0, -0.025)
local v_u14 = CFrame.new(-0.251, 0.806, -0.406) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)
local v_u15 = {
	{
		["maxLevel"] = 5,
		["title"] = "Recruit"
	},
	{
		["maxLevel"] = 10,
		["title"] = "Private"
	},
	{
		["maxLevel"] = 15,
		["title"] = "Corporal"
	},
	{
		["maxLevel"] = 20,
		["title"] = "Sergeant"
	},
	{
		["maxLevel"] = 25,
		["title"] = "Master Sergeant"
	},
	{
		["maxLevel"] = 30,
		["title"] = "Lieutenant"
	},
	{
		["maxLevel"] = 35,
		["title"] = "Captain"
	},
	{
		["maxLevel"] = 40,
		["title"] = "Global Elite"
	}
}
local v_u_localplayer = v_u_players.LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u_current_camera = workspace.CurrentCamera
local v_u_characters = v_u_replicatedstorage.Assets.Characters
local v_u16 = {
	{
		["Entrance"] = "rbxassetid://100747011940776",
		["Idle"] = "rbxassetid://100747011940776"
	},
	{
		["Entrance"] = "rbxassetid://103701913618746",
		["Idle"] = "rbxassetid://100955283476946"
	},
	{
		["Entrance"] = "rbxassetid://91396952135880",
		["Idle"] = "rbxassetid://120200138438261"
	},
	{
		["Entrance"] = "rbxassetid://136102955582599",
		["Idle"] = "rbxassetid://74544097369437"
	},
	{
		["Entrance"] = "rbxassetid://71439100344953",
		["Idle"] = "rbxassetid://122693948164334"
	}
}
local v_u17 = {
	["CT"] = {
		["Character"] = "IDF",
		["Weapon"] = "M4A1-S",
		["Glove"] = "CT Glove"
	},
	["T"] = {
		["Character"] = "Anarchist",
		["Weapon"] = "AK-47",
		["Glove"] = "T Glove"
	}
}
local v_u18 = {
	["Counter-Terrorists"] = "CT",
	["Terrorists"] = "T"
}
local v_u19 = {
	["Right Arm"] = "RightGlove",
	["Left Arm"] = "LeftGlove"
}
local v_u20 = {
	["Right Arm"] = "RightHand",
	["Left Arm"] = "LeftHand"
}
local v_u_new = v2.new()
local v_u21 = false
local v_u22 = 0
local v_u23 = nil
local function v_u24()
	-- upvalues: (copy) v_u_localplayer
	local v_debris = workspace:FindFirstChild("Debris")
	if v_debris then
		for _, v1 in v_debris:GetChildren() do
			v1:Destroy()
		end
	end
	local v_characters = workspace:FindFirstChild("Characters")
	if v_characters then
		for _, v2 in v_characters:GetChildren() do
			if v2:IsA("Folder") then
				for _, v3 in v2:GetChildren() do
					v3:Destroy()
				end
			end
		end
	end
	if v_u_localplayer.Character then
		v_u_localplayer.Character:Destroy()
	end
end
local function v_u25(arg1, arg2)
	if arg1:IsA("TextLabel") or arg1:IsA("TextButton") then
		arg1.TextTransparency = arg2
		return
	elseif arg1:IsA("ImageLabel") or arg1:IsA("ImageButton") then
		arg1.ImageTransparency = arg2
		return
	elseif arg1:IsA("Frame") then
		arg1.BackgroundTransparency = arg2
	elseif arg1:IsA("UIStroke") then
		arg1.Transparency = arg2
	end
end
local function v_u26(arg1, arg2)
	-- upvalues: (copy) v_u_tween
	local v_new = TweenInfo.new(0.5)
	if arg1:IsA("TextLabel") or arg1:IsA("TextButton") then
		v_u_tween:Create(arg1, v_new, {
			["TextTransparency"] = arg2
		}):Play()
		return
	elseif arg1:IsA("ImageLabel") or arg1:IsA("ImageButton") then
		v_u_tween:Create(arg1, v_new, {
			["ImageTransparency"] = arg2
		}):Play()
		return
	elseif arg1:IsA("Frame") then
		v_u_tween:Create(arg1, v_new, {
			["BackgroundTransparency"] = arg2
		}):Play()
	elseif arg1:IsA("UIStroke") then
		v_u_tween:Create(arg1, v_new, {
			["Transparency"] = arg2
		}):Play()
	end
end
local function v_u27(arg1)
	if arg1:GetAttribute("SkipFade") then
		return true
	end
	local v_parent = arg1.Parent
	while v_parent and v_parent:IsA("GuiObject") do
		if v_parent:GetAttribute("SkipFade") then
			return true
		end
		v_parent = v_parent.Parent
	end
	return false
end
local function v_u28(arg1, arg2)
	-- upvalues: (copy) v_u27, (copy) v_u_tween, (copy) v_u26
	local v1
	if v_u27(arg1) then
		v1 = nil
	else
		v1 = v_u_tween:Create(arg1, TweenInfo.new(0.5), {
			["BackgroundTransparency"] = arg2
		})
	end
	for _, v2 in arg1:GetDescendants() do
		if not v_u27(v2) then
			v_u26(v2, arg2)
		end
	end
	if v1 then
		v1:Play()
	end
	return v1
end
local function v_u29(arg1)
	-- upvalues: (copy) v_u27, (copy) v_u25, (copy) v_u28
	if not v_u27(arg1) then
		arg1.BackgroundTransparency = 1
	end
	for _, v1 in arg1:GetDescendants() do
		if not v_u27(v1) then
			v_u25(v1, 1)
		end
	end
	arg1.Visible = true
	return v_u28(arg1, 0)
end
local function v_u30(arg1)
	local v1 = {}
	for _, v2 in arg1:GetDescendants() do
		if v2:IsA("UIStroke") then
			v1[v2] = v2.Transparency
		end
	end
	return {
		["BackgroundTransparency"] = arg1.BackgroundTransparency,
		["Strokes"] = v1
	}
end
local function v_u31(arg1)
	-- upvalues: (copy) v_u_playergui, (ref) v_u23, (copy) v_u8, (copy) v_u_localplayer, (copy) v_u15, (copy) v_u12, (copy) v_u30
	local v_maingui = v_u_playergui:FindFirstChild("MainGui")
	local v1
	if v_maingui then
		local v_gameplay = v_maingui:FindFirstChild("Gameplay")
		if v_gameplay then
			v1 = v_gameplay:FindFirstChild("Middle")
		else
			v1 = nil
		end
	else
		v1 = nil
	end
	local v2
	if v1 then
		v2 = v1:FindFirstChild("EndScreen")
	else
		v2 = nil
	end
	if not v2 then
		return nil
	end
	local v_level = v2:FindFirstChild("Level")
	if not v_level then
		return nil
	end
	local v3 = v_u23 or v_u8.Get(v_u_localplayer, "Level")
	if not v3 then
		return nil
	end
	local v4 = v3.Level or 1
	local v5 = v3.Experience or 0
	local v6 = v3.NextExperienceRequirement or 1000
	local v_textlabel = v_level:FindFirstChild("TextLabel")
	if not v_textlabel then
		::l18::
		local v_rank = v_level:FindFirstChild("Rank")
		if v_rank then
			v_rank.Image = v_u12[tostring(v4)] or ""
		end
		local v_levelbar = v_level:FindFirstChild("LevelBar")
		if not v_levelbar then
			return nil
		end
		local v_current = v_levelbar:FindFirstChild("Current")
		local v_earned = v_levelbar:FindFirstChild("Earned")
		if not (v_current and v_earned) then
			return nil
		end
		local v_currentinfo = v_level:FindFirstChild("CurrentInfo", true)
		local v_earnedinfo = v_level:FindFirstChild("EarnedInfo", true)
		if not (v_currentinfo and v_earnedinfo) then
			return nil
		end
		v_current:SetAttribute("SkipFade", true)
		v_earned:SetAttribute("SkipFade", true)
		v_currentinfo:SetAttribute("SkipFade", true)
		v_earnedinfo:SetAttribute("SkipFade", true)
		local v_format = ("%*xp"):format(v5)
		local v_amount = v_currentinfo:FindFirstChild("Amount")
		if v_amount then
			v_amount.Text = v_format
		end
		local v_format = ("+%*xp"):format(arg1)
		local v_amount = v_earnedinfo:FindFirstChild("Amount")
		if v_amount then
			v_amount.Text = v_format
		end
		local v7 = v_u30(v_currentinfo)
		local v8 = v_u30(v_earnedinfo)
		return {
			["currentXP"] = v5,
			["xpEarned"] = arg1,
			["nextLevelXP"] = math.max(v6, 1),
			["currentLevel"] = v4,
			["barHeight"] = v_current.Size.Y,
			["levelBar"] = v_levelbar,
			["levelFrame"] = v_level,
			["currentBar"] = v_current,
			["earnedBar"] = v_earned,
			["currentInfo"] = v_currentinfo,
			["earnedInfo"] = v_earnedinfo,
			["currentInfoTransparency"] = v7,
			["earnedInfoTransparency"] = v8
		}
	end
	local v9 = "[%* Rank %*]"
	for _, v10 in ipairs(v_u15) do
		if v4 <= v10.maxLevel then
			v_global_elite = v10.title
			::l22::
			v_textlabel.Text = v9:format(v_global_elite, v4)
			goto l18
		end
	end
	local v_global_elite = "Global Elite"
	goto l22
end
local function v_u32(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_tween
	local v_position = arg1.Position
	local v_parent = arg1.Parent
	return v_u_tween:Create(arg1, arg4, {
		["Position"] = UDim2.new(0, arg2.AbsolutePosition.X + arg3 * arg2.AbsoluteSize.X - (v_parent and v_parent.AbsolutePosition.X or 0) + arg1.AnchorPoint.X * arg1.AbsoluteSize.X, v_position.Y.Scale, v_position.Y.Offset)
	})
end
local function v_u33(arg1, arg2, arg3, arg4, arg5)
	if arg2.Parent.AbsolutePosition.X + arg3 - arg2.AnchorPoint.X * arg2.AbsoluteSize.X < arg1.AbsolutePosition.X + arg1.AbsoluteSize.X + 5 then
		return UDim2.new(0, arg3, arg4, arg5 + (arg1.AbsoluteSize.Y / 2 + 5))
	end
	local v_position = arg1.Position
	return UDim2.new(0, arg3, v_position.Y.Scale, v_position.Y.Offset)
end
local function v_u34(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	-- upvalues: (copy) v_u33, (copy) v_u_tween
	local v_parent = arg1.Parent
	return v_u_tween:Create(arg1, arg5, {
		["Position"] = v_u33(arg2, arg1, arg3.AbsolutePosition.X + arg4 * arg3.AbsoluteSize.X - (v_parent and v_parent.AbsolutePosition.X or 0) + arg1.AnchorPoint.X * arg1.AbsoluteSize.X, arg6, arg7)
	})
end
local function v_u35(arg1)
	-- upvalues: (ref) v_u21, (copy) v_u_tween, (copy) v_u32, (copy) v_u13, (copy) v_u_current_camera, (copy) v_u33, (copy) v_u34, (copy) v_u15, (copy) v_u12
	if not v_u21 then
		return
	end
	local v_clamp = math.clamp(arg1.currentXP / arg1.nextLevelXP, 0, 1)
	local v1 = arg1.currentXP + arg1.xpEarned
	local v_clamp = math.clamp(v1 / arg1.nextLevelXP, 0, 1)
	local v2 = arg1.nextLevelXP <= v1
	arg1.currentBar.Visible = false
	arg1.earnedBar.Visible = false
	local v_barheight = arg1.barHeight
	arg1.currentBar.Size = UDim2.new(0, 0, v_barheight.Scale, v_barheight.Offset)
	local v_barheight = arg1.barHeight
	arg1.earnedBar.Size = UDim2.new(0, 0, v_barheight.Scale, v_barheight.Offset)
	arg1.currentInfo.Visible = false
	arg1.earnedInfo.Visible = false
	local v_currentinfotransparency = arg1.currentInfoTransparency
	arg1.currentInfo.BackgroundTransparency = v_currentinfotransparency.BackgroundTransparency
	for v3, v4 in pairs(v_currentinfotransparency.Strokes) do
		if v3 and v3.Parent then
			v3.Transparency = v4
		end
	end
	local v_earnedinfotransparency = arg1.earnedInfoTransparency
	arg1.earnedInfo.BackgroundTransparency = v_earnedinfotransparency.BackgroundTransparency
	for v5, v6 in pairs(v_earnedinfotransparency.Strokes) do
		if v5 and v5.Parent then
			v5.Transparency = v6
		end
	end
	local v_levelbar = arg1.levelBar
	local v_parent = arg1.currentInfo.Parent
	local v_levelbar = arg1.levelBar
	local v_earnedinfo = arg1.earnedInfo
	local v_parent = v_earnedinfo.Parent
	local v_position = arg1.currentInfo.Position
	local v_position = arg1.earnedInfo.Position
	arg1.currentInfo.Position = UDim2.new(0, v_levelbar.AbsolutePosition.X + 0 * v_levelbar.AbsoluteSize.X - (v_parent and v_parent.AbsolutePosition.X or 0) + UNNAMED_2189156554952.AnchorPoint.X * UNNAMED_2189156554952.AbsoluteSize.X, v_position.Y.Scale, v_position.Y.Offset)
	arg1.earnedInfo.Position = UDim2.new(0, v_levelbar.AbsolutePosition.X + 0 * v_levelbar.AbsoluteSize.X - (v_parent and v_parent.AbsolutePosition.X or 0) + v_earnedinfo.AnchorPoint.X * v_earnedinfo.AbsoluteSize.X, v_position.Y.Scale, v_position.Y.Offset)
	task.wait(0.5)
	if not v_u21 then
		return
	end
	arg1.currentBar.Visible = true
	arg1.currentInfo.Visible = true
	if v_clamp > 0 then
		local v_new = TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local v7 = {}
		local v_barheight = arg1.barHeight
		v7.Size = UDim2.new(v_clamp, 0, v_barheight.Scale, v_barheight.Offset)
		local v_create = v_u_tween:Create(arg1.currentBar, v_new, v7)
		local v8 = v_u32(arg1.currentInfo, arg1.levelBar, v_clamp, v_new)
		v_u13.new("Interface"):play({
			["Parent"] = v_u_current_camera,
			["Name"] = "XP Bar Fill"
		})
		v_create:Play()
		v8:Play()
		v_create.Completed:Wait()
		if not v_u21 then
			return
		end
	end
	if arg1.xpEarned <= 0 then
		return
	end
	task.wait(0.6)
	if not v_u21 then
		return
	end
	local v_barheight = arg1.barHeight
	arg1.earnedBar.Size = UDim2.new(v_clamp, 0, v_barheight.Scale, v_barheight.Offset)
	arg1.earnedBar.Visible = true
	arg1.earnedInfo.Visible = true
	local v_levelbar = arg1.levelBar
	local v_earnedinfo = arg1.earnedInfo
	local v_parent = v_earnedinfo.Parent
	local v9 = v_u33(arg1.currentInfo, arg1.earnedInfo, v_levelbar.AbsolutePosition.X + v_clamp * v_levelbar.AbsoluteSize.X - (v_parent and v_parent.AbsolutePosition.X or 0) + v_earnedinfo.AnchorPoint.X * v_earnedinfo.AbsoluteSize.X, v_position.Y.Scale, v_position.Y.Offset)
	arg1.earnedInfo.Position = v9
	if not v2 then
		local v_new = TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local v10 = {}
		local v_barheight = arg1.barHeight
		v10.Size = UDim2.new(v_clamp, 0, v_barheight.Scale, v_barheight.Offset)
		local v_create = v_u_tween:Create(arg1.earnedBar, v_new, v10)
		local v11 = v_u34(arg1.earnedInfo, arg1.currentInfo, arg1.levelBar, v_clamp, v_new, v_position.Y.Scale, v_position.Y.Offset)
		local v_play = v_u13.new("Interface"):play({
			["Parent"] = v_u_current_camera,
			["Name"] = "XP Bar Fill"
		})
		if v_play then
			v_play.PlaybackSpeed = 1.15
		end
		v_create:Play()
		v11:Play()
		v_create.Completed:Wait()
		return
	end
	local v_new = TweenInfo.new(0.375, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local v12 = {}
	local v_barheight = arg1.barHeight
	v12.Size = UDim2.new(1, 0, v_barheight.Scale, v_barheight.Offset)
	local v_create = v_u_tween:Create(arg1.earnedBar, v_new, v12)
	local v13 = v_u34(arg1.earnedInfo, arg1.currentInfo, arg1.levelBar, 1, v_new, v_position.Y.Scale, v_position.Y.Offset)
	local v_play = v_u13.new("Interface"):play({
		["Parent"] = v_u_current_camera,
		["Name"] = "XP Bar Fill"
	})
	if v_play then
		v_play.PlaybackSpeed = 1.15
	end
	v_create:Play()
	v13:Play()
	v_create.Completed:Wait()
	if not v_u21 then
		return
	end
	v_u13.new("Interface"):play({
		["Parent"] = v_u_current_camera,
		["Name"] = "Level Up"
	})
	local v_clamp = math.clamp((v1 - arg1.nextLevelXP) / arg1.nextLevelXP, 0, 1)
	local v14 = arg1.currentLevel + 1
	local v_textlabel = arg1.levelFrame:FindFirstChild("TextLabel")
	if not v_textlabel then
		::l41::
		local v_rank = arg1.levelFrame:FindFirstChild("Rank")
		if v_rank then
			v_rank.Image = v_u12[tostring(v14)] or ""
		end
		local v_barheight = arg1.barHeight
		arg1.currentBar.Size = UDim2.new(0, 0, v_barheight.Scale, v_barheight.Offset)
		local v_barheight = arg1.barHeight
		arg1.earnedBar.Size = UDim2.new(0, 0, v_barheight.Scale, v_barheight.Offset)
		arg1.currentInfo.Visible = false
		local v_levelbar = arg1.levelBar
		local v_earnedinfo = arg1.earnedInfo
		local v_parent = v_earnedinfo.Parent
		arg1.earnedInfo.Position = UDim2.new(0, v_levelbar.AbsolutePosition.X + 0 * v_levelbar.AbsoluteSize.X - (v_parent and v_parent.AbsolutePosition.X or 0) + v_earnedinfo.AnchorPoint.X * v_earnedinfo.AbsoluteSize.X, v_position.Y.Scale, v_position.Y.Offset)
		local v15 = {}
		local v_barheight = arg1.barHeight
		v15.Size = UDim2.new(v_clamp, 0, v_barheight.Scale, v_barheight.Offset)
		local v_create = v_u_tween:Create(arg1.earnedBar, v_new, v15)
		local v16 = v_u32(arg1.earnedInfo, arg1.levelBar, v_clamp, v_new)
		v_create:Play()
		v16:Play()
		v_create.Completed:Wait()
		return
	end
	local v17 = "[%* Rank %*]"
	for _, v18 in ipairs(v_u15) do
		if v14 <= v18.maxLevel then
			v_global_elite = v18.title
			::l45::
			v_textlabel.Text = v17:format(v_global_elite, v14)
			goto l41
		end
	end
	local v_global_elite = "Global Elite"
	goto l45
end
local function v_u36(arg1)
	-- upvalues: (copy) v_u5, (copy) v_u4
	local v1 = not arg1.Type and "" or string.lower(arg1.Type)
	local v_name = arg1.Name
	if v1 == "credits" then
		return "rbxassetid://115958498634807"
	end
	if v1 == "case" or (v1 == "sticker capsule" or (v1 == "charm pack" or v1 == "charm capsule")) then
		local v_getcasebyname = v_u5.GetCaseByName(v_name)
		if v_getcasebyname and v_getcasebyname.imageAssetId then
			return v_getcasebyname.imageAssetId
		end
	end
	local v2 = arg1.Skin and (v_name and v_u4.GetSkinInformation(v_name, arg1.Skin))
	if v2 then
		if v2.wearImages and v2.wearImages[1] then
			return v2.wearImages[1].assetId
		end
		if v2.charmImages and v2.charmImages[1] then
			return v2.charmImages[1].assetId
		end
		if v2.imageAssetId then
			return v2.imageAssetId
		end
	end
	return "rbxassetid://18822070027"
end
local function v_u37(arg1)
	-- upvalues: (ref) v_u21, (copy) v_u_playergui, (copy) v_u36, (copy) v_u11, (copy) v_u29, (copy) v_u_tween, (copy) v_u_new
	if v_u21 and (arg1 and #arg1 ~= 0) then
		local v_maingui = v_u_playergui:FindFirstChild("MainGui")
		local v1
		if v_maingui then
			local v_gameplay = v_maingui:FindFirstChild("Gameplay")
			if v_gameplay then
				v1 = v_gameplay:FindFirstChild("Middle")
			else
				v1 = nil
			end
		else
			v1 = nil
		end
		local v2
		if v1 then
			v2 = v1:FindFirstChild("EndScreen")
		else
			v2 = nil
		end
		if v2 then
			local v_drops = v2:FindFirstChild("Drops")
			local v3
			if v_drops then
				v3 = v_drops:FindFirstChild("Container")
			else
				v3 = v_drops
			end
			local v4
			if v3 then
				v4 = v3:FindFirstChild("ItemTemplate")
			else
				v4 = v3
			end
			if v4 then
				v3:SetAttribute("SkipFade", true)
				v4.Visible = false
				for _, v5 in v3:GetChildren() do
					if v5:IsA("Frame") and v5.Name ~= "ItemTemplate" then
						v5:Destroy()
					end
				end
				v_drops.Visible = false
				task.wait(0.8)
				if v_u21 then
					local v6 = {}
					for v7, v8 in ipairs(arg1) do
						local v9 = v8.type == "credits"
						local v_inventoryitem = v8.inventoryItem
						if v9 or v_inventoryitem then
							local v_clone = v4:Clone()
							v_clone.Name = "Drop_" .. v7
							v_clone.Visible = false
							v_clone.Parent = v3
							local v_content = v_clone:FindFirstChild("Content")
							if v_content then
								local v_icon = v_content:FindFirstChild("Icon")
								if v_icon then
									v_icon.Image = v9 and "rbxassetid://115958498634807" or v_u36(v_inventoryitem)
								end
								local v_rarityframe = v_content:FindFirstChild("RarityFrame")
								if v_rarityframe then
									v_rarityframe = v_rarityframe:FindFirstChild("UIGradient")
								end
								if v_rarityframe then
									if v9 then
										v_inventoryitem = "Rare"
									elseif v_inventoryitem then
										v_inventoryitem = v_inventoryitem.Rarity
									end
									if v_inventoryitem then
										local v10 = v_u11[v_inventoryitem]
										if v10 and v10.ColorSequence then
											v_rarityframe.Color = v10.ColorSequence
										end
									end
								end
								local v_size = v_content.Size
								v_content.Size = UDim2.new(v_size.X.Scale * 1.25, v_size.X.Offset * 1.25, v_size.Y.Scale * 1.25, v_size.Y.Offset * 1.25)
								table.insert(v6, {
									["item"] = v_clone,
									["content"] = v_content,
									["originalSize"] = v_size
								})
							else
								v_clone:Destroy()
							end
						end
					end
					if #v6 == 0 then
						return
					else
						v_u29(v_drops)
						task.wait(0.5)
						if v_u21 then
							local v_u_new = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
							for v11, v_u12 in ipairs(v6) do
								task.delay((v11 - 1) * 0.35, function()
									-- upvalues: (ref) v_u21, (copy) v_u12, (ref) v_u_tween, (copy) v_u_new, (ref) v_u_new
									if v_u21 then
										v_u12.item.Visible = true
										local v_create = v_u_tween:Create(v_u12.content, v_u_new, {
											["Size"] = v_u12.originalSize
										})
										v_u_new:Add(v_create, "Cancel")
										v_create:Play()
									end
								end)
							end
						end
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u38(arg1, arg2)
	-- upvalues: (copy) v_u_playergui, (copy) v_u6, (copy) v_u25
	local v_maingui = v_u_playergui:FindFirstChild("MainGui")
	if v_maingui then
		local v_menu = v_maingui:FindFirstChild("Menu")
		if v_menu then
			v_menu.Visible = false
			v_u6.setForceLockOverride("Menu", false)
		end
		local v_gameplay = v_maingui:FindFirstChild("Gameplay")
		if v_gameplay then
			v_gameplay.Visible = true
			for _, v1 in v_gameplay:GetChildren() do
				if v1:IsA("Frame") or v1:IsA("CanvasGroup") then
					v1.Visible = false
				end
			end
			local v_middle = v_gameplay:FindFirstChild("Middle")
			if v_middle then
				for _, v2 in v_middle:GetChildren() do
					if v2:IsA("Frame") or v2:IsA("CanvasGroup") then
						v2.Visible = false
					end
				end
				v_middle.Visible = true
				local v_endscreen = v_middle:FindFirstChild("EndScreen")
				if v_endscreen then
					v_endscreen.Visible = true
					local v_victory = v_endscreen:FindFirstChild("Victory")
					local v_defeat = v_endscreen:FindFirstChild("Defeat")
					if v_victory then
						v_victory.BackgroundTransparency = 0
						for _, v3 in v_victory:GetDescendants() do
							v_u25(v3, 0)
						end
						v_victory.Visible = arg1
					end
					if v_defeat then
						v_defeat.BackgroundTransparency = 0
						for _, v4 in v_defeat:GetDescendants() do
							v_u25(v4, 0)
						end
						v_defeat.Visible = not arg1
					end
					local v_mvp = v_endscreen:FindFirstChild("MVP")
					if v_mvp then
						v_mvp.Visible = true
					end
					local v5 = workspace:GetAttribute("CTScore") or 0
					local v6 = workspace:GetAttribute("TScore") or 0
					if arg2 == "Counter-Terrorists" then
						local v7 = v5
						v5 = v6
						v6 = v7
					end
					local v_format = ("<b>%*</b> - %*"):format(v6, v5)
					if v_victory then
						local v_score = v_victory:FindFirstChild("Score")
						local v8 = v_score and v_score:FindFirstChild("TextLabel")
						if v8 then
							v8.Text = v_format
						end
					end
					if v_defeat then
						local v_score = v_defeat:FindFirstChild("Score")
						local v9 = v_score and v_score:FindFirstChild("TextLabel")
						if v9 then
							v9.Text = v_format
						end
					end
					local v_mapvote = v_endscreen:FindFirstChild("MapVote")
					if v_mapvote then
						v_mapvote.Visible = false
					end
					local v_top = v_endscreen:FindFirstChild("Top")
					if v_top then
						v_top.Visible = false
					end
					local v_level = v_endscreen:FindFirstChild("Level")
					if v_level then
						v_level.Visible = false
					end
					local v_drops = v_endscreen:FindFirstChild("Drops")
					if v_drops then
						v_drops.Visible = false
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u39()
	-- upvalues: (copy) v_u_playergui
	local v_maingui = v_u_playergui:FindFirstChild("MainGui")
	if v_maingui then
		local v_gameplay = v_maingui:FindFirstChild("Gameplay")
		if v_gameplay then
			local v_middle = v_gameplay:FindFirstChild("Middle")
			if v_middle then
				local v_endscreen = v_middle:FindFirstChild("EndScreen")
				if v_endscreen then
					v_endscreen.Visible = false
					local v_victory = v_endscreen:FindFirstChild("Victory")
					local v_defeat = v_endscreen:FindFirstChild("Defeat")
					local v_level = v_endscreen:FindFirstChild("Level")
					if v_victory then
						v_victory.Visible = false
					end
					if v_defeat then
						v_defeat.Visible = false
					end
					if v_level then
						v_level.Visible = false
						local v_levelbar = v_level:FindFirstChild("LevelBar")
						if v_levelbar then
							local v_current = v_levelbar:FindFirstChild("Current")
							local v_earned = v_levelbar:FindFirstChild("Earned")
							if v_current then
								v_current:SetAttribute("SkipFade", nil)
							end
							if v_earned then
								v_earned:SetAttribute("SkipFade", nil)
							end
						end
						local v_currentinfo = v_level:FindFirstChild("CurrentInfo", true)
						local v_earnedinfo = v_level:FindFirstChild("EarnedInfo", true)
						if v_currentinfo then
							v_currentinfo:SetAttribute("SkipFade", nil)
						end
						if v_earnedinfo then
							v_earnedinfo:SetAttribute("SkipFade", nil)
						end
					end
					local v_mvp = v_endscreen:FindFirstChild("MVP")
					if v_mvp then
						v_mvp.Visible = false
						for v1 = 1, 5 do
							local v2 = v_mvp:FindFirstChild((tostring(v1)))
							if v2 then
								v2.Visible = false
							end
						end
					end
					local v_drops = v_endscreen:FindFirstChild("Drops")
					if v_drops then
						v_drops.Visible = false
						local v_container = v_drops:FindFirstChild("Container")
						if v_container then
							v_container:SetAttribute("SkipFade", nil)
							for _, v3 in v_container:GetChildren() do
								if v3:IsA("Frame") and v3.Name ~= "ItemTemplate" then
									v3:Destroy()
								end
							end
						end
					end
					local v_mapvote = v_endscreen:FindFirstChild("MapVote")
					if v_mapvote then
						v_mapvote.Visible = true
					end
					local v_top = v_endscreen:FindFirstChild("Top")
					if v_top then
						v_top.Visible = true
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u40(arg1)
	-- upvalues: (copy) v_u8, (copy) v_u_localplayer
	local v_get = v_u8.Get(v_u_localplayer, "Inventory")
	if type(v_get) ~= "table" then
		return nil
	end
	for _, v1 in ipairs(v_get) do
		if v1 and v1._id == arg1 then
			return v1
		end
	end
	return nil
end
local function v_u41(arg1, arg2, arg3)
	-- upvalues: (copy) v_u8, (copy) v_u_localplayer, (copy) v_u40, (copy) v_u17, (copy) v_u4, (copy) v_u_replicatedstorage, (copy) v_u20, (copy) v_u19, (copy) v_u_angles, (copy) v_u_new
	local v1 = nil
	local v2 = nil
	local v3 = nil
	if arg3 then
		v1 = arg3.Name
		v2 = arg3.Skin
		v3 = arg3.Float
	else
		local v4 = arg2 == "CT" and "Counter-Terrorists" or "Terrorists"
		local v_get = v_u8.Get(v_u_localplayer, "Loadout")
		local v5
		if type(v_get) == "table" then
			local v6 = v_get[v4]
			if type(v6) == "table" and v6.Equipped then
				v5 = v6.Equipped["Equipped Gloves"]
				if type(v5) ~= "string" or v5 == "" then
					v5 = nil
				end
			else
				v5 = nil
			end
		else
			v5 = nil
		end
		if v5 then
			local v7 = v_u40(v5)
			if v7 then
				v1 = v7.Name
				v2 = v7.Skin
				v3 = v7.Float
			end
		end
	end
	local v8 = v1 or v_u17[arg2].Glove
	local v9
	if v2 and (v2 ~= "" and v3 ~= nil) then
		v9 = v_u4.GetGloves(v8, v2, v3) or nil
	else
		v9 = nil
	end
	local v10
	if v9 then
		v10 = v9:GetChildren()
	else
		local v11 = v_u_replicatedstorage.Assets.Weapons:FindFirstChild(v8)
		if not v11 then
			return
		end
		v10 = v11:GetChildren()
	end
	local v12 = arg1:FindFirstChild("CharacterArmor") or Instance.new("Folder")
	v12.Name = "CharacterArmor"
	v12.Parent = arg1
	for _, v13 in ipairs(v10) do
		if v13:IsA("BasePart") then
			local v14 = v_u20[v13.Name]
			if v14 then
				local v15 = arg1:FindFirstChild(v14)
				if v15 then
					local v_clone = v13:Clone()
					v_clone.Name = v_u19[v13.Name]
					v_clone.CastShadow = false
					v_clone.CanCollide = false
					v_clone.CanTouch = false
					v_clone.Anchored = false
					v_clone.CanQuery = false
					v_clone.CFrame = v15.CFrame * v_u_angles
					v_clone.Size = Vector3.new(v15.Size.X * 1.1, v15.Size.Z, v15.Size.Y) * 1.1
					v_clone.Parent = v12
					local v_motor6d = Instance.new("Motor6D")
					v_motor6d.Name = "GloveAttachment"
					v_motor6d.Part0 = v15
					v_motor6d.Part1 = v_clone
					v_motor6d.C0 = v_u_new
					v_motor6d.C1 = v_clone.PivotOffset * CFrame.Angles(1.5707963267948966, 0, 0)
					v_motor6d.Parent = v_clone
				end
			end
		end
	end
end
local function v_u42(arg1, arg2)
	-- upvalues: (copy) v_u8, (copy) v_u_localplayer
	local v_get = v_u8.Get(v_u_localplayer, "Loadout")
	if type(v_get) ~= "table" then
		return nil
	end
	local v1 = v_get[arg1]
	if type(v1) ~= "table" or not v1.Loadout then
		return nil
	end
	local v_rifles = v1.Loadout.Rifles
	if not v_rifles or type(v_rifles.Options) ~= "table" then
		return nil
	end
	local v_get = v_u8.Get(v_u_localplayer, "Inventory")
	if type(v_get) ~= "table" then
		return nil
	end
	for _, v2 in ipairs(v_rifles.Options) do
		if type(v2) == "string" and v2 ~= "" then
			for _, v3 in ipairs(v_get) do
				if v3 and (v3._id == v2 and v3.Name == arg2) then
					return {
						["Skin"] = v3.Skin,
						["Float"] = v3.Float,
						["StatTrack"] = v3.StatTrack,
						["NameTag"] = v3.NameTag
					}
				end
			end
		end
	end
	return nil
end
local function v_u43(arg1, arg2, arg3)
	-- upvalues: (copy) v_u17, (copy) v_u4, (copy) v_u42, (copy) v_u14
	local v_weapon = v_u17[arg2].Weapon
	local v1 = nil
	if arg3 and (arg3.Skin and arg3.Skin ~= "") then
		v1 = v_u4.GetCharacterModel(v_weapon, arg3.Skin, arg3.Float, arg3.StatTrack, arg3.NameTag)
	else
		local v2 = v_u42(arg2 == "CT" and "Counter-Terrorists" or "Terrorists", v_weapon)
		if v2 and (v2.Skin and v2.Skin ~= "") then
			v1 = v_u4.GetCharacterModel(v_weapon, v2.Skin, v2.Float, v2.StatTrack, v2.NameTag)
		end
	end
	local v3 = v1 or v_u4.GetBaseWeaponModel(v_weapon, "Character")
	if v3 then
		v3.Name = v_weapon
		local v_righthand = arg1:FindFirstChild("RightHand")
		if v_righthand then
			if not v3.PrimaryPart then
				local v_weapon = v3:FindFirstChild("Weapon")
				if v_weapon then
					v_weapon = v_weapon:FindFirstChild("Insert")
				end
				if not v_weapon then
					v3:Destroy()
					return
				end
				v3.PrimaryPart = v_weapon
			end
			for _, v4 in v3:GetDescendants() do
				if v4:IsA("BasePart") then
					v4.CanCollide = false
					v4.CanQuery = false
					v4.CanTouch = false
					v4.Anchored = false
					v4.Massless = true
				end
			end
			v3.Parent = arg1
			local v_motor6d = Instance.new("Motor6D")
			v_motor6d.Name = "WeaponAttachment"
			v_motor6d.Part0 = v_righthand
			v_motor6d.Part1 = v3.PrimaryPart
			v_motor6d.Parent = v_righthand
			if v_weapon == "AK-47" then
				v_motor6d.C0 = v_u14
			else
				local v_properties = v3:FindFirstChild("Properties")
				if v_properties then
					local v_c0 = v_properties:FindFirstChild("C0")
					local v_c1 = v_properties:FindFirstChild("C1")
					if v_c0 then
						v_motor6d.C0 = v_c0.Value
					end
					if v_c1 then
						v_motor6d.C1 = v_c1.Value
					end
				end
			end
		else
			v3:Destroy()
			return
		end
	else
		return
	end
end
local function v_u44(arg1)
	-- upvalues: (copy) v_u_playergui, (copy) v_u_players
	local v_maingui = v_u_playergui:FindFirstChild("MainGui")
	if v_maingui then
		local v_gameplay = v_maingui:FindFirstChild("Gameplay")
		if v_gameplay then
			local v_middle = v_gameplay:FindFirstChild("Middle")
			if v_middle then
				local v_endscreen = v_middle:FindFirstChild("EndScreen")
				if v_endscreen then
					local v_mvp = v_endscreen:FindFirstChild("MVP")
					if v_mvp then
						local v1 = {
							3,
							2,
							4,
							1,
							5
						}
						for v2 = 1, 5 do
							local v3 = v_mvp:FindFirstChild((tostring(v2)))
							if v3 then
								v3.Visible = false
							end
						end
						for v4, v5 in ipairs(arg1) do
							local v6 = v_mvp:FindFirstChild((tostring(v1[v4])))
							if v6 then
								local v_data = v5.data
								local v_userid = v5.userId
								local v_getplayerbyuserid = v_u_players:GetPlayerByUserId((tonumber(v_userid)))
								local v7 = v_getplayerbyuserid and v_getplayerbyuserid.Name or ("Player_%*"):format(v_userid)
								local v_username = v6:FindFirstChild("Username")
								if v_username then
									v_username.Text = v7
								end
								local v_kda = v6:FindFirstChild("KDA")
								if v_kda then
									v_kda.Text = ("%*-%*-%*"):format(v_data.Kills or 0, v_data.Deaths or 0, v_data.Assists or 0)
								end
								local v_hsp = v6:FindFirstChild("HSP")
								if v_hsp then
									v_hsp.Text = (v_data.Kills or 0) <= 0 and "0%" or ("%*%%"):format((math.floor((v_data.Headshots or 0) / UNNAMED_2189156564696 * 100)))
								end
								local v_apr = v6:FindFirstChild("APR")
								if v_apr then
									local v_floor = math.floor(v_data.ADR or 0)
									v_apr.Text = tostring(v_floor)
								end
								local v_score = v6:FindFirstChild("Score")
								if v_score then
									v_score.Text = tostring(v_data.Score or 0)
								end
								local v_category = v6:FindFirstChild("Category")
								if v_category then
									v_category.Text = v_data.Accolade or "Participant"
								end
								local v_player = v6:FindFirstChild("Player")
								local v8 = v_player and v_player:FindFirstChild("Avatar")
								if v8 then
									v8.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v_userid)
								end
								v6.Visible = true
							end
						end
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u45(arg1, arg2)
	-- upvalues: (copy) v_u18, (copy) v_u17, (copy) v_u_characters, (copy) v_u44, (copy) v_u41, (copy) v_u43, (copy) v_u16, (copy) v_u_new
	local v_map = workspace:FindFirstChild("Map")
	if v_map then
		v_map = workspace.Map:FindFirstChild("EndScreen")
	end
	if not v_map then
		return {}
	end
	local v1 = v_u18[arg2]
	if not v1 then
		return {}
	end
	local v2 = v_u17[v1]
	if not v2 then
		return {}
	end
	local v3 = v_u_characters:FindFirstChild(v2.Character)
	if not v3 then
		return {}
	end
	local v4 = {}
	for v5, v6 in pairs(arg1) do
		table.insert(v4, {
			["userId"] = v5,
			["data"] = v6
		})
	end
	table.sort(v4, function(arg1, arg2)
		return (arg1.data.ADR or 0) > (arg2.data.ADR or 0)
	end)
	local v7 = {}
	for v8 = 1, math.min(5, #v4) do
		table.insert(v7, v4[v8])
	end
	v_u44(v7)
	local v9 = {
		3,
		2,
		4,
		1,
		5
	}
	local v10 = {}
	for v11, v12 in ipairs(v7) do
		local v13 = v9[v11]
		local v14 = v_map:FindFirstChild((tostring(v13)))
		if v14 then
			local v_clone = v3:Clone()
			v_clone.Name = "EndScreenCharacter_" .. v12.userId
			v_clone:PivotTo(v14.CFrame)
			v_clone.Parent = v_map
			v_u41(v_clone, v1, v12.data.Gloves)
			v_u43(v_clone, v1, v12.data.Weapon)
			local v_humanoid = v_clone:FindFirstChild("Humanoid")
			if v_humanoid then
				local v_animator = v_humanoid:FindFirstChildOfClass("Animator")
				if not v_animator then
					v_animator = Instance.new("Animator")
					v_animator.Parent = v_humanoid
				end
				local v15 = v_u16[v13]
				if v15 then
					local v_animation = Instance.new("Animation")
					v_animation.AnimationId = v15.Entrance
					local v_loadanimation = v_animator:LoadAnimation(v_animation)
					v_loadanimation.Looped = false
					v_loadanimation.Priority = Enum.AnimationPriority.Action
					v_loadanimation:Play()
					local v_animation = Instance.new("Animation")
					v_animation.AnimationId = v15.Idle
					local v_loadanimation = v_animator:LoadAnimation(v_animation)
					v_loadanimation.Looped = true
					v_loadanimation.Priority = Enum.AnimationPriority.Idle
					v_loadanimation:Play()
					v_u_new:Add(v_animation)
					v_u_new:Add(v_loadanimation)
					v_u_new:Add(v_animation)
					v_u_new:Add(v_loadanimation)
				end
			end
			v_u_new:Add(v_clone, "Destroy")
			table.insert(v10, v_clone)
		end
	end
	return v10
end
local function v_u46()
	-- upvalues: (copy) v_u_current_camera, (copy) v_u6, (copy) v_u_tween
	local v_map = workspace:FindFirstChild("Map")
	if v_map then
		v_map = workspace.Map:FindFirstChild("EndScreen")
	end
	if not v_map then
		return nil
	end
	local v_start = v_map:FindFirstChild("Start")
	local v_end = v_map:FindFirstChild("End")
	if not (v_start and v_end) then
		warn("[EndScreen] Missing Start or End part!")
		return nil
	end
	v_u_current_camera.CameraType = Enum.CameraType.Scriptable
	v_u_current_camera.CFrame = v_start.CFrame
	v_u_current_camera.Focus = v_start.CFrame
	v_u_current_camera.FieldOfView = 60
	v_u6.setMouseEnabled(true)
	local v_create = v_u_tween:Create(v_u_current_camera, TweenInfo.new(14, Enum.EasingStyle.Linear), {
		["CFrame"] = v_end.CFrame
	})
	v_create:Play()
	return v_create
end
local function v_u47()
	-- upvalues: (copy) v_u10, (copy) v_u9, (copy) v_u_playergui, (copy) v_u6, (copy) v_u_replicatedstorage
	v_u10.SetBlurEnabled(false)
	if v_u10.IsCaseSceneActive() then
		v_u9.broadcastRouter("CaseSceneCloseForGameEnd")
	end
	if v_u10.IsInspectActive() then
		v_u9.broadcastRouter("WeaponInspectCloseForGameEnd")
	end
	local v_maingui = v_u_playergui:FindFirstChild("MainGui")
	if v_maingui then
		local v_menu = v_maingui:FindFirstChild("Menu")
		if v_menu and v_menu.Visible then
			v_menu.Visible = false
			v_u6.setForceLockOverride("Menu", false)
		end
		if v_menu then
			v_menu.BackgroundTransparency = 1
		end
	end
	local v_maingui = v_u_playergui:FindFirstChild("MainGui")
	local v1
	if v_maingui then
		local v_gameplay = v_maingui:FindFirstChild("Gameplay")
		if v_gameplay then
			v1 = v_gameplay:FindFirstChild("Middle")
		else
			v1 = nil
		end
	else
		v1 = nil
	end
	if v1 then
		local v_buymenu = v1:FindFirstChild("BuyMenu")
		if v_buymenu and v_buymenu.Visible then
			require(v_u_replicatedstorage.Interface.Screens.Gameplay.Middle.BuyMenu).closeFrame()
		end
		local v_teamselection = v1:FindFirstChild("TeamSelection")
		if v_teamselection and v_teamselection.Visible then
			require(v_u_replicatedstorage.Interface.Screens.Gameplay.Middle.TeamSelection).closeFrame()
		end
	end
end
function v_u1.IsActive()
	-- upvalues: (ref) v_u21
	return v_u21
end
function v_u1._runSequence(arg1, arg2, arg3, arg4, arg5, arg6)
	-- upvalues: (ref) v_u22, (copy) v_u24, (copy) v_u38, (copy) v_u45, (copy) v_u46, (copy) v_u_new, (copy) v_u_playergui, (copy) v_u31, (copy) v_u28, (copy) v_u29, (copy) v_u35, (copy) v_u37, (copy) v_u1
	local v_u1 = v_u22 + 1
	v_u24()
	v_u38(arg2, arg4)
	v_u45(arg1, arg3)
	local v2 = v_u46()
	if v2 then
		v_u_new:Add(v2, "Cancel")
	end
	task.delay(4, function()
		-- upvalues: (copy) v_u1, (ref) v_u22, (ref) v_u_playergui, (ref) v_u31, (copy) arg5, (copy) arg2, (ref) v_u28, (ref) v_u29, (ref) v_u35, (copy) arg6, (ref) v_u37
		if v_u1 == v_u22 then
			local v_maingui = v_u_playergui:FindFirstChild("MainGui")
			local v1
			if v_maingui then
				local v_gameplay = v_maingui:FindFirstChild("Gameplay")
				if v_gameplay then
					v1 = v_gameplay:FindFirstChild("Middle")
				else
					v1 = nil
				end
			else
				v1 = nil
			end
			local v2
			if v1 then
				v2 = v1:FindFirstChild("EndScreen")
			else
				v2 = nil
			end
			if v2 then
				local v_u_victory = v2:FindFirstChild("Victory")
				local v_u_defeat = v2:FindFirstChild("Defeat")
				local v_u_level = v2:FindFirstChild("Level")
				local v_u3 = v_u31(arg5)
				local v4 = arg2 and v_u_victory and v_u_victory or v_u_defeat
				if v4 and v4.Visible then
					v_u28(v4, 1)
				end
				task.delay(0.5, function()
					-- upvalues: (ref) v_u1, (ref) v_u22, (copy) v_u_victory, (copy) v_u_defeat, (copy) v_u_level, (ref) v_u29, (copy) v_u3, (ref) v_u35, (ref) arg6, (ref) v_u37
					if v_u1 == v_u22 then
						if v_u_victory then
							v_u_victory.Visible = false
						end
						if v_u_defeat then
							v_u_defeat.Visible = false
						end
						if v_u_level then
							v_u29(v_u_level)
							task.spawn(function()
								-- upvalues: (ref) v_u3, (ref) v_u35, (ref) arg6, (ref) v_u37
								if v_u3 then
									v_u35(v_u3)
								end
								if arg6 and #arg6 > 0 then
									v_u37(arg6)
								end
							end)
						end
					end
				end)
			end
		else
			return
		end
	end)
	task.delay(14, function()
		-- upvalues: (copy) v_u1, (ref) v_u22, (ref) v_u1
		if v_u1 == v_u22 then
			v_u1._finishSequence()
		end
	end)
end
function v_u1._finishSequence()
	-- upvalues: (copy) v_u_new, (copy) v_u39, (ref) v_u21, (copy) v_u6, (copy) v_u_replicatedstorage, (copy) v_u_playergui, (copy) v_u8, (copy) v_u_localplayer, (ref) v_u23
	v_u_new:Cleanup()
	v_u39()
	v_u21 = false
	v_u6.SetEnabled(true)
	local v1 = require(v_u_replicatedstorage.Controllers.MenuSceneController)
	v1.ShowMenuScene()
	if v1.IsActive() then
		require(v_u_replicatedstorage.Interface.Screens.Menu.Top).ResetToMainMenu()
		local v_maingui = v_u_playergui:FindFirstChild("MainGui")
		if v_maingui then
			if not v_maingui.Menu.Visible then
				v_u6.setForceLockOverride("Menu", true)
				v_maingui.Menu.Visible = true
			end
			v_maingui.Gameplay.Visible = false
		end
	end
	local v_get = v_u8.Get(v_u_localplayer, "Level")
	if v_get then
		v_u23 = {
			["Level"] = v_get.Level,
			["Experience"] = v_get.Experience,
			["NextExperienceRequirement"] = v_get.NextExperienceRequirement
		}
	end
end
function v_u1.Begin(arg1)
	-- upvalues: (ref) v_u21, (copy) v_u47, (copy) v_u7, (copy) v_u6, (copy) v_u_localplayer, (copy) v_u_replicatedstorage, (copy) v_u_playergui, (copy) v_u1
	if v_u21 then
		return
	else
		v_u47()
		v_u7.Stop(false, true)
		v_u6.SetEnabled(false)
		v_u21 = true
		local v_team = v_u_localplayer:GetAttribute("Team")
		if v_team and (v_team == "Counter-Terrorists" or v_team == "Terrorists") then
			local v1 = arg1.WinningTeam == v_team
			local v2 = {}
			for v3, v4 in pairs(arg1.Players) do
				if v4.Team == v_team then
					v2[v3] = v4
				end
			end
			local v5 = arg1.Players[tostring(v_u_localplayer.UserId)]
			local v6 = v5 and (v5.ExperienceEarned or 0) or 0
			if v5 then
				v5 = v5.LevelRewards
			end
			v_u1._runSequence(v2, v1, v_team, arg1.WinningTeam, v6, v5)
		else
			v_u21 = false
			v_u6.SetEnabled(true)
			require(v_u_replicatedstorage.Controllers.MenuSceneController).ShowMenuScene()
			require(v_u_replicatedstorage.Interface.Screens.Menu.Top).ResetToMainMenu()
			local v_maingui = v_u_playergui:FindFirstChild("MainGui")
			if v_maingui then
				v_u6.setForceLockOverride("Menu", true)
				v_maingui.Menu.Visible = true
				v_maingui.Gameplay.Visible = false
			end
		end
	end
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u_playergui, (copy) v_u8, (copy) v_u_localplayer, (ref) v_u23, (copy) v_u3, (copy) v_u1
	local v_maingui = v_u_playergui:FindFirstChild("MainGui")
	local v1
	if v_maingui then
		local v_gameplay = v_maingui:FindFirstChild("Gameplay")
		if v_gameplay then
			v1 = v_gameplay:FindFirstChild("Middle")
		else
			v1 = nil
		end
	else
		v1 = nil
	end
	local v2
	if v1 then
		v2 = v1:FindFirstChild("EndScreen")
	else
		v2 = nil
	end
	local v3 = v2 and v2:FindFirstChild("Drops")
	if v3 then
		v3.Visible = false
	end
	v_u8.CreateListener(v_u_localplayer, "Level", function(arg1)
		-- upvalues: (ref) v_u23
		if v_u23 == nil and arg1 then
			v_u23 = {
				["Level"] = arg1.Level,
				["Experience"] = arg1.Experience,
				["NextExperienceRequirement"] = arg1.NextExperienceRequirement
			}
		end
	end)
	v_u3.Match.EndScreen.Listen(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.Begin(arg1)
	end)
end
return v_u1