-- game.ReplicatedStorage.Controllers.CaptureController

local v1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_capture = game:GetService("CaptureService")
function v1.CaptureScreenshot(self)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_capture
	return require(v_u_replicatedstorage.Shared.Promise).new(function(arg1, arg2)
		-- upvalues: (ref) v_u_capture, (copy) self
		local v1, v2 = pcall(function()
			-- upvalues: (ref) v_u_capture, (ref) self, (copy) arg1
			v_u_capture:CaptureScreenshot(function(arg1)
				-- upvalues: (ref) self, (ref) arg1
				if self then
					self(arg1)
				end
				arg1(arg1)
			end)
		end)
		if not v1 then
			arg2(v2)
		end
	end)
end
return v1