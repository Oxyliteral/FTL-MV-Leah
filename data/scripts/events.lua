script.on_game_event("SOME_EVENT_WHERE_WE_LOSE_ARTY_2", false,
function loseArty2()
    local artillery = Hyperspace.ships.player.artillerySystems
    if artillery then
        if artillery:size() > 1 then
            local curMaxPower = artillery[1]:GetMaxPower()
            artillery[1]:SetPowerLoss(curMaxPower / 2)
        end
    end
end