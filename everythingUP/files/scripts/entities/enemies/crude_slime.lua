dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( GetUpdatedEntityID() )

local crude_slime_state = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "crude_slime_state")

local state = ComponentGetValue2( crude_slime_state, "value_string" )
local timer = ComponentGetValue2( crude_slime_state, "value_int")

if (timer > 0) then
	local comp = EntityGetFirstComponent(entity_id, "SpriteComponent")
	ComponentSetValue2( comp, "rect_animation", "emerge" ); ComponentSetValue2( comp, "next_rect_animation", "emerge" )

	timer = timer - 1;
	ComponentSetValue2( crude_slime_state, "value_int", timer)

	if (timer == 0) then
		ComponentSetValue2( comp, "image_file", "mods/everythingUP/files/entities/enemies_gfx/crude_slime_revealed.xml" )
		EntityRefreshSprite(entity_id, comp)

		ComponentSetValue2( comp, "rect_animation", "stand" ); ComponentSetValue2( comp, "next_rect_animation", "stand" )

		comp = EntityGetFirstComponent(entity_id, "AnimalAIComponent")
		ComponentSetValue2( comp, "attack_ranged_enabled", true )

		ComponentSetValue2( crude_slime_state, "value_string", "emerged")
	end
elseif (state == "hidden" and #EntityGetInRadiusWithTag( x, y, 25, "player_unit" ) > 0 ) then
	local comp = EntityGetFirstComponent(entity_id, "SpriteComponent")
	EntityRefreshSprite(entity_id, comp)

	ComponentSetValue2( comp, "rect_animation", "emerge" )
	ComponentSetValue2( comp, "next_rect_animation", "emerge" )

	local crude_slime_invis
	local children = EntityGetAllChildren(entity_id)
	for i = 1, #children do
		crude_slime_invis = EntityGetFirstComponentIncludingDisabled(children[i], "GameEffectComponent", "crude_slime_invis")
		if (crude_slime_invis ~= nil) then break end
	end
	ComponentSetValue2( crude_slime_invis, "frames", 80)

	ComponentSetValue2( crude_slime_state, "value_int", 80)
end