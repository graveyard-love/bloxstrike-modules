-- game.ReplicatedStorage.Shared.GrenadeSimulator

local v_u1 = {}
local v_u2 = -(Vector3.new(0, -23.833334, 0)).Y
v_u1.Constants = {
	["SOURCE_TO_STUDS"] = 0.0763888888888889,
	["SV_GRAVITY"] = 800,
	["GRENADE_GRAVITY_SCALE"] = 0.39,
	["GRENADE_ELASTICITY"] = 0.4,
	["JUMP_THROW_ELASTICITY"] = 0.32,
	["PLAYER_ELASTICITY"] = 0.3,
	["MIN_ELASTICITY"] = 0,
	["MAX_ELASTICITY"] = 0.9,
	["MAX_THROW_VELOCITY_SOURCE"] = 750,
	["PLAYER_VELOCITY_SCALE"] = 1.5,
	["SLEEP_VELOCITY_SOURCE"] = 20,
	["STOP_EPSILON_SOURCE"] = 0.1,
	["FLOOR_NORMAL_THRESHOLD"] = 0.7,
	["OVERBOUNCE"] = 2,
	["FIXED_TIMESTEP"] = 0.0078125,
	["MAX_BOUNCES"] = 20,
	["THROW_POWER_SCALE"] = 0.7,
	["THROW_POWER_BASE"] = 0.3,
	["VELOCITY_SCALE"] = 0.58,
	["GRAVITY"] = Vector3.new(0, -23.833334, 0),
	["MAX_THROW_VELOCITY"] = 57.29166666666667,
	["SLEEP_VELOCITY"] = 1.527777777777778,
	["STOP_EPSILON"] = 0.0076388888888888895,
	["THROW_UPWARD_BIAS_FAR"] = 0.06,
	["THROW_UPWARD_BIAS_NEAR"] = 0.04,
	["THROW_FORWARD_OFFSET"] = 1.35,
	["THROW_HEIGHT_OFFSET"] = 2.4,
	["PLAYER_VELOCITY_INHERITANCE"] = 1.5,
	["PLAYER_VERTICAL_VELOCITY_SCALE"] = 2,
	["GROUND_CHECK_DISTANCE"] = 0.2,
	["MAX_SIMULATION_TIME"] = 10,
	["JUMP_THROW_DETECTION_THRESHOLD"] = 5,
	["JUMP_THROW_HORIZONTAL_DAMPENING"] = 1,
	["JUMP_THROW_FIXED_VERTICAL"] = 20,
	["JUMP_THROW_HEIGHT_BONUS"] = 0,
	["MAX_THROW_SPEED"] = 50,
	["MAX_JUMP_THROW_SPEED"] = 62,
	["MAX_ACCUMULATED_TIME"] = 0.1,
	["MAX_ITERATIONS_PER_FRAME"] = 16
}
function v_u1.createInitialState(arg1, arg2, arg3, arg4, arg5, arg6)
	local v1 = ((arg3 == "Far" and 1 or 0) * 0.7 + 0.3) * 57.29166666666667 * arg5 * 0.58
	local v2 = arg4.Y > 5
	local v3 = 1
	if v2 then
		arg1 = arg1 + Vector3.new(0, 0, 0)
	end
	local v4 = v2 and Vector3.new(0, 20, 0) or Vector3.new(0, arg4.Y * 2 * 0.58, 0)
	local v5
	if v2 then
		v5 = Vector3.new(arg2.X * v3, arg2.Y, arg2.Z * v3).Unit
	else
		v5 = arg2
	end
	local v6 = not v2 and 1 or v3
	local v7 = v5 * v1 + v4 + (Vector3.new(arg2.X * v6, arg2.Y, arg2.Z * v6).Unit * v1 * 0.15 + Vector3.new(0, arg5 * 6.5 * 0.58, 0))
	local v8 = not v2 and 50 or (arg2.Y - 0.4) * 20 + 62
	local v_magnitude = v7.Magnitude
	if v8 < v7.Magnitude then
		v7 = v7.Unit * v8
	end
	local v9 = v7 + Vector3.new(arg4.X, 0, arg4.Z) * 1.5 * v3
	print(string.format("[SIMULATOR] throwSpeed=%.2f | uncapped=%.2f | capped=%.2f | throwDir.Y=%.3f | isJump=%s", v1, v_magnitude, v9.Magnitude, arg2.Y, (tostring(v2))))
	local v10 = math.floor(arg6 * 1000) % 1000
	return {
		["position"] = arg1,
		["velocity"] = v9,
		["angularVelocity"] = Vector3.new(v10 % 11 - 5, math.floor(v10 / 11) % 13 - 6, math.floor(v10 / 143) % 11 - 5),
		["timestamp"] = arg6,
		["simulationTime"] = 0,
		["bounceCount"] = 0,
		["isGrounded"] = false,
		["isAtRest"] = false,
		["hasTouched"] = false,
		["accumulatedTime"] = 0,
		["isJumpThrow"] = v2
	}
