-- game.ReplicatedStorage.Controllers.InputController.Actions.CycleGrenades

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
require(v_replicatedstorage.Controllers.InventoryController)
local v_u1 = require(v_replicatedstorage.Controllers.CaseSceneController)
local v_u2 = require(v_replicatedstorage.Controllers.InspectController)
local v_u3 = require(v_replicatedstorage.Components.Common.UserInput.EquipInventorySlot)
return table.freeze({
	["Name"] = "Cycle Grenades",
	["Group"] = "Gameplay",
	["Category"] = "Weapon Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u1, (copy) v_u2, (copy) v_u3
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		elseif arg1 == Enum.UserInputState.Begin then
			if not (v_u1.IsActive() or v_u2.IsActive()) then
				v_u3(4)
			end
		else
			return
		end
	end
})