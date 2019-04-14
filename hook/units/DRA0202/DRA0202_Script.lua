-- Hooked so it won't slow down when attacking
-- also enabling stealth
DRA0202 = Class(CAirUnit) {
    Weapons = {
        GroundMissile = Class(CIFMissileCorsairWeapon) {},
    },
    OnStopBeingBuilt = function(self,builder,layer)
        CAirUnit.OnStopBeingBuilt(self,builder,layer)
        self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_StealthToggle', true)
        self:RequestRefreshUI()
    end,
    
}

TypeClass = DRA0202
