dofile_once("data/scripts/lib/utilities.lua")

local path = "data/scripts/gun/procedural/starting_wand.lua"

local contents = [[
	table.insert(gun.actions, "BOOMERANG_SHOT")

	local children = EntityGetAllChildren(entity_id)
	print("hi! children: " .. #children)
	for i=1,#children do
		EntityRemoveFromParent( children[i] )
	end
	
	action_count = math.min(Random(1,3), tonumber(deck_capacity))
	gun_action = "LIGHT_BULLET"
	
	n_of_deaths = tonumber( StatsGlobalGetValue("death_count") )
	if( n_of_deaths >= 1 ) then
	
		if( Random(1,100) < 50 ) then
			gun_action = get_random_from( gun.actions )
		end
	
	end
	
	for i=1,action_count do
		AddGunAction( entity_id, gun_action )
	end
]]

ModTextFileSetContent( path, ModTextFileGetContent( path ) .. contents)

--[[
table.insert(gun.actions, "BOOMERANG_SHOT")

local children = EntityGetAllChildren(entity_id)
print("hi! children: " .. #children)
for i=1,#children do
	EntityRemoveFromParent( children[i] )
end

action_count = math.min(Random(1,3), tonumber(deck_capacity))
gun_action = "LIGHT_BULLET"

n_of_deaths = tonumber( StatsGlobalGetValue("death_count") )
if( n_of_deaths >= 1 ) then

	if( Random(1,100) < 50 ) then
		gun_action = get_random_from( gun.actions )
	end

end

for i=1,action_count do
	AddGunAction( entity_id, gun_action )
end
]]