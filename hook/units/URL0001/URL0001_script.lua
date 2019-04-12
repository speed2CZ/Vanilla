local oldURL0001 = URL0001
URL0001 = Class(oldURL0001) {
    CreateEnhancement = function(self, enh)
        -- Gun upgrade only increases damage of the main weapon
        if enh =='CoolingUpgrade' then
            ACUUnit.CreateEnhancement(self, enh)

            local bp = self:GetBlueprint().Enhancements[enh]
            local wep = self:GetWeaponByLabel('RightRipper')
            wep:ChangeRateOfFire(bp.NewRateOfFire or 2)
        elseif enh == 'CoolingUpgradeRemove' then
            ACUUnit.CreateEnhancement(self, enh)

            local wep = self:GetWeaponByLabel('RightRipper')
            local wepBp = self:GetBlueprint().Weapon
            for _, v in wepBp do
                if v.Label == 'RightRipper' then
                    wep:ChangeRateOfFire(v.RateOfFire or 1)
                    break
                end
            end
        else
            oldURL0001.CreateEnhancement(self, enh)
        end
    end,
}

TypeClass = URL0001
