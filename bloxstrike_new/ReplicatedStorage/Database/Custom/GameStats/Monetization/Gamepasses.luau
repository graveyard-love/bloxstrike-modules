-- game.ReplicatedStorage.Database.Custom.GameStats.Monetization.Gamepasses

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_run = game:GetService("RunService")
require(v_replicatedstorage.Database.Security.Router)
local v_u_isserver = v_run:IsServer()
local v1 = {
	["Quick Open"] = {
		["GamepassId"] = 1667852725,
		["UpdateOnJoin"] = true,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver
			assert(v_u_isserver, "This function should only be called in studio.")
			arg1:SetAttribute("SpeedCaseOpen", true)
			return {
				["success"] = true
			}
		end
	}
}
return table.freeze(v1)