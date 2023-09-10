dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent")
local damage = 0.5

if comp ~= nil then
	damage = ComponentObjectGetValue2( comp, "config_explosion", "damage" )
end

if damage == 0 then damage = 0.5 end

local new_entity_id = EntityLoad("mods/everythingUP/files/entities/projectiles/reverbation.xml", x, y)

local ShockWave_COLOR = spawnShader(60, 0.0, "everythingUP_ShockWave_COLOR", x, y, entity_id, false, false);
local ShockWave_WARP = spawnShader(60, 0.0, "everythingUP_ShockWave_WARP", x, y, entity_id, false, false);

comp = EntityGetFirstComponentIncludingDisabled(new_entity_id, "VariableStorageComponent", "reverbation_ShockWave_COLOR")
ComponentSetValue2( comp, "value_int", ShockWave_COLOR)
comp = EntityGetFirstComponentIncludingDisabled(new_entity_id, "VariableStorageComponent", "reverbation_ShockWave_WARP")
ComponentSetValue2( comp, "value_int", ShockWave_WARP)
comp = EntityGetFirstComponentIncludingDisabled(new_entity_id, "VariableStorageComponent", "reverbation_parent")
ComponentSetValue2( comp, "value_int", entity_id)

comp = EntityGetFirstComponent( new_entity_id, "ProjectileComponent")

ComponentObjectSetValue2(comp, "config_explosion", "damage", damage * 0.40)