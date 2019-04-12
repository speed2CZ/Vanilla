local oldUAL0001 = UAL0001
UAL0001 = Class(oldUAL0001) {
    CreateEnhancement = function(self, enh)
        -- Range upgrade doesn't affect OC
        if enh == 'CrysalisBeam' then
            ACUUnit.CreateEnhancement(self, enh)

            local bp = self:GetBlueprint().Enhancements[enh]
            local wep = self:GetWeaponByLabel('RightDisruptor')
            wep:ChangeMaxRadius(bp.NewMaxRadius or 44)
        elseif enh == 'CrysalisBeamRemove' then
            ACUUnit.CreateEnhancement(self, enh)

            local wep = self:GetWeaponByLabel('RightDisruptor')
            local bpDisrupt = self:GetBlueprint().Weapon[1].MaxRadius
            wep:ChangeMaxRadius(bpDisrupt or 22)
        else
            oldUAL0001.CreateEnhancement(self, enh)
        end
    end,
}

TypeClass = UAL0001