end
function v_u1.createConfig(arg1, arg2, arg3, arg4, arg5, arg6)
	return {
		["radius"] = arg1,
		["restitution"] = 0.4,
		["maxBounces"] = 20,
		["fuseTime"] = arg4,
		["minimumFuseTime"] = arg5,
		["explodeOnFloorImpact"] = arg6,
		["rangeScale"] = arg2,
		["isNearThrow"] = arg3
	}
end
function v_u1.detectCollision(arg1, arg2, arg3, arg4)
	local v1 = arg2 - arg1
	local v_magnitude = v1.Magnitude
	if v_magnitude < 0.001 then
		return nil
	end
	local v2 = arg3 * 0.01
	local v3 = {
		Vector3.new(v2, 0, 0),
		Vector3.new(-v2, 0, 0),
		Vector3.new(0, v2, 0),
		Vector3.new(0, -v2, 0),
		Vector3.new(0, 0, v2),
		(Vector3.new(0, 0, -v2))
	}
	local v4 = (1 / 0)
	local v_raycast = workspace:Raycast(arg1, v1, arg4)
	local v5
	if v_raycast and v_raycast.Distance < v4 then
		v4 = v_raycast.Distance
		v5 = Vector3.new(0, 0, 0)
	else
		v_raycast = nil
		v5 = Vector3.new(0, 0, 0)
	end
	for _, v6 in v3 do
		local v_raycast = workspace:Raycast(arg1 + v6, v1, arg4)
		if v_raycast and v_raycast.Distance < v4 then
			v4 = v_raycast.Distance
			v5 = v6
			v_raycast = v_raycast
		end
	end
	if not v_raycast then
		return nil
	end
	local v7 = v_raycast.Position - v5
	local v_magnitude = (v7 - arg1).Magnitude
	if v_magnitude + v2 + 0.1 < v_magnitude then
		return nil
	end
	local v_instance = v_raycast.Instance
	local v_parent = v_instance.Parent
	local v8
	if v_parent then
		v8 = v_parent:FindFirstChild("Humanoid") ~= nil
	else
		v8 = v_parent
	end
	return {
		["hit"] = true,
		["position"] = v7,
		["normal"] = v_raycast.Normal,
		["distance"] = v_magnitude,
		["instance"] = v_instance,
		["isPlayer"] = v8,
		["isGlass"] = v_parent and v_parent:HasTag("BreakableGlass") or v_instance:HasTag("BreakableGlass")
	}
end
function v_u1.checkGrounded(arg1, arg2)
	local v_raycast = workspace:Raycast(arg1, Vector3.new(0, -0.2, 0), arg2)
	if v_raycast then
		return true, v_raycast.Normal
	else
		return false, nil
	end
end
function v_u1.checkSurfaceContact(arg1, arg2, arg3)
	local v1 = arg2 + 0.1
	for _, v2 in {
		Vector3.new(0, -1, 0),
		Vector3.new(0, 1, 0),
		Vector3.new(1, 0, 0),
		Vector3.new(-1, 0, 0),
		Vector3.new(0, 0, 1),
		Vector3.new(0, 0, -1)
	} do
		local v_raycast = workspace:Raycast(arg1, v2 * v1, arg3)
		if v_raycast and v_raycast.Distance < v1 then
			return true, v_raycast.Normal
		end
	end
	return false, nil
