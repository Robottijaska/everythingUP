dofile( "data/scripts/game_helpers.lua" )
dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/perks/perk_list.lua" )
dofile( "data/scripts/perks/perk.lua" )

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
entity_id = EntityGetRootEntity(entity_id)

SetRandomSeed( x, y )

--add perk
local availablePerks = {}
for _,v in ipairs(perk_list) do
    if IsPlayer(entity_id) then
        if v.not_in_default_perk_pool == nil and v.one_off_effect == nil then
            table.insert(availablePerks, v)
        end
    else
        if v.not_in_default_perk_pool == nil and v.one_off_effect == nil and v.usable_by_enemies ~= nil then
            table.insert(availablePerks, v)
        end
    end
end

local perk_id = availablePerks[Random(1, #availablePerks)].id
perk_pickup( 0, entity_id, perk_id, false, false, true )

EntityInflictDamage(entity_id, 0.8, "DAMAGE_RADIOACTIVE", "Radiation", "NORMAL", 0, 0)