-- game.ReplicatedStorage.Interface.Screens.Gameplay.Middle.RoundWonT

local v1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Database.Components.GameState)
local v_u3 = require(v_replicatedstorage.Controllers.DataController)
local v_u4 = require(v_replicatedstorage.Classes.Sound)
local v_u5 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u_localplayer = v_u_players.LocalPlayer
local v_u6 = nil
local v_u7 = nil
local v_u8 = nil
local v_u9 = nil
local v_u10 = nil
local function v_u11()
	-- upvalues: (copy) v_u_players
	local v1 = 0
	local v2 = 0
	for _, v3 in ipairs(v_u_players:GetPlayers()) do
		local v_team = v3:GetAttribute("Team")
		if v_team == "Counter-Terrorists" or v_team == "Terrorists" then
			local v_character = v3.Character
			if v_character and (v_character:IsDescendantOf(workspace) and not v_character:GetAttribute("Dead")) then
				local v_humanoid = v_character:FindFirstChild("Humanoid")
				if v_humanoid and (v_humanoid.Health > 0 and not v3:GetAttribute("IsSpectating")) then
					if v_team == "Counter-Terrorists" then
						v2 = v2 + 1
					elseif v_team == "Terrorists" then
						v1 = v1 + 1
					end
				end
			end
		end
	end
	local v4
	if v2 > 0 then
		v4 = v1 > 0
	else
		v4 = false
	end
	return v4
end
local function v_u12()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u3, (copy) v_u11, (ref) v_u10, (copy) v_u4
	local v_playergui = v_u_localplayer:WaitForChild("PlayerGui")
	local v_mvp = v_playergui:FindFirstChild("MVP")
	if v_mvp and (v_mvp:IsA("Sound") and v_mvp.IsPlaying) then
		return
	elseif v_u3.Get(v_u_localplayer, "Settings.Audio.Other.Mute MVP Music when players on both teams are alive") ~= true or not v_u11() then
		local v1 = (v_u3.Get(v_u_localplayer, "Settings.Audio.Music.MVP Volume") or 50) / 50
		if v1 > 0 and v_u4.new("Round"):play({
			["Parent"] = v_playergui,
			["Name"] = "MVP"
		}, v1) then
			local v2 = (v_u3.Get(v_u_localplayer, "Settings.Audio.Audio.Master Volume") or 100) / 100
			local v_u_volume = v_u10.Volume
			if v1 > 0 and v2 > 0 then
				v_u_volume = v_u_volume / (v1 * v2) or v_u_volume
			end
			v_u10:SetAttribute("BaseVolume", v_u_volume)
			local function v3()
				-- upvalues: (ref) v_u10, (ref) v_u3, (ref) v_u_localplayer, (copy) v_u_volume
				if v_u10 and v_u10.Parent then
					local v1 = (v_u3.Get(v_u_localplayer, "Settings.Audio.Music.MVP Volume") or 50) / 50
					local v2 = (v_u3.Get(v_u_localplayer, "Settings.Audio.Audio.Master Volume") or 100) / 100
					v_u10.Volume = (v_u10:GetAttribute("BaseVolume") or v_u_volume) * v1 * v2
					if v1 == 0 or v2 == 0 then
						v_u10:Stop()
						v_u10:Destroy()
						v_u10 = nil
					end
				end
			end
			v_u3.CreateListener(v_u_localplayer, "Settings.Audio.Music.MVP Volume", v3)
			v_u3.CreateListener(v_u_localplayer, "Settings.Audio.Audio.Master Volume", v3)
		end
	end
end
local function v_u13(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_players
	local v_mvp = arg1:FindFirstChild("MVP")
	local v1 = v_mvp and v_mvp:FindFirstChild("Text")
	if v1 then
		v1.Text = arg2
	end
	local v_name = arg1:FindFirstChild("Name")
	if v_name then
		v_name.Text = arg3
	end
	local v_player = arg1:FindFirstChild("Player")
	if v_player then
		local v_player = v_player:FindFirstChild("Player")
		local v2 = v_player and v_u_players:FindFirstChild(arg3)
		if v2 then
			v_player.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(v2.UserId)
		end
	end
end
function v1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u6, (ref) v_u7, (ref) v_u8, (ref) v_u9, (copy) v_u2, (copy) v_u_localplayer, (ref) v_u10, (copy) v_u5, (copy) v_u_players, (copy) v_u13, (copy) v_u12
	v_u6 = arg2
	v_u7 = arg1
	v_u8 = v_u7.Gameplay.Middle:FindFirstChild("PlayerMVPCT")
	v_u9 = v_u7.Gameplay.Middle:FindFirstChild("PlayerMVPT")
	v_u2.ListenToState(function(arg1, arg2)
		-- upvalues: (ref) v_u6, (ref) v_u8, (ref) v_u9, (ref) v_u_localplayer, (ref) v_u10
		if arg1 == "Intermission" and arg2 == "Buy Period" or arg2 == "Round In Progress" then
			v_u6.Visible = false
			if v_u8 then
				v_u8.Visible = false
			end
			if v_u9 then
				v_u9.Visible = false
			end
			local v_mvp = v_u_localplayer:WaitForChild("PlayerGui"):FindFirstChild("MVP")
			if v_mvp and v_mvp:IsA("Sound") then
				v_mvp:Stop()
				v_mvp:Destroy()
			end
			v_u10 = nil
		end
	end)
	v_u5.UI.RoundWinner.Listen(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u6
		local v_team = v_u_localplayer:GetAttribute("Team")
		if arg1 == "Terrorists" and v_team == arg1 then
			v_u6.Visible = true
		end
	end)
	v_u5.UI.RoundMVP.Listen(function(arg1)
		-- upvalues: (ref) v_u_players, (ref) v_u8, (ref) v_u13, (ref) v_u9, (ref) v_u12
		if arg1 and (arg1.Team and (arg1.PlayerName and arg1.Reason)) then
			local v_team = arg1.Team
			local v_playername = arg1.PlayerName
			local v_reason = arg1.Reason
			if v_team == "Counter-Terrorists" or v_team == "Terrorists" then
				if v_u_players:FindFirstChild(v_playername) then
					local v1 = v_reason == "Rescued a hostage" and "MVP | Rescued a hostage" or (v_reason == "Defused the bomb" and "MVP | Defused the bomb" or (v_reason == "Planted the bomb" and "MVP | Planted the bomb" or (v_reason == "Most eliminations" and "MVP | Most eliminations" or "MVP")))
					if v_team == "Counter-Terrorists" and v_u8 then
						v_u13(v_u8, v1, v_playername)
						v_u8.Visible = true
						if v_u9 then
							v_u9.Visible = false
						end
						v_u12()
					elseif v_team == "Terrorists" and v_u9 then
						v_u13(v_u9, v1, v_playername)
						v_u9.Visible = true
						if v_u8 then
							v_u8.Visible = false
						end
						v_u12()
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
	end)
end
return v1