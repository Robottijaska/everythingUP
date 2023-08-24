--projectiles

table.insert( actions, --SUMMON_BATTERY
{
	id          = "SUMMON_BATTERY",
	name 		= "$action_summon_battery",
	description = "$actiondesc_summon_battery",
	sprite 		= "mods/everythingUP/files/cards_gfx/summon_battery.png",
	sprite_unidentified = "",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "1,2,3,4,5",
	spawn_probability                 = "0.8,0.8,1.3,0.5,0.5",
	price = 130,
	mana = 100,
	max_uses = 10,
	action 		= function()
		add_projectile("mods/everythingUP/files/entities/projectiles/deck/summon_battery.xml")
	end,
} )
table.insert( actions, --BOOMERANG_SHOT
{
	id          = "BOOMERANG_SHOT",
	name 		= "$action_summon_boomerang",
	description = "$actiondesc_summon_boomerang",
	sprite 		= "mods/everythingUP/files/cards_gfx/boomerang.png",
	sprite_unidentified = "",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "0,1,2,3",
	spawn_probability                 = "1.5,1.5,1.5,1",
	price = 10,
	mana = 10,
	action 		= function()
		add_projectile("mods/everythingUP/files/entities/projectiles/deck/boomerang.xml")
		c.fire_rate_wait = c.fire_rate_wait - 5
	end,
} )

--modifiers

table.insert( actions, --FUEL_TO_POWER
{
	id          = "FUEL_TO_POWER",
	name 		= "$action_fuel_to_power",
	description = "$actiondesc_fuel_to_power",
	sprite 		= "mods/everythingUP/files/cards_gfx/fuel_to_power.png",
	sprite_unidentified = "",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "1,3,4,5", 
	spawn_probability                 = "0.8,0.8,0.8,0.8", 
	price = 250,
	mana = 125,
	action 		= function()
		c.extra_entities = c.extra_entities .. "mods/everythingUP/files/modifiers/fuel_to_power.xml,"
		c.fire_rate_wait = c.fire_rate_wait + 20
		current_reload_time = current_reload_time + 70
		
		draw_actions( 1, true )
	end,
} )
table.insert( actions, --MAGNET_SHOT_ATTRACT
{
	id          = "MAGNET_SHOT_ATTRACT",
	name 		= "$action_magnet_shot_attract",
	description = "$actiondesc_magnet_shot_attract",
	sprite 		= "mods/everythingUP/files/cards_gfx/magnet_shot_attract.png",
	sprite_unidentified = "",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "0,1,2,3,4,5",
	spawn_probability                 = "0.3,0.8,0.8,0.8,0.8,0.8",
	price = 50,
	mana = 10,
	action 		= function()
		c.extra_entities = c.extra_entities .. "mods/everythingUP/files/modifiers/magnet_shot_attract.xml,"
		c.fire_rate_wait = c.fire_rate_wait + 2
		
		draw_actions( 1, true )
	end,
} )
table.insert( actions, --MAGNET_SHOT_REPULSE
{
	id          = "MAGNET_SHOT_REPULSE",
	name 		= "$action_magnet_shot_repulse",
	description = "$actiondesc_magnet_shot_repulse",
	sprite 		= "mods/everythingUP/files/cards_gfx/magnet_shot_repulse.png",
	sprite_unidentified = "",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "0,1,2,3,4,5",
	spawn_probability                 = "0.3,0.8,0.8,0.8,0.8,0.8",
	price = 50,
	mana = 10,
	action 		= function()
		c.extra_entities = c.extra_entities .. "mods/everythingUP/files/modifiers/magnet_shot_repulse.xml,"
		c.fire_rate_wait = c.fire_rate_wait + 2
		
		draw_actions( 1, true )
	end,
} )
table.insert( actions, --REVERBATION
{
	id          = "REVERBATION",
	name 		= "$action_magnet_shot_repulse",
	description = "$actiondesc_magnet_shot_repulse",
	sprite 		= "mods/everythingUP/files/cards_gfx/reverbation.png",
	sprite_unidentified = "",
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "0,1,2,3,4,5",
	spawn_probability                 = "0.3,0.8,0.8,0.8,0.8,0.8",
	price = 50,
	mana = 10,
	action 		= function()
		c.extra_entities = c.extra_entities .. "mods/everythingUP/files/modifiers/reverbation.xml,"
		c.fire_rate_wait = c.fire_rate_wait + 2
		
		draw_actions( 1, true )
	end,
} )