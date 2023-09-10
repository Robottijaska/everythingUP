dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( GetUpdatedEntityID() )

local crude_slime_state = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "drone_hunter_state")

local timer = ComponentGetValue2( crude_slime_state, "value_int")

if (timer > 0) then
	-- activated when in "turret state"
	--GamePrint("!!!!!!!!!!!" .. timer)

	local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "drone_hunter_anchorx")
	local anchorx = ComponentGetValue2(comp, "value_int")
	comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "drone_hunter_anchory")
	local anchory = ComponentGetValue2(comp, "value_int")

	comp = EntityGetFirstComponentIncludingDisabled(entity_id, "PathFindingComponent")
	ComponentSetValueVector2(comp, "path_next_node_vector_to", 0, 0)

	comp = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
	ComponentSetValueVector2(comp, "mHomePosition", anchorx, anchory)

	timer = timer - 1

	--decreasing timer by 1
	ComponentSetValue2( crude_slime_state, "value_int", timer)

	local players = EntityGetInRadiusWithTag( x, y, 240, "player_unit" )

	if timer >= 120 and timer % 6 == 0 and #players > 0 and timer <= 240 then
		local player_x, player_y = EntityGetTransform(players[1])
		local proj_id = EntityLoad("mods/everythingUP/files/entities/projectiles/drone_hunter_bullet.xml", x, y)
		GameShootProjectile(entity_id, x, y, player_x, player_y, proj_id)
	end

	if timer < 120 then
		comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ParticleEmitterComponent", "drone_hunter_emitter")
		ComponentSetValue2(comp, "is_emitting", true)
	end

	if timer == 0 then
		--reverting changes
		comp = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
		ComponentSetValue2(comp, "attack_ranged_frames_between", 30)
		ComponentSetValue2(comp, "ai_state", 18)
		ComponentSetValue2(comp, "ai_state_timer", 9999999999)
		ComponentSetValue2(comp, "attack_ranged_enabled", true)

		comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ParticleEmitterComponent", "drone_hunter_emitter")
		ComponentSetValue2(comp, "is_emitting", false)
	end
elseif (#EntityGetInRadiusWithTag( x, y, 100, "player_unit" ) > 0 ) then
	--activated when drone is in "seeking state"

	--setting timer and state, activating "turret state"
	ComponentSetValue2( crude_slime_state, "value_int", 300)

	local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "drone_hunter_anchorx")
	ComponentSetValue2(comp, "value_int", x)

	comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "drone_hunter_anchory")
	ComponentSetValue2(comp, "value_int", y)

	comp = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
	ComponentSetValue2(comp, "attack_ranged_frames_between", 3)
	ComponentSetValue2(comp, "ai_state", 21)
	ComponentSetValue2(comp, "ai_state_timer", 9999999999)
	ComponentSetValue2(comp, "attack_ranged_enabled", false)
end