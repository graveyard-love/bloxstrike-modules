-- game.ReplicatedStorage.Interface.Screens.Gameplay.Middle.HoverBomb

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_collection = game:GetService("CollectionService")
local v_u_userinput = game:GetService("UserInputService")
local v_u_run = game:GetService("RunService")
local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.InputController)
local v_u3 = require(v_replicatedstorage.Controllers.DataController)
local v_u4 = require(v_replicatedstorage.Database.Security.Router)
local v5 = require(v_replicatedstorage.Components.Common.GetUserPlatform)
local v_u_find = table.find(v5(), "Mobile")
if v_u_find then
	v_u_find = #v5() <= 1
end
local v_u6 = nil
local v_u7 = false
local v_u8 = nil
function v_u1.GetHoverState()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_collection
	if v_u_localplayer:GetAttribute("Team") == "Counter-Terrorists" then
		local v1 = v_u_collection:GetTagged("Bomb")[1]
		if v1 then
			return v1:GetAttribute("CanDefuse") and not v1:GetAttribute("Defused") and true or false
		else
			return false
		end
	else
		return false
	end
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u8, (copy) v_u_find, (copy) v_u2, (copy) v_u3, (copy) v_u_localplayer, (copy) v_u_run, (copy) v_u1, (ref) v_u7, (copy) v_u_collection, (ref) v_u6, (copy) v_u4, (copy) v_u_userinput
	v_u8 = arg2
	local function v_u1()
		-- upvalues: (ref) v_u_find, (ref) v_u8, (ref) v_u2
		if v_u_find then
			v_u8.Text = "Hold to Defuse"
		else
			local v_use = v_u2.GetActionKeybind("Use")
			v_u8.Text = ("[%*] Defuse Bomb"):format(not v_use and "E" or v_use:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""))
		end
	end
	if v_u_find then
		v_u8.Text = "Hold to Defuse"
	else
		local v_use = v_u2.GetActionKeybind("Use")
		v_u8.Text = ("[%*] Defuse Bomb"):format(not v_use and "E" or v_use:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""))
	end
	v_u3.CreateListener(v_u_localplayer, "Settings.Keyboard/Mouse", function(arg1)
		-- upvalues: (copy) v_u1
		if arg1 then
			task.defer(v_u1)
		end
	end)
	v_u_run.Heartbeat:Connect(function(_)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u1, (ref) v_u8, (ref) v_u_find, (ref) v_u7, (ref) v_u_collection, (ref) v_u6, (ref) v_u4
		local v_character = v_u_localplayer.Character
		local v1
		if v_character and v_character:IsDescendantOf(workspace) then
			local v_humanoid = v_character:FindFirstChild("Humanoid")
			v1 = v_humanoid and v_humanoid.Health > 0 and true or false
		else
			v1 = false
		end
		if v1 then
			local v_gethoverstate = v_u1.GetHoverState()
			v_u8.Visible = v_gethoverstate
			if v_u_find and (v_u7 and not v_gethoverstate) then
				local v2 = v_u_collection:GetTagged("Bomb")[1]
				if v2 then
					v2 = v2:GetAttribute("Defused")
				end
				v_u7 = false
				v_u6 = nil
				if not v2 then
					v_u4.broadcastRouter("Cancel Defuse Bomb")
					return
				end
			end
		elseif v_u_find and v_u7 then
			v_u7 = false
			v_u6 = nil
		end
	end)
	if v_u_find then
		v_u_userinput.TouchStarted:Connect(function(arg1, arg2)
			-- upvalues: (ref) v_u1, (ref) v_u_localplayer, (ref) v_u7, (ref) v_u6, (ref) v_u4
			if not arg2 then
				if v_u1.GetHoverState() then
					local v_character = v_u_localplayer.Character
					local v1
					if v_character and v_character:IsDescendantOf(workspace) then
						local v_humanoid = v_character:FindFirstChild("Humanoid")
						v1 = v_humanoid and v_humanoid.Health > 0 and true or false
					else
						v1 = false
					end
					if v1 and not v_u7 then
						v_u6 = arg1
						v_u7 = true
						v_u4.broadcastRouter("Start Defuse Bomb")
					end
				end
			end
		end)
		v_u_userinput.TouchEnded:Connect(function(arg1, _)
			-- upvalues: (ref) v_u6, (ref) v_u7, (ref) v_u4
			if arg1 == v_u6 then
				v_u6 = nil
				if v_u7 then
					v_u7 = false
					v_u4.broadcastRouter("Cancel Defuse Bomb")
				end
			end
		end)
	end
end
return v_u1