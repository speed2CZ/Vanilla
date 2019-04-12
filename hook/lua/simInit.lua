local oldSetupSession = SetupSession

function SetupSession()
    oldSetupSession()

    import('/lua/game.lua').AddRestriction(
        categories.PRODUCTFA +      -- FA Units
        categories.SUPPORTFACTORY + -- Support factories
        categories.PRODUCTDL        -- T3 Mobile AA
    )
end