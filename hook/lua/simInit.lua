local oldSetupSession = SetupSession

function SetupSession()
    oldSetupSession()

    import('/lua/game.lua').AddRestriction(
        categories.PRODUCTFA +      -- FA Units
        categories.SUPPORTFACTORY + -- Support factories
        categories.dalk003 + categories.delk002 + categories.drlk001        -- T3 Mobile AA
    )
end