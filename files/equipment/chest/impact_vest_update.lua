dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")

local entity_id = getPlayer()
local x, y = EntityGetTransform( GetUpdatedEntityID() )

local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
if GlobalsGetValue("IMPACT_VEST_COUNTDOWN") == "" then
	GlobalsSetValue("IMPACT_VEST_COUNTDOWN", "0")
end

if tonumber(GlobalsGetValue("IMPACT_VEST_COUNTDOWN")) == 0 then
	local vx, vy = ComponentGetValue2(comp, "mVelocity")
	local targets = EntityGetInRadiusWithTag( x, y, 20, "enemy")
	local magVel = math.sqrt(vx^2 + vy^2)
	if magVel > 5*60 and #targets > 0 then --there must be a enemy nearby to pass
		local target = targets[1]

		local magVelT = magVel / 60
		--do shit
		local damage = magVelT + 1.2^magVelT --x + 1.2^x

		local mass = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( target, "CharacterDataComponent" ), "mass" ) or 1
		local tvx, tvy = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(target, "CharacterDataComponent"), "mVelocity")

		local nvx = 15*vx/mass
		local nvy = 15*vy/mass
		
		ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(target, "CharacterDataComponent"), "mVelocity", tvx + nvx, tvy + nvy)
		ComponentSetValue2(comp, "mVelocity", vx * 0.8, vy * 0.8)

		EntityInflictDamage(target, damage/25, "DAMAGE_PHYSICS_HIT", " was hit a bit too much", "NORMAL", nvx, nvx, entity_id, x, y, magVel)
		GlobalsSetValue("IMPACT_VEST_COUNTDOWN", "10")

		PhysicsApplyForce(target, nvx, nvy)
	end
else
	GlobalsSetValue("IMPACT_VEST_COUNTDOWN", tostring( tonumber(GlobalsGetValue("IMPACT_VEST_COUNTDOWN")) - 1)) --subtract by one
end