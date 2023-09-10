dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( GetUpdatedEntityID() )

local comp = EntityGetFirstComponent( entity_id, "MaterialInventoryComponent", "fuel_to_power_Inv")
local all_pxls
if comp ~= nil then	all_pxls = ComponentGetValue2( comp, "count_per_material_type" ) end

local total_pxls = 0
for pxl_index = 1, #all_pxls do
	total_pxls = total_pxls + all_pxls[pxl_index]
end

--end of consumiong materials

local damage_modifier = (total_pxls + 250) / 250

local comps = EntityGetComponent( entity_id, "ProjectileComponent" )

if( comps == nil ) then return end

for i,comp in ipairs(comps) do
	local damage = ComponentGetValue2( comp, "damage" )
	if damage ~= nil then
		damage = damage * damage_modifier
		ComponentSetValue2( comp, "damage", damage )
	end

	local dtypes = { "projectile", "explosion", "melee", "ice", "slice", "electricity", "radioactive", "drill", "fire" }
	for a,b in ipairs(dtypes) do
		local v = ComponentObjectGetValue2( comp, "damage_by_type", b )
		if v ~= nil then
			v = v * damage_modifier
			ComponentObjectSetValue2( comp, "damage_by_type", b, v )
		end
	end

	local etypes = { "damage" }
	for a,b in ipairs(etypes) do
		local v = ComponentObjectGetValue2( comp, "config_explosion", b )
		if v ~= nil then
			v = v * damage_modifier
			ComponentObjectSetValue2( comp, "config_explosion", b, v )
		end
	end
end

comps = EntityGetComponent( entity_id, "MaterialSuckerComponent", "fuel_to_power_suck" )
for i,comp in ipairs(comps) do
	ComponentSetValue2( comp, "material_type", 4 ) --used just so the component deactivates
end

local trail_selection = false
local trail_sprite = false

if total_pxls > 250 then 
	trail_selection = true
end
if total_pxls > 750 then
	trail_sprite = true
end

local comps2 = EntityGetComponentIncludingDisabled( entity_id, "SpriteParticleEmitterComponent", "fuel_to_power_emitter" )
comps = EntityGetComponentIncludingDisabled( entity_id, "ParticleEmitterComponent", "fuel_to_power_emitter" )

ComponentSetValue2(comps[#comps], "is_emitting", true)
if trail_selection then 
	ComponentSetValue2(comps[#comps-1], "is_emitting", true)

	EntityAddComponent(entity_id, "LightComponent", {
		_enabled="1" ,
		radius="80",
		fade_out_time="1.5" ,
		r="240",
		g="180",
		b="120"
	})
end
if trail_sprite then 
	ComponentSetValue2(comps2[#comps2], "is_emitting", true)

	EntityLoad("mods/everythingUP/files/effects/conversion_effect.xml", x, y)

	EntityAddComponent(entity_id, "LightComponent", {
		_enabled="1" ,
		radius="130",
		fade_out_time="1.5" ,
		r="240",
		g="180",
		b="120"
	})

	EntityAddComponent(entity_id, "AudioLoopComponent", {
		file="data/audio/Desktop/projectiles.bank",
		event_name="player_projectiles/torch/loop",
		auto_play="1"
	})
end