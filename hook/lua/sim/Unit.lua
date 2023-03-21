local oldUnit = Unit

Unit = Class(oldUnit){
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