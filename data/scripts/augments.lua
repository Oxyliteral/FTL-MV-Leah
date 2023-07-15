script.on_internal_event(Defines.InternalEvents.PROJECTILE_UPDATE_POST,
function(projectile, preempted)
  if Hyperspace.ships.player and Hyperspace.ships.player:HasAugmentation("LOCKED_LEAH_KYLE_STUN_BOOST") > 0 then
        if projectile.damage.iStun == 0 and projectile.damage.stunChance == 0 then
	  projectile.damage.iStun = 1
	  projectile.damage.stunChance = 40
	end
   end
   return Defines.Chain.CONTINUE
end)



script.on_internal_event(Defines.InternalEvents.ON_TICK,
function()
  if Hyperspace.ships.player and Hyperspace.ships.player:HasAugmentation("LOCKED_LEAH_REFRESH_SHIELD") > 0 and Hyperspace.ships.enemy then
    local base = Hyperspace.ships.enemy:GetWeaponList()
    local weapons = {}
    for i = 0, base:size()-1 do
      weapons[i + 1] = base[i]
    end
    for i, weapon in pairs(weapons) do
      if weapon.powered and weapon.bFiredOnce then
        weapon.bFiredOnce = false
	if Hyperspace.ships.player.shieldSystem and Hyperspace.ships.player.shieldSystem.shields.power.super.first == 0 then
            local random = Hyperspace.random32() % 100
            if random > 50 then
	      Hyperspace.ships.player.shieldSystem:AddSuperShield(Hyperspace.ships.player.shieldSystem.center)
            end
	end
      end
    end
  end
end)
