-- game.ReplicatedStorage.Interface.Screens.Gameplay.Middle.SessionStats

local v1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u2 = require(v_replicatedstorage.Database.Custom.Constants)
local v_u3 = require(v_replicatedstorage.Controllers.DataController)
local v_u4 = require(v_replicatedstorage.Packages.Observers)
local v_u_clock = os.clock()
local v_u5 = 0
local v_u6 = 0
local v_u7 = {}
local v_u8 = nil
local function v_u9(_, arg2)
	-- upvalues: (copy) v_u3, (copy) v_u_localplayer, (copy) v_u7, (ref) v_u8
	local v_get = v_u3.Get(v_u_localplayer, "Settings.Game.Other.Show FPS")
	local v_get = v_u3.Get(v_u_localplayer, "Settings.Game.Other.Show Ping")
	local v1 = 0
	for _, v2 in ipairs(v_u7) do
		v1 = v1 + v2
	end
	local v_round = math.round(v1 / #v_u7)
	local v3 = {}
	if v_get == true then
		local v_format = ("Ping: %*ms"):format(arg2)
		table.insert(v3, v_format)
	end
	if v_get == true then
		local v_format = ("Fps: %*"):format((tostring(v_round)))
		table.insert(v3, v_format)
	end
	v_u8.Player.Text = table.concat(v3, ", ")
end
function v1.Initialize(_, arg2)
	-- upvalues: (ref) v_u8, (copy) v_u3, (copy) v_u_localplayer, (copy) v_u9, (ref) v_u5, (ref) v_u6, (copy) v_u_run, (copy) v_u7, (ref) v_u_clock, (copy) v_u4, (copy) v_u2
	v_u8 = arg2
	v_u3.CreateListener(v_u_localplayer, "Settings.Game.Other.Show FPS", function()
		-- upvalues: (ref) v_u8, (ref) v_u9, (ref) v_u5, (ref) v_u6
		if v_u8.Visible then
			v_u9(v_u5, v_u6)
		end
	end)
	v_u3.CreateListener(v_u_localplayer, "Settings.Game.Other.Show Ping", function()
		-- upvalues: (ref) v_u8, (ref) v_u9, (ref) v_u5, (ref) v_u6
		if v_u8.Visible then
			v_u9(v_u5, v_u6)
		end
	end)
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u8, (ref) v_u_localplayer, (ref) v_u7, (ref) v_u5, (ref) v_u6, (ref) v_u_clock, (ref) v_u9
		if v_u8.Visible then
			local v_ping = v_u_localplayer:GetAttribute("Ping")
			local v1 = tonumber(v_ping) or 999
			local v_round = math.round(1 / arg1)
			local v_clock = os.clock()
			table.insert(v_u7, v_round)
			v_u5 = v_round
			v_u6 = v1
			if v_clock - v_u_clock >= 1 then
				v_u9(v_round, v1)
				v_u_clock = v_clock
				table.clear(v_u7)
			end
		end
	end)
	return v_u4.observeAttribute(workspace, "Timezone", function(arg1)
		-- upvalues: (ref) v_u8, (ref) v_u2
		v_u8.Server.Text = ("Location: %*, Version: %*"):format(arg1, v_u2.VERSION)
		return function()
			-- upvalues: (ref) v_u8, (ref) v_u2
			v_u8.Server.Text = ("Location: Unknown, Version: %*"):format(v_u2.VERSION)
		end
	end)
end
return v1