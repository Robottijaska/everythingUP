dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")
dofile_once("data/scripts/lib/utilities.lua")

function setHeadEquipment(equipmentName)
    local id = getPlayer()
    --removing effects
    for _, value in ipairs(EquipmentGUI.head_order) do
        local children = EntityGetAllChildren(id)
            for _, child in ipairs(children) do
            if EntityGetName(child) == value[1] then
                EntityKill(child)
            end
        end
    end
    if equipmentName ~= "none" then
        LoadGameEffectEntityTo(id, "mods/everythingUP/files/equipment/head/" .. equipmentName .. ".xml")
    end
end

function setChestEquipment(equipmentName)
    local id = getPlayer()
    --removing effects
    for _, value in ipairs(EquipmentGUI.chest_order) do
        local children = EntityGetAllChildren(id)
            for _, child in ipairs(children) do
            if EntityGetName(child) == value[1] then
                EntityKill(child)
            end
        end
    end
    if equipmentName ~= "none" then
        LoadGameEffectEntityTo(id, "mods/everythingUP/files/equipment/chest/" .. equipmentName .. ".xml")
    end
end

function setArmEquipment(equipmentName)
    local id = getPlayer()
    --removing effects
    for _, value in ipairs(EquipmentGUI.arm_order) do
        local children = EntityGetAllChildren(id)
            for _, child in ipairs(children) do
            if EntityGetName(child) == value[1] then
                EntityKill(child)
            end
        end
    end
    if equipmentName ~= "none" then
        LoadGameEffectEntityTo(id, "mods/everythingUP/files/equipment/arm/" .. equipmentName .. ".xml")
    end
end

function setLegEquipment(equipmentName)
    local id = getPlayer()
    --removing effects
    for _, value in ipairs(EquipmentGUI.leg_order) do
        local children = EntityGetAllChildren(id)
            for _, child in ipairs(children) do
            if EntityGetName(child) == value[1] then
                EntityKill(child)
            end
        end
    end
    if equipmentName ~= "none" then
        LoadGameEffectEntityTo(id, "mods/everythingUP/files/equipment/arm/" .. equipmentName .. ".xml")
    end
end