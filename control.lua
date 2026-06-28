if script.active_mods["space-exploration"] then
  script.on_event(defines.events.on_player_armor_changed, function(event)
    local player = game.players[event.player_index]
    if not (player and player.valid and player.character) then return end

    local armor = player.get_inventory(defines.inventory.character_armor)
    if not (armor and armor[1] and armor[1].valid_for_read) then return end

    if armor[1].name == "mhh-prototype-thruster-suit" then
      if not storage.se_thruster_players then storage.se_thruster_players = {} end
      storage.se_thruster_players[player.index] = true
    else
      if storage.se_thruster_players then
        storage.se_thruster_players[player.index] = nil
      end
    end
  end)

  script.on_nth_tick(60, function()
    if not storage.se_thruster_players then return end
    for idx, _ in pairs(storage.se_thruster_players) do
      local player = game.players[idx]
      if player and player.valid and player.character and player.character.valid then
        local armor = player.get_inventory(defines.inventory.character_armor)
        if armor and armor[1] and armor[1].valid_for_read and armor[1].name == "mhh-prototype-thruster-suit" then
          if player.character.health > 0 then
            player.character.health = 500
          end
        else
          storage.se_thruster_players[idx] = nil
        end
      else
        storage.se_thruster_players[idx] = nil
      end
    end
  end)
end
