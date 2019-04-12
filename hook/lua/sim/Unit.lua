local oldUnit = Unit

Unit = Class(oldUnit){
    -- Use the veterancy buffs from bp instead of global ones, buffing weapons as well.
    SetVeteranLevel = function(self, level)
        -- Inform all weapons that have veteraned
        local old = self.Sync.VeteranLevel - 1
        for i = 1, self:GetWeaponCount() do
            local wep = self:GetWeapon(i)
            wep:OnVeteranLevel(old, level)
        end

        -- Check for unit buffs
        local bp = self:GetBlueprint().Buffs
        if bp then
            local lvlkey = 'VeteranLevel' .. level
            for k, v in bp do
                if v.Add[lvlkey] == true then
                    self:AddBuff(v)
                end
            end
        end

        -- And do normal callbacks
        self:GetAIBrain():OnBrainUnitVeterancyLevel(self, level)
        self:DoUnitCallbacks('OnVeteran')
    end,

    -- Display the new regen in the UI, which is done in SetRegen() function
    AddBuff = function(self, buffTable, PosEntity)
        local bt = buffTable.BuffType
        if bt == 'HEALTHREGENRATE' then
            self:SetRegen(buffTable.Value)
        else
            oldUnit.AddBuff(self, buffTable, PosEntity)
        end
    end,
}