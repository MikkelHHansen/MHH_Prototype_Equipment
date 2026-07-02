if script.active_mods["jetpack"] then
  local ok, jetpack_mod = pcall(require, '__jetpack__/scripts/jetpack')
  if ok and jetpack_mod and jetpack_mod.jetpack_armor then
    jetpack_mod.jetpack_armor["mhh-prototype-power-armor"] = { thrust = 3 }
  end
end
