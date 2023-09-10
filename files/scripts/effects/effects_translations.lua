dofile_once("data/scripts/lib/utilities.lua")

ModTextFileSetContent("data/translations/common.csv", ModTextFileGetContent("data/translations/common.csv") .. [[
status_irradiated,Irradiated,,,,,,,,,,,,,
statusdesc_irradiated,Will slowly mutate the player if enough has been built (gives a random perk),,,,,,,,,,,,,
]])