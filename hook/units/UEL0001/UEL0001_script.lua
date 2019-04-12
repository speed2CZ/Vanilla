local oldUEL0001 = UEL0001
UEL0001 = Class(oldUEL0001) {
    CreateEnhancement = function(self, enh)
        -- Gun upgrade only increases damage of the main weapon
        if enh =='HeavyAntiMatterCannon' then
            ACUUnit.CreateEnhancement(self, enh)

            local bp = self:GetBlueprint().Enhancements[enh]
            local wep = self:GetWeaponByLabel('RightZephyr')
            wep:AddDamageMod(bp.ZephyrDamageMod)
        elseif enh == 'HeavyAntiMatterCannonRemove' then
            ACUUnit.CreateEnhancement(self, enh)

            local wep = self:GetWeaponByLabel('RightZephyr')
            wep:AddDamageMod(-bp.ZephyrDamageMod)
        else
            oldUEL0001.CreateEnhancement(self, enh)
        end
    end,
}

TypeClass = UEL0001
