local oldVeterancyComponent = VeterancyComponent

VeterancyComponent = Class(oldVeterancyComponent) {
	--- Adds a single level of veterancy
    ---@param self Unit | VeterancyComponent
    AddVetLevel = function(self)
        local blueprint = self.Blueprint
        if not blueprint.VetEnabled then
            return
        end

        local nextLevel = self.VetLevel + 1
        self.VetLevel = nextLevel
        self:SetStat('VetLevel', nextLevel)
		
		----------------------------------------------------------------------------------
		-- Use the veterancy buffs from bp instead of global ones, buffing weapons as well.
		----------------------------------------------------------------------------------
		
		-- Inform all weapons that have veteraned
        local old = self.VetLevel - 1 --self.Sync.VeteranLevel - 1
        for i = 1, self:GetWeaponCount() do
            local wep = self:GetWeapon(i)
            wep:OnVeteranLevel(old, nextLevel)
        end

        -- Check for unit buffs
        local bp = blueprint.Buffs
        if bp then
            local lvlkey = 'VeteranLevel' .. nextLevel
            for k, v in bp do
                if v.Add[lvlkey] == true then
                    self:AddBuff(v)
                end
            end
        end
		
		-- And do normal callbacks
		self:DoUnitCallbacks('OnVeteran')
        self.Brain:OnBrainUnitVeterancyLevel(self, nextLevel)
    end,
}
