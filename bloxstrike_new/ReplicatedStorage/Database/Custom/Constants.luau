-- game.ReplicatedStorage.Database.Custom.Constants

local v1 = {
	["VERSION"] = "0.0.8",
	["DEFAULT_CAMERA_FOV"] = 70,
	["PLATFORM_PLACE_IDS"] = {
		["MOBILE"] = 0
	},
	["GAMEMODE_PLACE_IDS"] = {
		["Competitive"] = 0,
		["Deathmatch"] = 0,
		["Casual"] = game.PlaceId
	}
}
return table.freeze(v1)