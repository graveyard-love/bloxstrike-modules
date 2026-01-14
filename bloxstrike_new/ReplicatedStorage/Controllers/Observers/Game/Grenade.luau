-- game.ReplicatedStorage.Controllers.Observers.Game.Grenade

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
game:GetService("UserInputService")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v1 = require(v_u_replicatedstorage.Packages.Observers)
local v_u2 = require(v_u_replicatedstorage.Shared.Janitor)
local v3 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u4 = require(v_u_replicatedstorage.Shared.GrenadeSimulator)
local v_u_debris = workspace:WaitForChild("Debris")
local v_u5 = {}
for _, v6 in ipairs(script.Executions:GetChildren()) do
	v_u5[v6.Name] = require(v6)
end
local v_u7 = {}
local function v_u8(arg1, arg2)
	-- upvalues: (copy) v_u_debris, (copy) v_u_localplayer
	local v_new = RaycastParams.new()
	v_new.FilterType = Enum.RaycastFilterType.Exclude
	local v1 = { arg1, v_u_debris }
	if v_u_localplayer and v_u_localplayer.Character then
		table.insert(v1, v_u_localplayer.Character)
	end
	v_new.FilterDescendantsInstances = v1
	v_new.RespectCanCollide = true
	v_new.IgnoreWater = true
	if arg2 then
		v_new.CollisionGroup = arg2
	end
	return v_new
end
local function v_u9(arg1, arg2, arg3)
	local v_magnitude = (arg1.state.position - arg2).Magnitude
	if v_magnitude > 8 then
		arg1.state.position = arg2
		arg1.state.velocity = arg3
		arg1.visualPosition = arg2
	elseif v_magnitude > 2 then
		arg1.state.position = arg1.state.position:Lerp(arg2, 0.08)
		arg1.state.velocity = arg1.state.velocity:Lerp(arg3, 0.08)
	end
