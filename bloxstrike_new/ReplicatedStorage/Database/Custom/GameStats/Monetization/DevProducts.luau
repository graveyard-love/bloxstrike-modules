-- game.ReplicatedStorage.Database.Custom.GameStats.Monetization.DevProducts

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_run = game:GetService("RunService")
local v_u1 = require(v_replicatedstorage.Database.Security.Router)
local v_u_isserver = v_run:IsServer()
local v2 = {
	["+ 300 Credits"] = {
		["DevProductId"] = 3470475421,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Credits Purchased", arg1, 300)
		end
	},
	["+ 945 Credits"] = {
		["DevProductId"] = 3470475672,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Credits Purchased", arg1, 945)
		end
	},
	["+ 2,700 Credits"] = {
		["DevProductId"] = 3470475956,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Credits Purchased", arg1, 2700)
		end
	},
	["+ 9,500 Credits"] = {
		["DevProductId"] = 3470476338,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Credits Purchased", arg1, 9500)
		end
	},
	["Gift + 300 Credits"] = {
		["DevProductId"] = 3471346119,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Gift Credits", arg1, 300)
		end
	},
	["Gift + 945 Credits"] = {
		["DevProductId"] = 3471346271,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Gift Credits", arg1, 945)
		end
	},
	["Gift + 2,700 Credits"] = {
		["DevProductId"] = 3471346363,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Gift Credits", arg1, 2700)
		end
	},
	["Gift + 9,500 Credits"] = {
		["DevProductId"] = 3471346492,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Gift Credits", arg1, 9500)
		end
	},
	["Purchase Featured Bundle"] = {
		["DevProductId"] = 3509675180,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Purchase Featured Bundle", arg1)
		end
	},
	["M4A1-S | Anodized Red"] = {
		["DevProductId"] = 3509674752,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Purchase Featured Package", arg1, "M4A1-S | Anodized Red")
		end
	},
	["AUG | Anodized Red"] = {
		["DevProductId"] = 3509674200,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Purchase Featured Package", arg1, "AUG | Anodized Red")
		end
	},
	["MP-9 | Anodized Red"] = {
		["DevProductId"] = 3509673950,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Purchase Featured Package", arg1, "MP-9 | Anodized Red")
		end
	},
	["Gift Featured Bundle"] = {
		["DevProductId"] = 3509675371,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Gift Featured Bundle", arg1)
		end
	},
	["Gift M4A1-S | Anodized Red"] = {
		["DevProductId"] = 3509675670,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Gift Featured Package", arg1, "M4A1-S | Anodized Red")
		end
	},
	["Gift AUG | Anodized Red"] = {
		["DevProductId"] = 3509675934,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Gift Featured Package", arg1, "AUG | Anodized Red")
		end
	},
	["Gift MP-9 | Anodized Red"] = {
		["DevProductId"] = 3509676191,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Gift Featured Package", arg1, "MP-9 | Anodized Red")
		end
	}
}
return table.freeze(v2)