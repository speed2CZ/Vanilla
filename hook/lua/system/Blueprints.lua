-- Save the original function before we overwrite it with our own.
local OldModBlueprints = ModBlueprints
-- Overwrite the original ModBlueprints
function ModBlueprints(all_blueprints)
    -- first let us call the original ModBlueprints function
    OldModBlueprints(all_blueprints)

    -- Remove shield from T3 Harb
    local harb = all_blueprints.Unit['ual0303']
    if harb then
        if harb.Defense and harb.Defense.Shield then
            harb.Defense.Shield = nil
        end
        if harb.General and harb.General.ToggleCaps then
            harb.General.ToggleCaps = nil
        end
        table.removeByValue(harb.Display.Abilities, '<LOC ability_personalshield>Personal Shield')
    end

    -- Aeon T2 Torp Launcher
    -- Different RackBones
    local unit = all_blueprints.Unit['uab2205']
    if unit and unit.Weapon and unit.Weapon[1] and unit.Weapon[1].RackBones then
        unit.Weapon[1].RackBones = {
            { MuzzleBones = { "Turret_Muzzle_01" }, RackBone = "Turret_Barrel" },
            { MuzzleBones = { "Turret_Muzzle_02" }, RackBone = "Turret_Barrel" },
            { MuzzleBones = { "Turret_Muzzle_03" }, RackBone = "Turret_Barrel" },
            { MuzzleBones = { "Turret_Muzzle_04" }, RackBone = "Turret_Barrel" }
        }
    end

    -- UEF T2 Torp Launcher
    -- Different RackBones
    local unit = all_blueprints.Unit['ueb2205']
    if unit and unit.Weapon and unit.Weapon[1] and unit.Weapon[1].RackBones then
        unit.Weapon[1].RackBones = {
            { MuzzleBones = { "Turret_Muzzle01" }, RackBone = "Turret_Muzzle01" },
            { MuzzleBones = { "Turret_Muzzle02" }, RackBone = "Turret_Muzzle02" },
            { MuzzleBones = { "Turret_Muzzle03" }, RackBone = "Turret_Muzzle03" },
            { MuzzleBones = { "Turret_Muzzle04" }, RackBone = "Turret_Muzzle04" }
        }
    end

    -- UEF T3 SAM Launcher
    -- Different RackBones
    local unit = all_blueprints.Unit['ueb2304']
    if unit and unit.Weapon and unit.Weapon[1] and unit.Weapon[1].RackBones then
        unit.Weapon[1].RackBones = {
            { MuzzleBones = { "Turret_Muzzle_Left01" }, RackBone = "Turret_Barrel" },
            { MuzzleBones = { "Turret_Muzzle_Right01" }, RackBone = "Turret_Barrel" },
            { MuzzleBones = { "Turret_Muzzle_Left02" }, RackBone = "Turret_Barrel" },
            { MuzzleBones = { "Turret_Muzzle_Right02" }, RackBone = "Turret_Barrel" },
            { MuzzleBones = { "Turret_Muzzle_Left03" }, RackBone = "Turret_Barrel" },
            { MuzzleBones = { "Turret_Muzzle_Right03" }, RackBone = "Turret_Barrel" }
        }
    end

    -- now we loop over every UNIT blueprint
    for id,bp in all_blueprints.Unit do
        -- id = init ID. example: url0103
        -- bp = the whole content of the file url0103_unit.bp
        -- if we have Categories and MaxHealth > 0 inside the unit blueprint then...
        if bp.Categories then
            -- create an array where we can save the unit categories for easier access
            local Categories = {}
            -- loop over unit categories
            for _, cat in bp.Categories do
                -- example: Categories[TECH1] = true -> Categories.TECH1 == true
                Categories[cat] = true
            end
            -- Restrict all FA units, T3 Mobile AA
            --[[
            if Categories.PRODUCTFA or Categories.PRODUCTDL then
                LOG('processing unit >>>'..id..'<<< ('..(bp.Description or 'Unknown')..') removing TECH category to restrict the unit.')
                for i = 1, 3 do
                    table.removeByValue(bp.Categories, 'TECH' .. i)
                end
                table.removeByValue(bp.Categories, 'EXPERIMENTAL')
            end
            --]]
            -- Remove sACU presets
            if Categories.SUBCOMMANDER then
                if Categories.USEBUILDPRESETS then
                    LOG('processing unit >>>'..id..'<<< ('..(bp.Description or 'Unknown')..') removing USEBUILDPRESETS category.')
                    table.removeByValue(bp.Categories, 'USEBUILDPRESETS')
                end
                if bp.EnhancementPresets then
                    LOG('processing unit >>>'..id..'<<< ('..(bp.Description or 'Unknown')..') removing sACU presets.')
                    bp.EnhancementPresets = nil
                end
            end
        end
    end
end

-- SimLua do LOG(repr(ArmyBrains[1]:GetListOfUnits(categories.urs0201, false)[1]:GetBlueprint())) end