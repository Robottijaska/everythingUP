dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

if (EntityHasTag(entity_id, "magnet_shot_applied") == false) then
	EntityAddTag(entity_id, "magnet_shot_applied")
end

local target_entities = EntityGetInRadiusWithTag(x, y, 150, "magnet_shot_applied")
for i=1, #target_entities do
	local entity_x, entity_y = EntityGetTransform( target_entities[i] )

	if (x == entity_x and y == entity_y) then
		table.remove(target_entities, i)
	end
end

if (target_entities == nil or #target_entities == 0) then return end --guard

local power_coeff = 600

local average_x = 0
local average_y = 0

--obtains average location relative to the player, lowered by distance. Dividing the sum by #target_entities is unecessary (produces the same slope of vector)
for i=1, #target_entities do
	local entity_x, entity_y = EntityGetTransform( target_entities[i] )
	local dx = entity_x - x
	local dy = entity_y - y
	local dist = math.sqrt((dy)^2 + (dx)^2)

	local coeff = (5/(dist+0.1))+1
	average_x = average_x + dx * coeff
	average_y = average_y + dy * coeff
end

--making d equal to the averages is unnecessary but i felt like doing it because it looks nice :)
local dx = average_x
local dy = average_y

--calculating magnitude of the new vector
power_coeff = power_coeff * (dx / math.abs(dx))

--finding radians to target point
local average_rad = math.atan((dy) / (dx))
local average_dist = math.sqrt((dy)^2 + (dx)^2)

--calculating the vector to move closer to the target point
local new_vel_x = math.max(math.min(  power_coeff*math.cos(average_rad)/average_dist  , 30), -30)
local new_vel_y = math.max(math.min(  power_coeff*math.sin(average_rad)/average_dist  , 30), -30)

local comp = EntityGetFirstComponent( entity_id, "VelocityComponent")
local vel_x, vel_y = ComponentGetValueVector2( comp, "mVelocity" )

if (vel_x == nil) then return end --guard

ComponentSetValueVector2( comp, "mVelocity", vel_x + new_vel_x, vel_y + new_vel_y )