end
local function v_u3(arg1, arg2, arg3)
	local v1 = arg1:Dot(arg2) * arg3
	local v2 = arg1.X - arg2.X * v1
	local v3 = arg1.Y - arg2.Y * v1
	local v4 = arg1.Z - arg2.Z * v1
	return Vector3.new(math.abs(v2) < 0.0076388888888888895 and 0 or v2, math.abs(v3) < 0.0076388888888888895 and 0 or v3, math.abs(v4) < 0.0076388888888888895 and 0 or v4)
end
function v_u1.integrate(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u2
	if arg4 then
		return arg1 + arg2 * arg3, arg2
	end
	local v1 = arg2.Y - v_u2 * arg3
	local v_new = Vector3.new(arg2.X * arg3, (arg2.Y + v1) / 2 * arg3, arg2.Z * arg3)
	local v_new = Vector3.new(arg2.X, v1, arg2.Z)
	return arg1 + v_new, v_new
end
function v_u1.calculateBounce(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u3
	local v_clone = table.clone(arg3)
	local v_clamp = math.clamp((arg3.isJumpThrow and 0.32 or 0.4) * (arg4 and 0.3 or 1), 0, 0.9)
	local v1 = v_u3(arg1, arg2, 2) * v_clamp
	if arg2.Y <= 0.7 or v1:Dot(v1) >= 2.3341049382716053 then
		v_clone.bounceCount = arg3.bounceCount + 1
		v_clone.hasTouched = true
		return v1, v_clone
	end
	v_clone.bounceCount = arg3.bounceCount + 1
	v_clone.hasTouched = true
	v_clone.isAtRest = true
	return Vector3.new(0, 0, 0), v_clone
end
function v_u1.shouldStop(arg1, arg2, arg3)
	if arg2 and arg3 then
		return arg1:Dot(arg1) < 2.3341049382716053
	else
		return false
	end
end
function v_u1.step(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u1
	local v_clone = table.clone(arg1)
	v_clone.simulationTime = arg1.simulationTime + arg4
	local v1 = nil
	if v_clone.simulationTime >= 10 then
		v_clone.isAtRest = true
		return v_clone, {
			["type"] = "timeout",
			["timestamp"] = arg1.timestamp + v_clone.simulationTime,
			["position"] = v_clone.position,
			["normal"] = Vector3.new(0, 1, 0),
			["velocity"] = v_clone.velocity,
			["bounceCount"] = v_clone.bounceCount
		}
	end
	if arg2.fuseTime and v_clone.simulationTime >= arg2.fuseTime then
		v_clone.isAtRest = true
		return v_clone, {
			["type"] = "fuse",
			["timestamp"] = arg1.timestamp + v_clone.simulationTime,
			["position"] = v_clone.position,
			["normal"] = Vector3.new(0, 1, 0),
			["velocity"] = v_clone.velocity,
			["bounceCount"] = v_clone.bounceCount
		}
	end
	if arg1.bounceCount >= arg2.maxBounces then
		v_clone.isAtRest = true
		v_clone.velocity = Vector3.new(0, 0, 0)
		return v_clone, {
			["type"] = "rest",
			["timestamp"] = arg1.timestamp + v_clone.simulationTime,
			["position"] = v_clone.position,
			["normal"] = Vector3.new(0, 1, 0),
			["velocity"] = Vector3.new(0, 0, 0),
			["bounceCount"] = v_clone.bounceCount
		}
	end
	local v_integrate, v2 = v_u1.integrate(v_clone.position, v_clone.velocity, arg4, v_clone.isGrounded)
	local v_detectcollision = v_u1.detectCollision(v_clone.position, v_integrate, arg2.radius, arg3)
	if v_detectcollision then
		local v3
		v3, v_clone = v_u1.calculateBounce(v2, v_detectcollision.normal, v_clone, v_detectcollision.isPlayer)
		v_clone.position = v_detectcollision.position + v_detectcollision.normal * 0.05
		v_clone.velocity = v3
		if arg2.explodeOnFloorImpact and v_detectcollision.normal.Y > 0.7 and (not arg2.minimumFuseTime or v_clone.simulationTime >= arg2.minimumFuseTime) then
			v_clone.isAtRest = true
			return v_clone, {
				["type"] = "floor_impact",
				["timestamp"] = arg1.timestamp + v_clone.simulationTime,
				["position"] = v_clone.position,
				["normal"] = v_detectcollision.normal,
				["velocity"] = v_clone.velocity,
				["bounceCount"] = v_clone.bounceCount
			}
		end
		v1 = {
			["type"] = "bounce",
			["timestamp"] = arg1.timestamp + v_clone.simulationTime,
			["position"] = v_clone.position,
			["normal"] = v_detectcollision.normal,
			["velocity"] = v_clone.velocity,
			["bounceCount"] = v_clone.bounceCount
		}
	else
		v_clone.position = v_integrate
		v_clone.velocity = v2
	end
	local v_checkgrounded, v4 = v_u1.checkGrounded(v_clone.position, arg3)
	v_clone.isGrounded = v_checkgrounded
	if not v_u1.shouldStop(v_clone.velocity, v_checkgrounded, v_clone.hasTouched) or (arg2.minimumFuseTime and v_clone.simulationTime < arg2.minimumFuseTime or arg2.fuseTime) then
		return v_clone, v1
	end
	v_clone.isAtRest = true
	v_clone.velocity = Vector3.new(0, 0, 0)
	v_clone.angularVelocity = Vector3.new(0, 0, 0)
	return v_clone, {
		["type"] = "rest",
		["timestamp"] = arg1.timestamp + v_clone.simulationTime,
		["position"] = v_clone.position,
		["normal"] = v4 or Vector3.new(0, 1, 0),
		["velocity"] = Vector3.new(0, 0, 0),
		["bounceCount"] = v_clone.bounceCount
	}
end
function v_u1.simulate(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u1
	if arg1.isAtRest then
		if not arg2.fuseTime then
			return {
				["state"] = arg1,
				["events"] = {}
			}
		end
		local v_clone = table.clone(arg1)
		v_clone.simulationTime = arg1.simulationTime + arg4
		return v_clone.simulationTime >= arg2.fuseTime and {
			["state"] = v_clone,
			["events"] = {
				{
					["type"] = "fuse",
					["timestamp"] = arg1.timestamp + v_clone.simulationTime,
					["position"] = v_clone.position,
					["normal"] = Vector3.new(0, 1, 0),
					["velocity"] = v_clone.velocity,
					["bounceCount"] = v_clone.bounceCount
				}
			}
		} or {
			["state"] = v_clone,
			["events"] = {}
		}
	end
	local v_clone = table.clone(arg1)
	v_clone.accumulatedTime = arg1.accumulatedTime + arg4
	local v1, v2
	if v_clone.accumulatedTime > 0.1 then
		v_clone.accumulatedTime = 0.1
		v1 = 0
		v2 = {}
	else
		v1 = 0
		v2 = {}
	end
	while v_clone.accumulatedTime >= 0.0078125 and v1 < 16 do
		v1 = v1 + 1
		v_clone.accumulatedTime = v_clone.accumulatedTime - 0.0078125
		local v3
		v_clone, v3 = v_u1.step(v_clone, arg2, arg3, 0.0078125)
		if v3 then
			table.insert(v2, v3)
		end
		if v_clone.isAtRest then
			break
		end
	end
	return {
		["state"] = v_clone,
		["events"] = v2
	}
end
function v_u1.calculateThrowParameters(arg1, arg2, arg3, arg4)
	local v1 = arg3 == "Near"
	local v2 = (v1 and 0.04 or 0.06) * math.clamp(arg4, 0.8, 1.2)
	local v3 = 1.35
	local v4 = 2.4
	local v5
	if v1 then
		v3 = v3 * 0.55
		v5 = v4 * 0.8
		v2 = v2 + 0.08
	else
		v5 = v4 + 0.1
	end
	local v_new = Vector3.new(arg2.X, 0, arg2.Z)
	return arg1 + (v_new.Magnitude < 0.01 and Vector3.new(0, 0, -1) or v_new).Unit * v3 + Vector3.new(0, v5, 0), (arg2 + Vector3.new(0, v2, 0)).Unit
end
function v_u1.interpolateState(arg1, arg2, arg3)
	local v_clone = table.clone(arg2)
	v_clone.position = arg1.position:Lerp(arg2.position, arg3)
	v_clone.velocity = arg1.velocity:Lerp(arg2.velocity, arg3)
	v_clone.angularVelocity = arg1.angularVelocity:Lerp(arg2.angularVelocity, arg3)
	return v_clone
end
return v_u1