end
v3.Projectile.Spawn.Listen(function(self)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_debris, (copy) v_u2, (copy) v_u8, (copy) v_u7, (copy) v_u_run, (copy) v_u4
	local v_u_id = self.Id
	local v_u_state = self.State
	local v_u_physics = self.Physics
	task.defer(function()
		-- upvalues: (ref) v_u_replicatedstorage, (copy) self, (copy) v_u_id, (copy) v_u_state, (ref) v_u_debris, (ref) v_u2, (copy) v_u_physics, (ref) v_u8, (ref) v_u7, (ref) v_u_run, (ref) v_u4
		local v1 = v_u_replicatedstorage.Assets.Weapons:FindFirstChild(self.Weapon)
		if v1 then
			v1 = v1:FindFirstChild("Character")
		end
		if v1 then
			local v_clone = v1:Clone()
			v_clone.Name = v_u_id
			v_clone:PivotTo(CFrame.new(v_u_state.Position))
			v_clone:SetAttribute("GrenadeName", self.Weapon)
			v_clone:AddTag("Grenade")
			v_clone.Parent = v_u_debris
			for _, v2 in v_clone:GetDescendants() do
				if v2:IsA("BasePart") then
					v2.Anchored = true
					v2.CanCollide = false
				end
			end
			local v_new = v_u2.new()
			v_new:Add(v_clone, "Destroy")
			print("[CLIENT] Received grenade spawn - IsJumpThrow raw:", v_u_state.IsJumpThrow, "parsed as:", v_u_state.IsJumpThrow == 1)
			local v3 = {
				["position"] = v_u_state.Position,
				["velocity"] = v_u_state.Velocity,
				["angularVelocity"] = Vector3.new(0, 0, 0),
				["timestamp"] = v_u_state.StartTime or workspace:GetServerTimeNow(),
				["simulationTime"] = 0,
				["bounceCount"] = 0,
				["isGrounded"] = false,
				["isAtRest"] = false,
				["hasTouched"] = false,
				["accumulatedTime"] = 0,
				["isJumpThrow"] = v_u_state.IsJumpThrow or false
			}
			local v4 = {
				["radius"] = v_u_physics.Radius,
				["restitution"] = v_u_physics.Restitution,
				["maxBounces"] = v_u_physics.MaxBounces
			}
			local v5
			if v_u_physics.FuseTime > 0 then
				v5 = v_u_physics.FuseTime
			else
				v5 = nil
			end
			v4.fuseTime = v5
			v4.minimumFuseTime = nil
			v4.explodeOnFloorImpact = nil
			v4.rangeScale = 1
			v4.isNearThrow = false
			local v_velocity = v_u_state.Velocity
			local v6
			if v_velocity.Magnitude > 1 then
				local v_cross = v_velocity:Cross(Vector3.new(0, 1, 0))
				v6 = (v_cross.Magnitude <= 0.1 and Vector3.new(1, 0, 0) or v_cross.Unit) * v_velocity.Magnitude * 0.5
			else
				v6 = Vector3.new(0, 0, 0)
			end
			local v_u7 = {
				["id"] = v_u_id,
				["model"] = v_clone,
				["state"] = v3,
				["config"] = v4,
				["raycastParams"] = v_u8(v_clone, v_u_physics.CollisionGroup),
				["visualPosition"] = v_u_state.Position,
				["visualRotation"] = CFrame.identity,
				["angularVelocity"] = v6,
				["isResolved"] = false,
				["janitor"] = v_new
			}
			v_u7[v_u_id] = v_u7
			local v_u8 = nil
			v_u8 = v_u_run.RenderStepped:Connect(function(arg1)
				-- upvalues: (copy) v_u7, (ref) v_u8, (ref) v_u4
				if v_u7.isResolved then
					v_u8:Disconnect()
					return
				elseif v_u7.model.Parent then
					v_u7.state = v_u4.simulate(v_u7.state, v_u7.config, v_u7.raycastParams, arg1).state
					local v_min = math.min(1, arg1 * 20)
					v_u7.visualPosition = v_u7.visualPosition:Lerp(v_u7.state.position, v_min)
					if v_u7.angularVelocity.Magnitude > 0.01 then
						local v_angularvelocity = v_u7.angularVelocity
						local v_fromaxisangle = CFrame.fromAxisAngle(v_angularvelocity.Unit, v_angularvelocity.Magnitude * arg1)
						v_u7.visualRotation = v_u7.visualRotation * v_fromaxisangle
					end
					if v_u7.model.PrimaryPart then
						v_u7.model:PivotTo(CFrame.new(v_u7.visualPosition) * v_u7.visualRotation)
					end
				else
					v_u8:Disconnect()
					v_u7.isResolved = true
				end
			end)
			v_u7.janitor:Add(v_u8, "Disconnect")
		else
			warn("[Client Grenade] Base model not found for:", self.Weapon)
		end
	end)
end)
v3.Projectile.Bounce.Listen(function(arg1)
	-- upvalues: (copy) v_u7, (copy) v_u9
	local v1 = v_u7[arg1.Id]
	if v1 then
		v_u9(v1, arg1.Position, arg1.Velocity)
		v1.state.bounceCount = arg1.BounceIndex
		v1.state.hasTouched = true
		local v_velocity = arg1.Velocity
		local v2 = v_velocity - v1.state.velocity
		if v2.Magnitude > 1 then
			local v_cross = v2:Cross(v_velocity)
			local v3
			if v_cross.Magnitude > 0.1 then
				v3 = v_cross.Unit
			else
				local v_cross = v_velocity:Cross(Vector3.new(0, 1, 0))
				v3 = v_cross.Magnitude <= 0.1 and Vector3.new(1, 0, 0) or v_cross.Unit
			end
			v1.angularVelocity = v1.angularVelocity + v3 * v2.Magnitude * 0.5
		end
	end
end)
v3.Projectile.Resolve.Listen(function(arg1)
	-- upvalues: (copy) v_u7
	local v1 = v_u7[arg1.Id]
	if v1 then
		v1.state.position = arg1.Position
		v1.state.isAtRest = true
		v1.isResolved = true
		v1.angularVelocity = Vector3.new(0, 0, 0)
		if v1.model.PrimaryPart then
			v1.model:PivotTo(CFrame.new(arg1.Position) * v1.visualRotation)
		end
		v1.model:SetAttribute("SimulationFinished", true)
		v_u7[arg1.Id] = nil
	end
end)
return v1.observeTag("Grenade", function(self)
	-- upvalues: (copy) v_u5, (copy) v_u2, (copy) v_u7
	local v_grenadename = self:GetAttribute("GrenadeName")
	if v_grenadename then
		local v_u1 = v_u5[v_grenadename]
		local v_u_new = v_u2.new()
		v_u_new:Add(self:GetAttributeChangedSignal("SimulationFinished"):Connect(function()
			-- upvalues: (copy) self, (copy) v_u1, (copy) v_u_new
			local v_primarypart = self.PrimaryPart
			if v_primarypart and self:GetAttribute("SimulationFinished") then
				if v_u1 then
					v_u1(v_u_new, v_primarypart.Position, self)
					return
				end
				for _, v1 in self:GetDescendants() do
					if v1:IsA("BasePart") then
						v1.Transparency = 1
						v1.CanCollide = false
					end
				end
				task.delay(0.5, function()
					-- upvalues: (ref) self
					if self and self.Parent then
						self:Destroy()
					end
				end)
			end
		end))
		return function()
			-- upvalues: (copy) self, (ref) v_u7, (copy) v_u_new
			local v_name = self.Name
			if v_u7[v_name] then
				v_u7[v_name].isResolved = true
				v_u7[v_name] = nil
			end
			v_u_new:Destroy()
		end
	end
end)