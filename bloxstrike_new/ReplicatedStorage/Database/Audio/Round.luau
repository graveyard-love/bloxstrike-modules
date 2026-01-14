-- game.ReplicatedStorage.Database.Audio.Round

local v1 = {}
local v2 = {
	["Identifiers"] = { 102242832333292 },
	["Properties"] = {
		["Volume"] = 1.5
	}
}
v1["Round Start Countdown"] = v2
local v3 = {
	["Identifiers"] = { 138806965930837 },
	["Properties"] = {
		["Volume"] = 0.333,
		["Looped"] = false
	}
}
v1["Buy Phase"] = v3
local v4 = {
	["Identifiers"] = { 119219669735264 },
	["Properties"] = {
		["Volume"] = 1
	}
}
v1.Draw = v4
local v5 = {
	["Identifiers"] = { 125321230056670 },
	["Properties"] = {
		["Volume"] = 1
	}
}
v1["Counter-Terrorists Win"] = v5
local v6 = {
	["Identifiers"] = { 88851292403698 },
	["Properties"] = {
		["Volume"] = 1
	}
}
v1["Terrorists Win"] = v6
local v7 = {
	["Identifiers"] = { 93457830354254 },
	["Properties"] = {
		["RollOffMaxDistance"] = 0,
		["RollOffMinDistance"] = 0,
		["Volume"] = 0.333,
		["Looped"] = false
	}
}
v1.MVP = v7
return table.freeze(v1)