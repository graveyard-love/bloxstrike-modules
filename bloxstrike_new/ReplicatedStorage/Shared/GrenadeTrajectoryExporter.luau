-- game.ReplicatedStorage.Shared.GrenadeTrajectoryExporter

local v_u_http = game:GetService("HttpService")
local v_u1 = {
	["startRecording"] = function(arg1, arg2, arg3, arg4, arg5, arg6)
		local v1 = {
			["grenade_type"] = arg1,
			["throw_type"] = arg2,
			["start_position"] = { arg3.X, arg3.Y, arg3.Z }
		}
		local v_unit = arg4.Unit
		v1.throw_direction = { v_unit.X, v_unit.Y, v_unit.Z }
		v1.player_velocity = { arg5.X, arg5.Y, arg5.Z }
		v1.player_state = arg6 or "standing"
		v1.map_name = ""
		v1.start_time = tick()
		v1.points = {}
		v1.bounces = {}
		v1.end_position = nil
		v1.end_reason = nil
		return v1
	end,
	["recordPoint"] = function(arg1, arg2, arg3)
		local v_floor = math.floor(arg2.simulationTime * 1000)
		if arg3 or v_floor - (#arg1.points <= 0 and -16 or arg1.points[#arg1.points].time_ms) >= 16 then
			local v1 = {
				["time_ms"] = v_floor
			}
			local v_position = arg2.position
			v1.position = { v_position.X, v_position.Y, v_position.Z }
			local v_velocity = arg2.velocity
			v1.velocity = { v_velocity.X, v_velocity.Y, v_velocity.Z }
			v1.speed = arg2.velocity.Magnitude
			table.insert(arg1.points, v1)
		end
	end,
	["recordBounce"] = function(arg1, arg2, arg3, arg4)
		local v1 = arg2.normal or Vector3.new(0, 1, 0)
		local v_velocity = arg2.velocity
		local v2 = {
			["time_ms"] = math.floor((arg2.timestamp - (arg1.start_time or arg2.timestamp)) * 1000)
		}
		local v_position = arg2.position
		v2.position = { v_position.X, v_position.Y, v_position.Z }
		v2.velocity_before = { arg3.X, arg3.Y, arg3.Z }
		v2.velocity_after = { v_velocity.X, v_velocity.Y, v_velocity.Z }
		v2.surface_normal = { v1.X, v1.Y, v1.Z }
		v2.surface_type = arg4 or "world"
		local v_magnitude = arg3.Magnitude
		local v3
		if v_magnitude < 0.001 then
			v3 = 0
		else
			local v_dot = (arg3 / v_magnitude):Dot(v1)
			local v_abs = math.abs(v_dot)
			local v_clamp = math.clamp(v_abs, -1, 1)
			local v_acos = math.acos(v_clamp)
			v3 = math.deg(v_acos)
		end
		v2.incident_angle = v3
		local v_magnitude = v_velocity.Magnitude
		local v4
		if v_magnitude < 0.001 then
			v4 = 0
		else
			local v_dot = (v_velocity / v_magnitude):Dot(v1)
			local v_abs = math.abs(v_dot)
			local v_clamp = math.clamp(v_abs, -1, 1)
			local v_acos = math.acos(v_clamp)
			v4 = math.deg(v_acos)
		end
		v2.reflection_angle = v4
		table.insert(arg1.bounces, v2)
	end,
	["finishRecording"] = function(arg1, arg2, arg3)
		arg1.end_position = { arg2.X, arg2.Y, arg2.Z }
		arg1.end_reason = arg3
	end,
	["exportJSON"] = function(arg1, arg2)
		-- upvalues: (copy) v_u_http
		local v1 = {
			["metadata"] = {
				["source"] = "roblox",
				["grenade_type"] = arg1.grenade_type,
				["throw_type"] = arg1.throw_type,
				["map"] = arg2 or (arg1.map_name or ""),
				["coordinate_system"] = {
					["up_axis"] = "y",
					["unit"] = "studs"
				}
			},
			["throw_params"] = {
				["start_position"] = arg1.start_position,
				["throw_direction"] = arg1.throw_direction,
				["player_velocity"] = arg1.player_velocity,
				["player_state"] = arg1.player_state
			},
			["trajectory"] = arg1.points,
			["bounces"] = arg1.bounces,
			["summary"] = {
				["duration_ms"] = #arg1.points <= 0 and 0 or arg1.points[#arg1.points].time_ms,
				["bounce_count"] = #arg1.bounces,
				["end_position"] = arg1.end_position,
				["end_reason"] = arg1.end_reason
			}
		}
		return v_u_http:JSONEncode(v1)
	end,
	["simulateAndExport"] = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
		-- upvalues: (copy) v_u1
		local v_calculatethrowparameters, v1 = arg1.calculateThrowParameters(arg4, arg5, arg3, arg7.rangeScale)
		local v_createinitialstate = arg1.createInitialState(v_calculatethrowparameters, v1, arg3, arg6, arg7.rangeScale, tick())
		local v_startrecording = v_u1.startRecording(arg2, arg3 == "Far" and "left" or "right", v_calculatethrowparameters, v1, arg6, arg6.Magnitude > 1 and "walking" or "standing")
		v_u1.recordPoint(v_startrecording, v_createinitialstate, true)
		local v2 = 0
		while not v_createinitialstate.isAtRest and v2 < 10000 do
			v2 = v2 + 1
			local v_velocity = v_createinitialstate.velocity
			local v_simulate = arg1.simulate(v_createinitialstate, arg7, arg8, 0.016666666666666666)
			v_createinitialstate = v_simulate.state
			v_u1.recordPoint(v_startrecording, v_createinitialstate)
			for _, v3 in v_simulate.events do
				if v3.type == "bounce" then
					v_u1.recordBounce(v_startrecording, v3, v_velocity)
				elseif v3.type == "rest" or (v3.type == "fuse" or v3.type == "floor_impact") then
					v_u1.finishRecording(v_startrecording, v3.position, v3.type)
				end
			end
		end
		if not v_startrecording.end_reason then
			v_u1.finishRecording(v_startrecording, v_createinitialstate.position, "timeout")
		end
		v_u1.recordPoint(v_startrecording, v_createinitialstate, true)
		return v_u1.exportJSON(v_startrecording, arg9)
	end
}
return v_u1