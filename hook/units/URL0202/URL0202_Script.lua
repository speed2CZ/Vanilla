-- Use CDFParticleCannonWeapon, which is the original continuous laser
local CLandUnit = import("/lua/cybranunits.lua").CLandUnit
local CDFParticleCannonWeapon = import('/lua/cybranweapons.lua').CDFParticleCannonWeapon

---@class URL0202 : CLandUnit
URL0202 = Class(CLandUnit) {
    Weapons = {
        MainGun = Class(CDFParticleCannonWeapon) {},
        FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
    },
}

TypeClass = URL0202
