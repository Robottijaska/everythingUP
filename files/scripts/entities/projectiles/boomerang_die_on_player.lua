dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger( colliding_entity_id )
	local entity_id = GetUpdatedEntityID()

	if (EntityHasTag( colliding_entity_id, "player_unit" )) then EntityKill(entity_id) end
end