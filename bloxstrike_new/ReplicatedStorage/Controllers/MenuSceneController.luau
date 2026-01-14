-- game.ReplicatedStorage.Controllers.MenuSceneController

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_u_tween = game:GetService("TweenService")
local v_u_lighting = game:GetService("Lighting")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Packages.Observers)
local v3 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u4 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u5 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u6 = nil
local v_u7 = require(v_u_replicatedstorage.Classes.Sound)
local v_u8 = require(v_u_replicatedstorage.Database.Custom.Constants)
local v_u_localplayer = v_players.LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u_current_camera = workspace.CurrentCamera
local v_u9 = nil
local v_u_lighting = v_u_replicatedstorage.Assets.Lighting
local v_u_maps = v_u_replicatedstorage.Database.Custom.GameStats.Maps
local v_u_characters = v_u_replicatedstorage.Assets.Characters
local v_u10 = {
	["CT"] = {
		["Entrance"] = "rbxassetid://140448509508633",
		["Idle"] = "rbxassetid://137360078752983"
	},
	["T"] = {
		["Entrance"] = "rbxassetid://100747011940776",
		["Idle"] = "rbxassetid://99540873384647"
	}
}
local v_u11 = {
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
local v_u12 = {
	["Right Arm"] = "RightGlove",
	["Left Arm"] = "LeftGlove"
}
local v_u13 = {
	["Right Arm"] = "RightHand",
	["Left Arm"] = "LeftHand"
}
local v_u14 = nil
local v_u15 = nil
local v_u16 = nil
local v_u_new = v3.new()
local v_u17 = false
local v_u18 = nil
local v_u19 = nil
local v_u20 = 1
local v_u21 = nil
local v_u22 = nil
local function v_u23()
	-- upvalues: (copy) v_u_maps, (ref) v_u22, (copy) v_u_lighting, (copy) v_u4, (copy) v_u_localplayer
	local v_map = workspace:FindFirstChild("Map")
	if v_map then
		local v_mapname = v_map:GetAttribute("MapName")
		if v_mapname and typeof(v_mapname) == "string" then
			local v1 = v_u_maps:FindFirstChild(v_mapname)
			if v1 and v1:IsA("ModuleScript") then
				local v2 = require(v1)
				if v2.Lighting then
					local v_properties = v2.Lighting.Properties
					if v_properties then
						v_u22 = v_properties.GlobalShadows
						v_u_lighting.Ambient = v_properties.Ambient
						v_u_lighting.Brightness = v_properties.Brightness
						v_u_lighting.ColorShift_Bottom = v_properties.ColorShift_Bottom
						v_u_lighting.ColorShift_Top = v_properties.ColorShift_Top
						v_u_lighting.EnvironmentDiffuseScale = v_properties.EnvironmentDiffuseScale
						v_u_lighting.EnvironmentSpecularScale = v_properties.EnvironmentSpecularScale
						v_u_lighting.GlobalShadows = v_properties.GlobalShadows
						v_u_lighting.OutdoorAmbient = v_properties.OutdoorAmbient
						v_u_lighting.ShadowSoftness = v_properties.ShadowSoftness
						v_u_lighting.ClockTime = v_properties.ClockTime
						v_u_lighting.GeographicLatitude = v_properties.GeographicLatitude
						v_u_lighting.ExposureCompensation = v_properties.ExposureCompensation
					end
					for _, v3 in ipairs(v_u_lighting:GetChildren()) do
						if v3.Name ~= "Menu" then
							v3:Destroy()
						end
					end
					local v_assets = v2.Lighting.Assets
					if v_assets then
						for _, v4 in ipairs(v_assets:GetChildren()) do
							v4:Clone().Parent = v_u_lighting
						end
					end
					if v_u4.Get(v_u_localplayer, "Settings.Video.Presets.Global Shadows") ~= false then
						if v_u22 ~= nil then
							v_u_lighting.GlobalShadows = v_u22
						end
					else
						v_u_lighting.GlobalShadows = false
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
local function v_u24(arg1)
	-- upvalues: (copy) v_u_lighting, (copy) v_u_maps, (ref) v_u22, (copy) v_u_lighting, (copy) v_u4, (copy) v_u_localplayer
	local v1 = v_u_lighting:FindFirstChild(arg1)
	if v1 then
		local v2 = v_u_maps:FindFirstChild(arg1)
		if v2 and v2:IsA("ModuleScript") then
			local v3 = require(v2)
			if v3.Lighting and v3.Lighting.Properties then
				local v_properties = v3.Lighting.Properties
				v_u22 = v_properties.GlobalShadows
				v_u_lighting.Ambient = v_properties.Ambient
				v_u_lighting.Brightness = v_properties.Brightness
				v_u_lighting.ColorShift_Bottom = v_properties.ColorShift_Bottom
				v_u_lighting.ColorShift_Top = v_properties.ColorShift_Top
				v_u_lighting.EnvironmentDiffuseScale = v_properties.EnvironmentDiffuseScale
				v_u_lighting.EnvironmentSpecularScale = v_properties.EnvironmentSpecularScale
				v_u_lighting.GlobalShadows = v_properties.GlobalShadows
				v_u_lighting.OutdoorAmbient = v_properties.OutdoorAmbient
				v_u_lighting.ShadowSoftness = v_properties.ShadowSoftness
				v_u_lighting.ClockTime = v_properties.ClockTime
				v_u_lighting.GeographicLatitude = v_properties.GeographicLatitude
				v_u_lighting.ExposureCompensation = v_properties.ExposureCompensation
			end
		end
		for _, v4 in ipairs(v_u_lighting:GetChildren()) do
			if v4.Name ~= "Menu" then
				v4:Destroy()
			end
		end
		for _, v5 in ipairs(v1:GetChildren()) do
			v5:Clone().Parent = v_u_lighting
		end
		if v_u4.Get(v_u_localplayer, "Settings.Video.Presets.Global Shadows") ~= false then
			if v_u22 ~= nil then
				v_u_lighting.GlobalShadows = v_u22
			end
		else
			v_u_lighting.GlobalShadows = false
		end
	else
		warn((("[MenuSceneController]: No lighting found for scene \"%*\""):format(arg1)))
		return
	end
end
local function v_u25()
	-- upvalues: (copy) v_u_replicatedstorage, (ref) v_u6, (copy) v_u_playergui, (copy) v_u_localplayer
	local v1 = require(v_u_replicatedstorage.Interface.MenuState)
	if v_u6 and v_u6.IsActive() then
		return false
	end
	if v1.IsInspectActive() then
		return false
	end
	if workspace:FindFirstChild("InspectScene") then
		return false
	end
	local v_maingui = v_u_playergui:FindFirstChild("MainGui")
	if v_maingui then
		local v_gameplay = v_maingui:FindFirstChild("Gameplay")
		if v_gameplay then
			v_gameplay = v_gameplay:FindFirstChild("Middle")
		end
		if v_gameplay then
			v_gameplay = v_gameplay:FindFirstChild("TeamSelection")
		end
		if v_gameplay and v_gameplay.Visible then
			return false
		end
	end
	local v_isspectating = v_u_localplayer:GetAttribute("IsSpectating")
	local v_team = v_u_localplayer:GetAttribute("Team")
	local v_getstate = require(v_u_replicatedstorage.Database.Components.GameState).GetState()
	if v_getstate == "Game Ending" or v_getstate == "Map Voting" then
		if v_team == "Counter-Terrorists" or v_team == "Terrorists" then
			return false
		end
		local v_character = v_u_localplayer.Character
		local v2
		if v_character and v_character:IsDescendantOf(workspace) then
			local v_humanoid = v_character:FindFirstChild("Humanoid")
			v2 = v_humanoid and v_humanoid.Health > 0 and true or false
		else
			v2 = false
		end
		return not v2
	end
	if v_team == "Counter-Terrorists" or v_team == "Terrorists" then
		return false
	end
	local v_character = v_u_localplayer.Character
	local v3
	if v_character and v_character:IsDescendantOf(workspace) then
		local v_humanoid = v_character:FindFirstChild("Humanoid")
		v3 = v_humanoid and v_humanoid.Health > 0 and true or false
	else
		v3 = false
	end
	local v4 = not v3
	if v4 then
		v4 = not v_isspectating
	end
	return v4
end
local function v_u26(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u4, (copy) v_u_localplayer, (copy) v_u11, (copy) v_u13, (copy) v_u12
	local v1 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
	local v2 = nil
	local v3 = nil
	local v4 = nil
	if arg3 then
		local v5 = arg2 == "CT" and "Counter-Terrorists" or "Terrorists"
		v_u4.WaitForDataLoaded(v_u_localplayer)
		local v_get = v_u4.Get(v_u_localplayer, "Loadout")
		if v_get and (type(v_get) == "table" and v_get[v5]) then
			local v6 = v_get[v5]
			if v6 and (type(v6) == "table" and v6.Equipped) then
				local v_equipped gloves = v6.Equipped["Equipped Gloves"]
				if v_equipped gloves and (v_equipped gloves ~= "" and type(v_equipped gloves) == "string") then
					local v_get = v_u4.Get(v_u_localplayer, "Inventory")
					if v_get and type(v_get) == "table" then
						for _, v7 in ipairs(v_get) do
							if v7 and v7._id == v_equipped gloves then
								v2 = v7.Name
								v3 = v7.Skin
								v4 = v7.Float
								arg1:SetAttribute("EquippedGloves", game:GetService("HttpService"):JSONEncode({
									["SkinIdentifier"] = v_equipped gloves
								}))
								break
							end
						end
					end
				end
			end
		end
	end
	local v8 = v2 or v_u11[arg2].Glove
	local v9
	if v3 and (v4 and v8) then
		v9 = v1.GetGloves(v8, v3, v4)
	else
		v9 = nil
	end
	local v10 = v9 or v_u_replicatedstorage:WaitForChild("Assets"):WaitForChild("Weapons"):FindFirstChild(v8)
	if v10 then
		local v_characterarmor = arg1:FindFirstChild("CharacterArmor")
		if not v_characterarmor then
			v_characterarmor = Instance.new("Folder")
			v_characterarmor.Name = "CharacterArmor"
			v_characterarmor.Parent = arg1
		end
		local v11
		if v9 then
			v11 = v9:GetChildren()
		else
			if not v10 then
				warn((("[MenuSceneController]: No glove model or folder available for \"%*\""):format(v8)))
				return
			end
			v11 = v10:GetChildren()
		end
		for _, v12 in ipairs(v11) do
			if v12:IsA("BasePart") then
				local v13 = v_u13[v12.Name]
				if v13 then
					local v14 = arg1:FindFirstChild(v13)
					if v14 then
						local v_clone = v12:Clone()
						v_clone.Name = v_u12[v12.Name]
						v_clone.CastShadow = false
						v_clone.CanCollide = false
						v_clone.CanTouch = false
						v_clone.Anchored = false
						v_clone.CanQuery = false
						v_clone.CFrame = v14.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
						v_clone.Size = Vector3.new(v14.Size.X * 1.1, v14.Size.Z, v14.Size.Y) * 1.1
						v_clone.Parent = v_characterarmor
						local v_motor6d = Instance.new("Motor6D")
						v_motor6d.Name = "GloveAttachment"
						v_motor6d.Part0 = v14
						v_motor6d.Part1 = v_clone
						v_motor6d.C0 = CFrame.new(0, 0, -0.025)
						v_motor6d.C1 = v_clone.PivotOffset * CFrame.Angles(1.5707963267948966, 0, 0)
						v_motor6d.Parent = v_clone
					end
				end
			end
		end
		if v9 and v9.Name == "" then
			v9:Destroy()
		end
	else
		warn((("[MenuSceneController]: Glove folder not found for \"%*\""):format(v8)))
	end
end
local function v_u27(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u4, (copy) v_u_localplayer, (copy) v_u11
	local v1 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
	local v2 = nil
	local v3 = nil
	local v4 = nil
	local v5 = nil
	local v6 = nil
	if arg3 then
		local v7 = arg2 == "CT" and "Counter-Terrorists" or "Terrorists"
		local v8 = arg2 == "CT" and "M4A1-S" or "AK-47"
		v_u4.WaitForDataLoaded(v_u_localplayer)
		local v_get = v_u4.Get(v_u_localplayer, "Loadout")
		local v_get = v_u4.Get(v_u_localplayer, "Inventory")
		if v_get and (type(v_get) == "table" and v_get[v7]) then
			local v9 = v_get[v7]
			if v9 and (type(v9) == "table" and v9.Loadout) then
				local v_rifles = v9.Loadout.Rifles
				if v_rifles and (v_rifles.Options and (type(v_rifles.Options) == "table" and (v_get and type(v_get) == "table"))) then
					for _, v10 in ipairs(v_rifles.Options) do
						if v10 and (v10 ~= "" and type(v10) == "string") then
							for _, v11 in ipairs(v_get) do
								if v11 and (v11._id == v10 and v11.Name == v8) then
									v2 = v11.Name
									v3 = v11.Skin
									v4 = v11.Float
									v5 = v11.StatTrack
									v6 = v11.NameTag
									break
								end
							end
							if v2 then
								break
							end
						end
					end
				end
			end
		end
	end
	local v12 = v2 or v_u11[arg2].Weapon
	if v12 then
		local v13
		if v3 and (typeof(v3) == "string" and (v3 ~= "" and v12)) then
			v13 = v1.GetCharacterModel(v12, v3, v4, v5, v6)
		else
			v13 = nil
		end
		local v14 = v13 or v1.GetBaseWeaponModel(v12, "Character")
		if v14 then
			v14.Name = v12
			local v_righthand = arg1:FindFirstChild("RightHand")
			if v_righthand then
				if not v14.PrimaryPart then
					local v_weapon = v14:FindFirstChild("Weapon")
					if v_weapon then
						v_weapon = v_weapon:FindFirstChild("Insert")
					end
					if not v_weapon then
						warn("[MenuSceneController]: Weapon model has no PrimaryPart or Insert")
						v14:Destroy()
						return
					end
					v14.PrimaryPart = v_weapon
				end
				for _, v15 in ipairs(v14:GetDescendants()) do
					if v15:IsA("BasePart") then
						v15.CanCollide = false
						v15.CanQuery = false
						v15.CanTouch = false
						v15.Anchored = false
						v15.Massless = true
					end
				end
				v14.Parent = arg1
				local v_motor6d = Instance.new("Motor6D")
				v_motor6d.Name = "WeaponAttachment"
				v_motor6d.Part0 = v_righthand
				v_motor6d.Part1 = v14.PrimaryPart
				v_motor6d.Parent = v_righthand
				if v12 == "AK-47" then
					v_motor6d.C0 = CFrame.new(-0.251, 0.806, -0.406) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)
					return v14
				end
				local v_properties = v14:FindFirstChild("Properties")
				if v_properties then
					local v_c0 = v_properties:FindFirstChild("C0")
					if v_c0 then
						v_motor6d.C0 = v_c0.Value
					end
					local v_c1 = v_properties:FindFirstChild("C1")
					if v_c1 then
						v_motor6d.C1 = v_c1.Value
					end
				end
				return v14
			end
			warn("[MenuSceneController]: Character missing RightHand")
			v14:Destroy()
		else
			warn((("[MenuSceneController]: Failed to get weapon model for \"%*\""):format(v12)))
		end
	else
		warn("[MenuSceneController]: No weapon name available")
		return
	end
end
local function v_u28(arg1)
	-- upvalues: (copy) v_u11, (copy) v_u10, (copy) v_u_characters, (ref) v_u15, (ref) v_u16, (copy) v_u27, (copy) v_u26, (copy) v_u_new, (ref) v_u17
	local v_playerpart = arg1:FindFirstChild("PlayerPart")
	if v_playerpart then
		local v1 = math.random(1, 2) == 1 and "CT" or "T"
		local v2 = v_u11[v1]
		local v3 = v_u10[v1]
		local v4 = v_u_characters:FindFirstChild(v2.Character)
		if v4 then
			local v_clone = v4:Clone()
			v_clone.Name = "MenuCharacter"
			v_u15 = v_clone
			v_u16 = v1
			if v_clone:FindFirstChild("HumanoidRootPart") then
				v_clone:PivotTo(v_playerpart.CFrame)
			end
			v_clone.Parent = arg1
			v_u27(v_clone, v1, true)
			v_u26(v_clone, v1, true)
			local v_humanoid = v_clone:FindFirstChild("Humanoid")
			if v_humanoid then
				local v_animator = v_humanoid:FindFirstChildOfClass("Animator")
				if not v_animator then
					v_animator = Instance.new("Animator")
					v_animator.Parent = v_humanoid
				end
				local v_animation = Instance.new("Animation")
				v_animation.AnimationId = v3.Entrance
				local v_animation = Instance.new("Animation")
				v_animation.AnimationId = v3.Idle
				local v_loadanimation = v_animator:LoadAnimation(v_animation)
				local v_u_loadanimation = v_animator:LoadAnimation(v_animation)
				v_u_new:Add(v_animation, "Destroy", "EntranceAnimation")
				v_u_new:Add(v_animation, "Destroy", "IdleAnimation")
				v_u_new:Add(v_loadanimation, "Stop", "EntranceTrack")
				v_u_new:Add(v_u_loadanimation, "Stop", "IdleTrack")
				v_loadanimation.Priority = Enum.AnimationPriority.Action
				v_loadanimation:Play()
				v_loadanimation.Stopped:Once(function()
					-- upvalues: (ref) v_u17, (copy) v_u_loadanimation
					if v_u17 and v_u_loadanimation then
						v_u_loadanimation.Looped = true
						v_u_loadanimation.Priority = Enum.AnimationPriority.Idle
						v_u_loadanimation:Play()
					end
				end)
				v_u_new:Add(function()
					-- upvalues: (ref) v_u15, (ref) v_u16
					if v_u15 then
						v_u15:Destroy()
						v_u15 = nil
						v_u16 = nil
					end
				end, true, "MenuCharacterCleanup")
			else
				warn("[MenuSceneController]: Character missing Humanoid")
			end
		else
			warn((("[MenuSceneController]: Character \"%*\" not found"):format(v2.Character)))
			return
		end
	else
		return
	end
end
function v_u1.ShowMenuScene()
	-- upvalues: (ref) v_u17, (copy) v_u5, (copy) v_u_replicatedstorage, (ref) v_u9, (ref) v_u14, (copy) v_u24, (copy) v_u23, (copy) v_u_current_camera, (copy) v_u_new, (copy) v_u_run, (copy) v_u28, (ref) v_u19, (copy) v_u4, (copy) v_u_localplayer, (copy) v_u7, (ref) v_u18, (copy) v_u_playergui, (ref) v_u20
	if v_u17 then
		v_u5.updateCameraFOV(50)
		v_u5.setMouseEnabled(true)
		return
	elseif workspace:FindFirstChild("InspectScene") then
		return
	else
		local v1 = require(v_u_replicatedstorage.Interface.MenuState)
		if v1.IsInspectActive() then
			return
		elseif v1.IsCaseSceneActive() then
			return
		else
			local v2
			if v_u9 then
				v2 = v_u9
			else
				local v_assets = v_u_replicatedstorage:FindFirstChild("Assets")
				if v_assets then
					v_u9 = v_assets:WaitForChild("MenuScenes", 10)
				end
				v2 = v_u9
			end
			local v3
			if v2 then
				local v_getchildren = v2:GetChildren()
				if #v_getchildren > 0 then
					v3 = v_getchildren[math.random(1, #v_getchildren)]
				else
					v3 = nil
				end
			else
				v3 = nil
			end
			if v3 then
				local v_clone = v3:Clone()
				v_clone.Parent = workspace
				v_u14 = v_clone
				v_u24(v3.Name)
				local v_u_campart = v_clone:FindFirstChild("CamPart")
				if v_u_campart then
					v_u_current_camera.CameraType = Enum.CameraType.Scriptable
					v_u_current_camera.CFrame = v_u_campart.CFrame
					v_u_current_camera.Focus = v_u_campart.CFrame
					v_u5.updateCameraFOV(50)
					v_u5.setMouseEnabled(true)
					v_u_new:Add(v_u_run.RenderStepped:Connect(function()
						-- upvalues: (ref) v_u14, (copy) v_u_campart, (ref) v_u_current_camera
						if v_u14 and v_u_campart then
							v_u_current_camera.CFrame = v_u_campart.CFrame
							v_u_current_camera.Focus = v_u_campart.CFrame
						end
					end), "Disconnect", "CameraUpdate")
					v_u_new:Add(function()
						-- upvalues: (ref) v_u14
						if v_u14 then
							v_u14:Destroy()
							v_u14 = nil
						end
					end, true, "MenuSceneCleanup")
					v_u17 = true
					v_u28(v_clone)
					if not (v_u19 and v_u19.IsPlaying) then
						local v4 = (v_u4.Get(v_u_localplayer, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100
						if v4 > 0 then
							local v_main_menu = v_u7.new("Main Menu")
							v_u18 = v_main_menu
							local v_u_play = v_main_menu:play({
								["Name"] = "Main Menu Music",
								["Parent"] = v_u_playergui
							}, v4)
							v_u19 = v_u_play
							if v_u_play then
								local v5 = (v_u4.Get(v_u_localplayer, "Settings.Audio.Audio.Master Volume") or 100) / 100
								local v_u_volume = v_u_play.Volume
								if v4 > 0 and v5 > 0 then
									v_u_volume = v_u_volume / (v4 * v5) or v_u_volume
								end
								v_u_play:SetAttribute("BaseVolume", v_u_volume)
								v_u_play:SetAttribute("AmbienceVolumeMultiplier", v4)
								if v_u20 ~= 1 then
									v_u_play.Volume = v_u_play.Volume * v_u20
								end
								local function v6()
									-- upvalues: (copy) v_u_play, (ref) v_u4, (ref) v_u_localplayer, (copy) v_u_volume, (ref) v_u20, (ref) v_u19, (ref) v_u18
									if v_u_play and v_u_play.Parent then
										local v1 = (v_u4.Get(v_u_localplayer, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100
										local v2 = (v_u4.Get(v_u_localplayer, "Settings.Audio.Audio.Master Volume") or 100) / 100
										v_u_play.Volume = (v_u_play:GetAttribute("BaseVolume") or v_u_volume) * v1 * v2 * v_u20
										if v1 == 0 or v2 == 0 then
											v_u_play:Stop()
											v_u_play:Destroy()
											v_u19 = nil
											if v_u18 then
												v_u18:destroy()
												v_u18 = nil
											end
										end
									end
								end
								v_u4.CreateListener(v_u_localplayer, "Settings.Audio.Audio.Main Menu Ambience Volume", v6)
								v_u4.CreateListener(v_u_localplayer, "Settings.Audio.Audio.Master Volume", v6)
							end
						end
					end
				else
					warn("[MenuSceneController]: Menu scene missing CamPart")
					v_clone:Destroy()
					v_u14 = nil
					v_u23()
				end
			else
				v_u5.setMouseEnabled(true)
				return
			end
		end
	end
end
function v_u1.HideMenuScene(arg1, arg2)
	-- upvalues: (ref) v_u17, (copy) v_u_replicatedstorage, (copy) v_u_new, (copy) v_u23, (copy) v_u_current_camera, (copy) v_u5, (copy) v_u8, (ref) v_u19, (ref) v_u18
	if v_u17 then
		if require(v_u_replicatedstorage.Interface.MenuState).IsInspectActive() or workspace:FindFirstChild("InspectScene") then
			arg2 = true
			arg1 = true
		end
		v_u_new:Cleanup()
		if not arg2 then
			v_u23()
		end
		if not arg2 then
			v_u_current_camera.CameraType = Enum.CameraType.Custom
			v_u5.updateCameraFOV(v_u8.DEFAULT_CAMERA_FOV)
		end
		v_u17 = false
		if not arg1 then
			if v_u19 then
				v_u19:Stop()
				v_u19 = nil
			end
			if v_u18 then
				v_u18:destroy()
				v_u18 = nil
			end
		end
	end
end
function v_u1.IsActive()
	-- upvalues: (ref) v_u17
	return v_u17
end
function v_u1.StopMenuMusic()
	-- upvalues: (ref) v_u19, (ref) v_u18
	if v_u19 then
		v_u19:Stop()
		v_u19 = nil
	end
	if v_u18 then
		v_u18:destroy()
		v_u18 = nil
	end
end
function v_u1.IsMusicPlaying()
	-- upvalues: (ref) v_u19
	local v1
	if v_u19 == nil then
		v1 = false
	else
		v1 = v_u19.IsPlaying
	end
	return v1
end
function v_u1.SetMusicVolumeMultiplier(arg1, arg2)
	-- upvalues: (ref) v_u20, (ref) v_u19, (ref) v_u21, (copy) v_u4, (copy) v_u_localplayer, (copy) v_u_tween
	v_u20 = arg1
	if v_u19 then
		if v_u21 then
			v_u21:Cancel()
			v_u21 = nil
		end
		local v1 = (v_u19:GetAttribute("BaseVolume") or 0.1) * ((v_u4.Get(v_u_localplayer, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100) * ((v_u4.Get(v_u_localplayer, "Settings.Audio.Audio.Master Volume") or 100) / 100) * v_u20
		if arg2 and arg2 > 0 then
			local v_create = v_u_tween:Create(v_u19, TweenInfo.new(arg2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["Volume"] = v1
			})
			v_u21 = v_create
			v_create:Play()
		else
			v_u19.Volume = v1
		end
	else
		return
	end
end
function v_u1.ApplyMapLighting()
	-- upvalues: (copy) v_u23
	v_u23()
end
function v_u1.ApplyMenuSceneLighting()
	-- upvalues: (ref) v_u9, (copy) v_u_replicatedstorage, (copy) v_u24, (copy) v_u_lighting
	local v1
	if v_u9 then
		v1 = v_u9
	else
		local v_assets = v_u_replicatedstorage:FindFirstChild("Assets")
		if v_assets then
			v_u9 = v_assets:WaitForChild("MenuScenes", 10)
		end
		v1 = v_u9
	end
	local v2
	if v1 then
		local v_getchildren = v1:GetChildren()
		if #v_getchildren > 0 then
			v2 = v_getchildren[math.random(1, #v_getchildren)]
		else
			v2 = nil
		end
	else
		v2 = nil
	end
	if v2 then
		v_u24(v2.Name)
		v_u_lighting.GlobalShadows = true
	end
end
function v_u1.GetMenuCharacter()
	-- upvalues: (ref) v_u15
	return v_u15
end
function v_u1.CreateStandaloneCharacter(arg1)
	-- upvalues: (copy) v_u11, (copy) v_u_characters, (copy) v_u_replicatedstorage, (copy) v_u26
	local v1 = arg1 or (math.random(1, 2) == 1 and "CT" or "T")
	local v2 = v_u11[v1]
	local v3 = v_u_characters:FindFirstChild(v2.Character)
	if not v3 then
		warn((("[MenuSceneController]: Character \"%*\" not found"):format(v2.Character)))
		return nil
	end
	local v_clone = v3:Clone()
	v_clone.Name = "StandaloneCharacter"
	v_clone.Parent = v_u_replicatedstorage
	v_u26(v_clone, v1, true)
	return v_clone
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u4, (copy) v_u_localplayer, (copy) v_u_lighting, (ref) v_u22, (copy) v_u25, (copy) v_u1, (ref) v_u6, (copy) v_u_replicatedstorage, (copy) v_u2, (ref) v_u15, (ref) v_u16, (copy) v_u27, (copy) v_u26, (copy) v_u_new
	v_u4.CreateListener(v_u_localplayer, "Settings.Video.Presets.Global Shadows", function()
		-- upvalues: (ref) v_u4, (ref) v_u_localplayer, (ref) v_u_lighting, (ref) v_u22
		if v_u4.Get(v_u_localplayer, "Settings.Video.Presets.Global Shadows") ~= false then
			if v_u22 ~= nil then
				v_u_lighting.GlobalShadows = v_u22
			end
		else
			v_u_lighting.GlobalShadows = false
		end
	end)
	if v_u25() then
		v_u1.ShowMenuScene()
	end
	task.defer(function()
		-- upvalues: (ref) v_u6, (ref) v_u_replicatedstorage
		if not v_u6 then
			v_u6 = require(v_u_replicatedstorage.Controllers.EndScreenController)
		end
	end)
	v_u_localplayer.CharacterAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u25
		v_u1.StopMenuMusic()
		v_u1.HideMenuScene()
		arg1:WaitForChild("Humanoid").Died:Connect(function()
			-- upvalues: (ref) v_u25, (ref) v_u1
			task.delay(0.1, function()
				-- upvalues: (ref) v_u25, (ref) v_u1
				if v_u25() then
					v_u1.ShowMenuScene()
				end
			end)
		end)
	end)
	v_u_localplayer.CharacterRemoving:Connect(function()
		-- upvalues: (ref) v_u25, (ref) v_u1
		task.delay(0.1, function()
			-- upvalues: (ref) v_u25, (ref) v_u1
			if v_u25() then
				v_u1.ShowMenuScene()
			end
		end)
	end)
	v_u2.observeAttribute(v_u_localplayer, "IsSpectating", function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u25
		if arg1 then
			v_u1.HideMenuScene()
		elseif v_u25() then
			v_u1.ShowMenuScene()
		end
		return function()
			-- upvalues: (ref) v_u25, (ref) v_u1
			if v_u25() then
				v_u1.ShowMenuScene()
			end
		end
	end)
	v_u2.observeAttribute(v_u_localplayer, "Team", function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u25
		if arg1 == "Counter-Terrorists" or arg1 == "Terrorists" then
			v_u1.HideMenuScene()
		elseif v_u25() then
			v_u1.ShowMenuScene()
		end
		return function()
			-- upvalues: (ref) v_u25, (ref) v_u1
			task.delay(0.1, function()
				-- upvalues: (ref) v_u25, (ref) v_u1
				if v_u25() then
					v_u1.ShowMenuScene()
				end
			end)
		end
	end)
	local function v_u1()
		-- upvalues: (ref) v_u15, (ref) v_u16, (ref) v_u27, (ref) v_u26
		if v_u15 and v_u16 then
			local v_righthand = v_u15:FindFirstChild("RightHand")
			local v1 = v_righthand and v_righthand:FindFirstChild("WeaponAttachment")
			if v1 then
				local v_part1 = v1.Part1
				if v_part1 and v_part1.Parent then
					v_part1:Destroy()
				end
				v1:Destroy()
			end
			local v_characterarmor = v_u15:FindFirstChild("CharacterArmor")
			if v_characterarmor then
				for _, v2 in ipairs(v_characterarmor:GetChildren()) do
					if v2:IsA("BasePart") and v2:FindFirstChild("GloveAttachment") then
						v2:Destroy()
					end
				end
			end
			v_u27(v_u15, v_u16, true)
			v_u26(v_u15, v_u16, true)
		end
	end
	local v_u_createlistener = v_u4.CreateListener(v_u_localplayer, "Loadout", function()
		-- upvalues: (copy) v_u1
		v_u1()
	end)
	v_u_new:Add(function()
		-- upvalues: (ref) v_u4, (ref) v_u_localplayer, (copy) v_u_createlistener
		v_u4.RemoveListener(v_u_localplayer, "Loadout", v_u_createlistener)
	end, true, "LoadoutListener")
	local v2 = require(v_u_replicatedstorage.Database.Components.GameState)
	local v_u3 = require(v_u_replicatedstorage.Controllers.SpectateController)
	v2.ListenToState(function(_, arg2)
		-- upvalues: (ref) v_u_localplayer, (copy) v_u3, (ref) v_u25, (ref) v_u1
		if arg2 == "Game Ending" or arg2 == "Map Voting" then
			if v_u_localplayer:GetAttribute("IsSpectating") then
				v_u3.Stop(false, true)
			end
			if v_u25() then
				v_u1.ShowMenuScene()
			end
		end
	end)
end
function v_u1.Start() end
return v_u1