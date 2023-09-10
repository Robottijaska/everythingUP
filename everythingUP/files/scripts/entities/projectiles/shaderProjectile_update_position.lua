dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "shaderProjectile_id")
local id = ComponentGetValue2( comp, "value_int")

comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "shaderProjectile_paramNum")
local paramNum = ComponentGetValue2( comp, "value_float")

comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "shaderProjectile_name")
local name = ComponentGetValue2( comp, "value_string")

comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "shaderProjectile_isBound")
local isBound = ComponentGetValue2( comp, "value_bool")

if isBound and EntityGetIsAlive( id ) ~= true then EntityKill(entity_id) end

if isBound then local parentX, parentY = EntityGetTransform(id); EntityApplyTransform( entity_id, parentX, parentY) end

shader_x, shader_y = world_to_shader_pos(x, y)

GameSetPostFxParameter( name, shader_x, shader_y, paramNum, id )