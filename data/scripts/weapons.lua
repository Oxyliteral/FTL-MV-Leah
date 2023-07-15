local affectedWeapons = {
["Rusty Pre-emptive Flak"] = true
}
local cooldownAddAmount = 9
local cooldownCount = 2

script.on_internal_event(Defines.InternalEvents.ON_TICK,
function()
  if Hyperspace.ships.player then
    local base = Hyperspace.ships.player:GetWeaponList()
    local weapons = {}
    for i = 0, base:size()-1 do
      weapons[i + 1] = base[i]
    end
    for i, weapon in pairs(weapons) do
      if affectedWeapons[weapon.name] and weapon.powered then
        if weapon.bFiredOnce and weapon.boostLevel < cooldownCount then
          weapon.boostLevel = weapon.boostLevel + 1
          weapon.bFiredOnce = false
          local reset = 1
          if weapon.boostLevel > 1 then
            reset = cooldownAddAmount * (weapon.boostLevel - 1)
          end
          weapon.baseCooldown = weapon.baseCooldown / reset * (weapon.boostLevel * cooldownAddAmount)
          weapon.lastProjectileId = -2
        elseif weapon.lastProjectileId == -2 then
          if (not Hyperspace.ships.enemy) or Hyperspace.ships.enemy.ship.bDestroyed or Hyperspace.ships.player.bJumping then
            weapon.baseCooldown = weapon.baseCooldown / (weapon.boostLevel * cooldownAddAmount)
            weapon.boostLevel = 0
            weapon.lastProjectileId = -1
          elseif weapon.boostLevel == 0 and Hyperspace.ships.enemy and (not Hyperspace.ships.enemy.ship.bDestroyed) then
            weapon.boostLevel = cooldownCount
          end
        end
      end
    end
  end
end)


function waitForHyperspaceUpdate()
  local player
  if player == null or player == nil then
    player = Hyperspace.Global.GetInstance():GetCApp().world.playerShip
  end
          if weapon.boostLevel == 0 and player.enemyShip and (not player.enemyShip.shipAI.destroyed) and (not player.enemyShip.shipAi.surrendered) then
            weapon.boostLevel = cooldownCount
          elseif (not player.enemyShip) or player.enemyShip.shipAi.destroyed or player.enemyShip.surrendered then
            weapon.baseCooldown = weapon.baseCooldown / (weapon.boostLevel * cooldownAddAmount)
            weapon.boostLevel = 0
            weapon.lastProjectileId = -1
          end
end