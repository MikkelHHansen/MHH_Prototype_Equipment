if script.active_mods["space-exploration"] then
  if name_thruster_suits then
    table.insert(name_thruster_suits, "mhh-prototype-thruster-suit")
  end
  if thruster_suit_thrust then
    thruster_suit_thrust["mhh-prototype-thruster-suit"] = 6
  end
end

if script.active_mods["jetpack"] then
  local ok, jetpack_mod = pcall(require, '__jetpack__/scripts/jetpack')
  if ok and jetpack_mod and jetpack_mod.jetpack_armor then
    jetpack_mod.jetpack_armor["mhh-prototype-thruster-suit"] = { thrust = 6 }
  end
end
