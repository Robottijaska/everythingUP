dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")
dofile_once("mods/everythingUP/files/scripts/equipment/equipment.lua")
dofile_once("data/scripts/lib/utilities.lua")

function UpdateEquipmentGUI()
    if not GameIsInventoryOpen() then
        local EquipmentGUI_isOpen = GlobalsGetValue("EquipmentGUI_isOpen") == "1"

        local id = 1; local function genID()
            id = id + 1
            return id
        end
    
        GuiStartFrame(EquipmentGUI.id)

        --if button clicked, opens/closes equipment menu (stored as a global to preserve data between frames)
        if GuiButton( EquipmentGUI.id, genID(), 10, 10, "equipment" ) then
            if EquipmentGUI_isOpen then
                GlobalsSetValue("EquipmentGUI_isOpen", "0")
            else
                GlobalsSetValue("EquipmentGUI_isOpen", "1")
            end
            EquipmentGUI_isOpen = not EquipmentGUI_isOpen
        end
    
        if EquipmentGUI_isOpen then
            --creates region
            GuiBeginScrollContainer(EquipmentGUI.id, genID(), EquipmentGUI.x,EquipmentGUI.y,EquipmentGUI.w,EquipmentGUI.h); GuiEndScrollContainer(EquipmentGUI.id)

            local function findIndexContainingString1(inputTable, substring)
                for index, value in ipairs(inputTable) do
                    if string.find(value, substring) then
                        return index
                    end
                end
                return nil
            end

            local function findIndexContainingString2(inputTable, substring)
                for index, value in ipairs(inputTable) do
                    if string.find(value[1], substring) then
                        return index
                    end
                end
                return nil
            end

            local index
            local order_index
            local offx
            local offy

            ----HEAD----
            offx = EquipmentGUI.w/2 - 8
            offy = 25

            local EquipmentGUI_CurrentHeadEquipment = GlobalsGetValue("EquipmentGUI_CurrentHeadEquipment")
            local EquipmentGUI_HeadEquipmentCollected = stringToMonoStrTable(GlobalsGetValue("EquipmentGUI_HeadEquipmentCollected"))
            index = findIndexContainingString1(EquipmentGUI_HeadEquipmentCollected, EquipmentGUI_CurrentHeadEquipment)

            GuiStartFrame(EquipmentGUI.head)
            GuiZSetForNextWidget(EquipmentGUI.head, -1)
            local lclicked, rclicked = GuiImageButton(EquipmentGUI.head, genID(), EquipmentGUI.x + offx - 4, EquipmentGUI.y + offy - 4, "", "mods/everythingUP/files/ui_gfx/equipmentselect/box.png")
            if (lclicked or rclicked) and EquipmentGUI_HeadEquipmentCollected ~= nil and #EquipmentGUI_HeadEquipmentCollected > 1 then
                --scrolling through equipment
                if lclicked then
                    if index < #EquipmentGUI_HeadEquipmentCollected then
                        index = index + 1
                    end
                else
                    if index > 1 then
                        index = index - 1
                    end
                end
                order_index = findIndexContainingString2(EquipmentGUI.head_order, EquipmentGUI_HeadEquipmentCollected[index])
                EquipmentGUI_CurrentHeadEquipment = (EquipmentGUI.head_order[order_index])[1]
                GlobalsSetValue("EquipmentGUI_CurrentHeadEquipment", EquipmentGUI_CurrentHeadEquipment)
                
                setHeadEquipment(EquipmentGUI_CurrentHeadEquipment)
            else
                order_index = findIndexContainingString2(EquipmentGUI.head_order, EquipmentGUI_HeadEquipmentCollected[index])
            end

            if (EquipmentGUI_CurrentHeadEquipment ~= "none") then GuiTooltip(EquipmentGUI.head, EquipmentGUI.head_order[order_index][3], EquipmentGUI.head_order[order_index][4]) end

            --displays sprite for the current equipment
            GuiZSetForNextWidget(EquipmentGUI.head, -2)

            GuiImage(EquipmentGUI.head, genID(), EquipmentGUI.x + offx, EquipmentGUI.y + offy, EquipmentGUI.head_order[order_index][2], 1, 1, 1)

            ----CHEST----
            offx = EquipmentGUI.w/2 - 10
            offy = 60

            local EquipmentGUI_CurrentChestEquipment = GlobalsGetValue("EquipmentGUI_CurrentChestEquipment")
            local EquipmentGUI_ChestEquipmentCollected = stringToMonoStrTable(GlobalsGetValue("EquipmentGUI_ChestEquipmentCollected"))
            index = findIndexContainingString1(EquipmentGUI_ChestEquipmentCollected, EquipmentGUI_CurrentChestEquipment)

            GuiStartFrame(EquipmentGUI.chest)
            GuiZSetForNextWidget(EquipmentGUI.chest, -1)
            lclicked, rclicked = GuiImageButton(EquipmentGUI.chest, genID(), EquipmentGUI.x + offx - 4, EquipmentGUI.y + offy - 4, "", "mods/everythingUP/files/ui_gfx/equipmentselect/box_tall.png")
            if (lclicked or rclicked) and EquipmentGUI_ChestEquipmentCollected ~= nil and #EquipmentGUI_ChestEquipmentCollected > 1 then
                --scrolling through equipment
                if lclicked then
                    if index < #EquipmentGUI_ChestEquipmentCollected then
                        index = index + 1
                    end
                else
                    if index > 1 then
                        index = index - 1
                    end
                end

                order_index = findIndexContainingString2(EquipmentGUI.chest_order, EquipmentGUI_ChestEquipmentCollected[index])
                EquipmentGUI_CurrentChestEquipment = EquipmentGUI.chest_order[order_index][1]
                GlobalsSetValue("EquipmentGUI_CurrentChestEquipment", EquipmentGUI_CurrentChestEquipment)
                
                setChestEquipment(EquipmentGUI_CurrentChestEquipment)
            else
                order_index = findIndexContainingString2(EquipmentGUI.chest_order, EquipmentGUI_ChestEquipmentCollected[index])
            end

            if (EquipmentGUI_CurrentChestEquipment ~= "none") then GuiTooltip(EquipmentGUI.chest, EquipmentGUI.chest_order[order_index][3], EquipmentGUI.chest_order[order_index][4]) end

            --displays sprite for the current equipment
            GuiZSetForNextWidget(EquipmentGUI.chest, -2)
            GuiImage(EquipmentGUI.chest, genID(), EquipmentGUI.x + offx, EquipmentGUI.y + offy, EquipmentGUI.chest_order[order_index][2], 1, 1, 1)

            --ARM
            offx = EquipmentGUI.w/2 - 38
            offy = 65

            local EquipmentGUI_CurrentArmEquipment = GlobalsGetValue("EquipmentGUI_CurrentArmEquipment")
            local EquipmentGUI_ArmEquipmentCollected = stringToMonoStrTable(GlobalsGetValue("EquipmentGUI_ArmEquipmentCollected"))
            index = findIndexContainingString1(EquipmentGUI_ArmEquipmentCollected, EquipmentGUI_CurrentArmEquipment)

            GuiStartFrame(EquipmentGUI.arm)
            GuiZSetForNextWidget(EquipmentGUI.arm, -1)
            lclicked, rclicked = GuiImageButton(EquipmentGUI.arm, genID(), EquipmentGUI.x + offx - 4, EquipmentGUI.y + offy - 4, "", "mods/everythingUP/files/ui_gfx/equipmentselect/box.png")
            if (lclicked or rclicked) and EquipmentGUI_ArmEquipmentCollected ~= nil and #EquipmentGUI_ArmEquipmentCollected > 1 then
                --scrolling through equipment
                if lclicked then
                    if index < #EquipmentGUI_ArmEquipmentCollected then
                        index = index + 1
                    end
                else
                    if index > 1 then
                        index = index - 1
                    end
                end

                order_index = findIndexContainingString2(EquipmentGUI.arm_order, EquipmentGUI_ArmEquipmentCollected[index])
                EquipmentGUI_CurrentArmEquipment = EquipmentGUI.arm_order[order_index][1]
                GlobalsSetValue("EquipmentGUI_CurrentArmEquipment", EquipmentGUI_CurrentArmEquipment)
                
                setArmEquipment(EquipmentGUI_CurrentArmEquipment)
            else
                order_index = findIndexContainingString2(EquipmentGUI.arm_order, EquipmentGUI_ArmEquipmentCollected[index])
            end

            if (EquipmentGUI_CurrentArmEquipment ~= "none") then GuiTooltip(EquipmentGUI.arm, EquipmentGUI.arm_order[order_index][3], EquipmentGUI.arm_order[order_index][4]) end

            --displays sprite for the current equipment
            GuiZSetForNextWidget(EquipmentGUI.arm, -2)
            GuiImage(EquipmentGUI.arm, genID(), EquipmentGUI.x + offx, EquipmentGUI.y + offy, EquipmentGUI.arm_order[order_index][2], 1, 1, 1)

            --LEG
            offx = EquipmentGUI.w/2 - 26
            offy = 110

            local EquipmentGUI_CurrentLegEquipment = GlobalsGetValue("EquipmentGUI_CurrentLegEquipment")
            local EquipmentGUI_LegEquipmentCollected = stringToMonoStrTable(GlobalsGetValue("EquipmentGUI_LegEquipmentCollected"))
            index = findIndexContainingString1(EquipmentGUI_LegEquipmentCollected, EquipmentGUI_CurrentLegEquipment)

            GuiStartFrame(EquipmentGUI.leg)
            GuiZSetForNextWidget(EquipmentGUI.leg, -1)
            lclicked, rclicked = GuiImageButton(EquipmentGUI.leg, genID(), EquipmentGUI.x + offx - 4, EquipmentGUI.y + offy - 4, "", "mods/everythingUP/files/ui_gfx/equipmentselect/box.png")
            if (lclicked or rclicked) and EquipmentGUI_LegEquipmentCollected ~= nil and #EquipmentGUI_LegEquipmentCollected > 1 then
                --scrolling through equipment
                if lclicked then
                    if index < #EquipmentGUI_LegEquipmentCollected then
                        index = index + 1
                    end
                else
                    if index > 1 then
                        index = index - 1
                    end
                end

                order_index = findIndexContainingString2(EquipmentGUI.leg_order, EquipmentGUI_LegEquipmentCollected[index])
                EquipmentGUI_CurrentLegEquipment = EquipmentGUI.leg_order[order_index][1]
                GlobalsSetValue("EquipmentGUI_CurrentLegEquipment", EquipmentGUI_CurrentLegEquipment)
                
                setLegEquipment(EquipmentGUI_CurrentLegEquipment)
            else
                order_index = findIndexContainingString2(EquipmentGUI.leg_order, EquipmentGUI_LegEquipmentCollected[index])
            end

            if (EquipmentGUI_CurrentLegEquipment ~= "none") then GuiTooltip(EquipmentGUI.leg, EquipmentGUI.leg_order[order_index][3], EquipmentGUI.leg_order[order_index][4]) end

            --displays sprite for the current equipment
            GuiZSetForNextWidget(EquipmentGUI.leg, -2)
            GuiImage(EquipmentGUI.leg, genID(), EquipmentGUI.x + offx, EquipmentGUI.y + offy, EquipmentGUI.leg_order[order_index][2], 1, 1, 1)
        end
    end
end