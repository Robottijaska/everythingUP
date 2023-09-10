table.insert( g_small_enemies,
{
	prob   		= 0.1,
	min_count	= 1,
	max_count	= 1,
	entity 	= "mods/everythingUP/files/scripts/biomes/vault/drone_hunter.xml"
})

table.insert( g_small_enemies,
{
	prob   		= 0.05,
	min_count	= 1,
	max_count	= 1,
	entities 	= {
		"mods/everythingUP/files/scripts/biomes/vault/drone_hunter.xml",
		{
			min_count	= 1,
			max_count	= 2,    
			entity 	= "data/entities/animals/vault/drone_physics.xml"
		},
		"data/entities/animals/vault/healerdrone_physics.xml"
	}
})