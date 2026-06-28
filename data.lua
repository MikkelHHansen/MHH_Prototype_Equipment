local path_g = '__MHH_Prototype_Equipment__/graphics/'
local path_i = path_g .. 'icons/'

local eq_size = (settings.startup['mhh-prototype-halve-equipment-size'].value and 1) or 2
local enabled = settings.startup['mhh-prototype-enable-recipes'].value
local e_count = (settings.startup['mhh-prototype-recipe-cost'].value) or 10

local has_se = data.raw["item"]["se-holmium-cable"] ~= nil
local has_k2 = data.raw["item"]["kr-imersium-plate"] ~= nil

------------------------------------------

local robot = table.deepcopy(data.raw['construction-robot']['construction-robot'])
robot.name = 'mhh-prototype-construction-robot'
robot.icon = path_i .. 'mhh-prototype-construction-robot.png'
robot.minable = { mining_time = 0.1, result = 'mhh-prototype-construction-robot' }
robot.resistances = { { type = 'fire', percent = 100 }, { type = 'acid', percent = 100 } }
robot.max_payload_size = 1 * 10
robot.speed = 0.06 * 10
robot.max_energy = '100MJ'
robot.energy_per_tick = '0kJ'
robot.speed_multiplier_when_out_of_energy = 0.8
robot.energy_per_move = '0kJ'
robot.idle.filename = path_g .. 'construction-robot/construction-robot.png'
robot.in_motion.filename = path_g .. 'construction-robot/construction-robot.png'
robot.working.filename = path_g .. 'construction-robot/construction-robot-working.png'

local logistic = table.deepcopy(data.raw['logistic-robot']['logistic-robot'])
logistic.name = 'mhh-prototype-logistic-robot'
logistic.icon = path_i .. 'mhh-prototype-logistic-robot.png'
logistic.minable = { mining_time = 0.1, result = 'mhh-prototype-logistic-robot' }
logistic.resistances = { { type = 'fire', percent = 100 }, { type = 'acid', percent = 100 } }
logistic.max_payload_size = 1 * 10
logistic.speed = 0.06 * 10
logistic.max_energy = '100MJ'
logistic.energy_per_tick = '0kJ'
logistic.speed_multiplier_when_out_of_energy = 0.8
logistic.energy_per_move = '0kJ'
logistic.idle.filename = path_g .. 'logistic-robot/logistic-robot.png'
logistic.idle_with_cargo.filename = path_g .. 'logistic-robot/logistic-robot.png'
logistic.in_motion.filename = path_g .. 'logistic-robot/logistic-robot.png'
logistic.in_motion_with_cargo.filename = path_g .. 'logistic-robot/logistic-robot.png'

------------------------------------------

data:extend({
  -- Battery
  {
    type = 'battery-equipment',
    name = 'mhh-prototype-battery',
    sprite = { filename = path_g .. 'mhh-prototype-battery.png', width = 64, height = 128, priority = 'medium', scale = 0.5 },
    shape = { width = 1, height = 2, type = 'full' },
    energy_source = { type = 'electric', buffer_capacity = '1TJ', usage_priority = 'tertiary' },
    categories = { 'armor' },
  },
  {
    type = 'item',
    name = 'mhh-prototype-battery',
    localised_description = { 'item-description.mhh-prototype-battery' },
    icon = path_i .. 'mhh-prototype-battery.png',
    icon_size = 64,
    icon_mipmaps = 4,
    place_as_equipment_result = 'mhh-prototype-battery',
    subgroup = 'equipment',
    order = 'b[battery]-b[battery-equipment-mk3]',
    default_request_amount = 5,
    stack_size = 20,
  },
  -- Energy Shield
  {
    type = 'energy-shield-equipment',
    name = 'mhh-prototype-energy-shield',
    sprite = { filename = path_g .. 'mhh-prototype-energy-shield.png', width = 128, height = 128, priority = 'medium', scale = 0.5 },
    shape = { width = eq_size, height = eq_size, type = 'full' },
    max_shield_value = 10000,
    energy_source = {
      type = 'electric',
      buffer_capacity = '100MJ',
      input_flow_limit = '100MW',
      usage_priority = 'primary-input',
    },
    energy_per_shield = '1kJ',
    categories = { 'armor' },
  },
  {
    type = 'item',
    name = 'mhh-prototype-energy-shield',
    localised_description = { 'item-description.mhh-prototype-energy-shield' },
    icon = path_i .. 'mhh-prototype-energy-shield.png',
    icon_size = 64,
    icon_mipmaps = 4,
    place_as_equipment_result = 'mhh-prototype-energy-shield',
    subgroup = 'military-equipment',
    order = 'a[shield]-b[energy-shield-equipment-mk3]',
    default_request_amount = 5,
    stack_size = 20,
  },
  -- Fusion Reactor
  {
    type = 'generator-equipment',
    name = 'mhh-prototype-fusion-reactor',
    sprite = { filename = path_g .. 'mhh-prototype-fusion-reactor.png', width = 256, height = 256, priority = 'medium', scale = 0.5 },
    shape = { width = eq_size * eq_size, height = eq_size * eq_size, type = 'full' },
    energy_source = { type = 'electric', usage_priority = 'primary-output' },
    power = '1TW',
    categories = { 'armor' },
  },
  {
    type = 'item',
    name = 'mhh-prototype-fusion-reactor',
    icon = path_i .. 'mhh-prototype-fusion-reactor.png',
    icon_size = 64,
    icon_mipmaps = 4,
    place_as_equipment_result = 'mhh-prototype-fusion-reactor',
    subgroup = 'equipment',
    order = 'a[energy-source]-b[fusion-reactor-mk2]',
    default_request_amount = 1,
    stack_size = 20,
  },
  -- Personal Laser defense
  {
    type = 'active-defense-equipment',
    name = 'mhh-prototype-personal-laser-defense',
    sprite = {
      filename = path_g .. 'mhh-prototype-personal-laser-defense.png',
      width = 128,
      height = 128,
      priority = 'medium',
      scale = 0.5,
    },
    shape = { width = eq_size, height = eq_size, type = 'full' },
    energy_source = { type = 'electric', usage_priority = 'secondary-input', buffer_capacity = '1MJ' },

    attack_parameters = {
      type = 'beam',
      cooldown = 40,
      range = 32,
      damage_modifier = 3 * 100,
      ammo_category = 'laser',
      ammo_type = {
        category = 'laser',
        energy_consumption = '0MJ',
        action = {
          type = 'direct',
          action_delivery = {
            type = 'beam',
            beam = 'laser-beam',
            max_length = 32,
            duration = 40,
            source_offset = { 0, -1.31439 },
          },
        },
      },
    },
    automatic = true,
    categories = { 'armor' },
  },
  {
    type = 'item',
    name = 'mhh-prototype-personal-laser-defense',
    icon = path_i .. 'mhh-prototype-personal-laser-defense.png',
    icon_size = 64,
    icon_mipmaps = 4,
    place_as_equipment_result = 'mhh-prototype-personal-laser-defense',
    subgroup = 'military-equipment',
    order = 'b[active-defense]-a[personal-laser-defense-equipment]-mk2',
    default_request_amount = 5,
    stack_size = 20,
  },
  -- Exoskeleton
  {
    type = 'movement-bonus-equipment',
    name = 'mhh-prototype-exoskeleton',
    sprite = { filename = path_g .. 'mhh-prototype-exoskeleton.png', width = 128, height = 256, priority = 'medium', scale = 0.5 },
    shape = { width = eq_size, height = 2 * eq_size, type = 'full' },
    energy_source = { type = 'electric', usage_priority = 'secondary-input' },
    energy_consumption = '1W',
    movement_bonus = 2,
    categories = { 'armor' },
  },
  {
    type = 'item',
    name = 'mhh-prototype-exoskeleton',
    icon = path_i .. 'mhh-prototype-exoskeleton.png',
    icon_size = 64,
    icon_mipmaps = 4,
    place_as_equipment_result = 'mhh-prototype-exoskeleton',
    subgroup = 'utility-equipment',
    order = 'd[exoskeleton]-b[exoskeleton-equipment-mk2]',
    default_request_amount = 5,
    stack_size = 20,
  },
  -- Personal Roboport
  {
    type = 'roboport-equipment',
    name = 'mhh-prototype-personal-roboport',
    take_result = 'mhh-prototype-personal-roboport',
    sprite = {
      filename = path_g .. 'mhh-prototype-personal-roboport.png',
      width = 128,
      height = 128,
      priority = 'medium',
      scale = 0.5,
    },
    shape = { width = eq_size, height = eq_size, type = 'full' },
    energy_source = {
      type = 'electric',
      buffer_capacity = '1TJ',
      input_flow_limit = '1TW',
      usage_priority = 'secondary-input',
    },
    charging_energy = '1TW',

    robot_limit = 500,
    construction_radius = 32,
    spawn_and_station_height = 0.4,
    spawn_and_station_shadow_height_offset = 0.5,
    charge_approach_distance = 2.6,
    robots_shrink_when_entering_and_exiting = true,

    recharging_animation = {
      filename = '__base__/graphics/entity/roboport/roboport-recharging.png',
      draw_as_glow = true,
      priority = 'high',
      width = 37,
      height = 35,
      frame_count = 16,
      scale = 1.5,
      animation_speed = 0.5,
    },
    recharging_light = { intensity = 0.2, size = 3, color = { r = 0.5, g = 0.5, b = 1.0 } },
    stationing_offset = { 0, -0.6 },
    charging_station_shift = { 0, 0.5 },
    charging_station_count = 250,
    charging_distance = 1.6,
    charging_threshold_distance = 5,
    categories = { 'armor' },
  },
  {
    type = 'item',
    name = 'mhh-prototype-personal-roboport',
    localised_description = { 'item-description.mhh-prototype-personal-roboport' },
    icon = path_i .. 'mhh-prototype-personal-roboport.png',
    icon_size = 64,
    icon_mipmaps = 4,
    place_as_equipment_result = 'mhh-prototype-personal-roboport',
    subgroup = 'utility-equipment',
    order = 'e[robotics]-b[personal-roboport-mk3-equipment]',
    default_request_amount = 1,
    stack_size = 20,
  },
  -- Equipment Grid
  {
    type = 'equipment-grid',
    name = 'mhh-prototype-equipment-grid',
    width = 11,
    height = 12,
    equipment_categories = { 'armor' }
  },
  -- Power Armor
  {
    type = 'armor',
    name = 'mhh-prototype-power-armor',
    icon = path_i .. 'mhh-prototype-power-armor.png',
    icon_size = 64,
    icon_mipmaps = 4,
    resistances = {
      { type = 'physical', decrease = 1000, percent = 90 },
      { type = 'acid', decrease = 1000, percent = 90 },
      { type = 'explosion', decrease = 1000, percent = 90 },
      { type = 'fire', decrease = 1000, percent = 90 },
    },
    subgroup = 'armor',
    order = 'e[power-armor-mk3]',
    stack_size = 1,
    infinite = true,
    equipment_grid = 'mhh-prototype-equipment-grid',
    inventory_size_bonus = 30,
    provides_flight = feature_flags.space_travel,
    open_sound = { filename = '__base__/sound/armor-open.ogg', volume = 1 },
    close_sound = { filename = '__base__/sound/armor-close.ogg', volume = 1 },
  },
  -- Construction Robot
  robot,
  {
    type = 'item',
    name = 'mhh-prototype-construction-robot',
    icon = path_i .. 'mhh-prototype-construction-robot.png',
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = 'logistic-network',
    order = 'a[robot]-b[construction-robot-mk2]',
    place_result = 'mhh-prototype-construction-robot',
    stack_size = 500,
  },
  -- Logistic Robot
  logistic,
  {
    type = 'item',
    name = 'mhh-prototype-logistic-robot',
    icon = path_i .. 'mhh-prototype-logistic-robot.png',
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = 'logistic-network',
    order = 'a[robot]-b[logistic-robot-mk2]',
    place_result = 'mhh-prototype-logistic-robot',
    stack_size = 500,
  },
  -- Stationary Roboport
  (function()
    local proto = table.deepcopy(data.raw.roboport.roboport)
    proto.name = 'mhh-prototype-roboport'
    proto.icon = '__base__/graphics/icons/roboport.png'
    proto.icon_size = 64
    proto.icon_mipmaps = 4
    proto.minable = { mining_time = 0.5, result = 'mhh-prototype-roboport' }
    proto.logistics_radius = 100
    proto.construction_radius = 220
    proto.energy_source = {
      type = 'electric',
      usage_priority = 'secondary-input',
      input_flow_limit = '48MW',
      buffer_capacity = '1200MJ',
    }
    proto.recharge_minimum = '480MJ'
    proto.energy_usage = '600kW'
    proto.charging_energy = '2MW'
    proto.robot_slots_count = 24
    proto.material_slots_count = 10

    local tint = { r = 0.55, g = 0.70, b = 1.0, a = 1.0 }
    local function tint_layers(sprite)
      if not sprite then return end
      if sprite.layers then
        for _, layer in ipairs(sprite.layers) do
          if layer.filename then layer.tint = tint end
        end
      elseif sprite.filename then
        sprite.tint = tint
      end
    end
    tint_layers(proto.base)
    tint_layers(proto.base_animation)
    tint_layers(proto.door_animation_up)
    tint_layers(proto.door_animation_down)
    return proto
  end)(),
  {
    type = 'item',
    name = 'mhh-prototype-roboport',
    icon = '__base__/graphics/icons/roboport.png',
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = 'logistic-network',
    order = 'c[signal]-a[roboport]-d[prototype]',
    place_result = 'mhh-prototype-roboport',
    stack_size = 10,
  },
})

local char = data.raw.character and data.raw.character.character
if char then
  local armor_list = char.animations and char.animations[#char.animations]
  if armor_list and armor_list.armors then
    table.insert(armor_list.armors, 'mhh-prototype-power-armor')
  end
  data.raw['character-corpse']['character-corpse'].armor_picture_mapping['mhh-prototype-power-armor'] = #char.animations
end

if not enabled then
  return
end

-- Build conditional ingredient lists
local function replace_ingredient(ingredients, old_name, new_name)
  for _, ing in ipairs(ingredients) do
    if ing.name == old_name then
      ing.name = new_name
    end
  end
end

local function add_ingredients(ingredients, additions)
  for _, add in ipairs(additions) do
    table.insert(ingredients, add)
  end
end

local rr_battery_ingredients = {
  { type = 'item', name = 'processing-unit', amount = 15 },
  { type = 'item', name = 'low-density-structure', amount = 5 },
  { type = 'item', name = 'battery-mk2-equipment', amount = e_count },
}
if has_se then
  replace_ingredient(rr_battery_ingredients, 'low-density-structure', 'se-holmium-cable')
end
if has_k2 then
  replace_ingredient(rr_battery_ingredients, 'battery-mk2-equipment', 'kr-big-battery-mk3-equipment')
  add_ingredients(rr_battery_ingredients, {
    { type = 'item', name = 'kr-lithium-sulfur-battery', amount = 10 },
  })
end

local rr_energy_shield_ingredients = {
  { type = 'item', name = 'processing-unit', amount = 5 },
  { type = 'item', name = 'low-density-structure', amount = 5 },
  { type = 'item', name = 'energy-shield-mk2-equipment', amount = e_count },
}
if has_se then
  add_ingredients(rr_energy_shield_ingredients, { { type = 'item', name = 'se-holmium-solenoid', amount = 5 } })
end
if has_k2 then
  replace_ingredient(rr_energy_shield_ingredients, 'energy-shield-mk2-equipment', 'kr-energy-shield-mk4-equipment')
end

local rr_fusion_reactor_ingredients = {
  { type = 'item', name = 'processing-unit', amount = 200 },
  { type = 'item', name = 'low-density-structure', amount = 50 },
  { type = 'item', name = 'uranium-fuel-cell', amount = 4 },
  { type = 'item', name = 'fission-reactor-equipment', amount = e_count },
}
if has_se then
  replace_ingredient(rr_fusion_reactor_ingredients, 'fission-reactor-equipment', 'se-antimatter-reactor-equipment')
end
if has_k2 then
  replace_ingredient(rr_fusion_reactor_ingredients, 'fission-reactor-equipment', 'kr-antimatter-reactor-equipment')
end

local rr_laser_ingredients = {
  { type = 'item', name = 'processing-unit', amount = 20 },
  { type = 'item', name = 'low-density-structure', amount = 5 },
  { type = 'item', name = 'personal-laser-defense-equipment', amount = e_count },
}
if has_k2 then
  replace_ingredient(rr_laser_ingredients, 'personal-laser-defense-equipment', 'kr-personal-laser-defense-mk4-equipment')
end

local rr_exoskeleton_ingredients = {
  { type = 'item', name = 'steel-plate', amount = 20 },
  { type = 'item', name = 'processing-unit', amount = 15 },
  { type = 'item', name = 'exoskeleton-equipment', amount = e_count },
}
if has_k2 then
  replace_ingredient(rr_exoskeleton_ingredients, 'exoskeleton-equipment', 'kr-superior-exoskeleton-equipment')
end

local rr_roboport_ingredients = {
  { type = 'item', name = 'processing-unit', amount = 100 },
  { type = 'item', name = 'low-density-structure', amount = 20 },
  { type = 'item', name = 'personal-roboport-mk2-equipment', amount = e_count },
}

local rr_construction_robot_ingredients = {
  { type = 'item', name = 'processing-unit', amount = 50 },
  { type = 'item', name = 'electric-engine-unit', amount = 20 },
  { type = 'item', name = 'low-density-structure', amount = 10 },
  { type = 'item', name = 'construction-robot', amount = e_count },
}
if has_se then
  add_ingredients(rr_construction_robot_ingredients, {
    { type = 'item', name = 'se-aeroframe-bulkhead', amount = 5 },
    { type = 'item', name = 'se-heavy-composite', amount = 5 },
  })
end
if has_k2 then
  add_ingredients(rr_construction_robot_ingredients, {
    { type = 'item', name = 'kr-imersium-plate', amount = 10 },
    { type = 'item', name = 'kr-energy-control-unit', amount = 5 },
  })
end

local rr_logistic_robot_ingredients = {
  { type = 'item', name = 'processing-unit', amount = 50 },
  { type = 'item', name = 'electric-engine-unit', amount = 20 },
  { type = 'item', name = 'low-density-structure', amount = 10 },
  { type = 'item', name = 'logistic-robot', amount = e_count },
}
if has_se then
  add_ingredients(rr_logistic_robot_ingredients, {
    { type = 'item', name = 'se-heavy-composite', amount = 5 },
  })
end
if has_k2 then
  add_ingredients(rr_logistic_robot_ingredients, {
    { type = 'item', name = 'kr-imersium-plate', amount = 10 },
  })
end

local rr_roboport_building_ingredients = {
  { type = 'item', name = 'processing-unit', amount = 50 },
  { type = 'item', name = 'electric-engine-unit', amount = 20 },
  { type = 'item', name = 'low-density-structure', amount = 25 },
  { type = 'item', name = 'roboport', amount = 10 },
}
if has_k2 then
  add_ingredients(rr_roboport_building_ingredients, {
    { type = 'item', name = 'kr-imersium-plate', amount = 10 },
    { type = 'item', name = 'kr-energy-control-unit', amount = 5 },
  })
end
if has_se then
  add_ingredients(rr_roboport_building_ingredients, {
    { type = 'item', name = 'se-holmium-cable', amount = 10 },
    { type = 'item', name = 'se-heavy-composite', amount = 5 },
  })
end

local rr_power_armor_ingredients = {
  { type = 'item', name = 'processing-unit', amount = e_count * 60 },
  { type = 'item', name = 'electric-engine-unit', amount = e_count * 40 },
  { type = 'item', name = 'low-density-structure', amount = e_count * 30 },
  { type = 'item', name = 'speed-module-2', amount = e_count * 25 },
  { type = 'item', name = 'efficiency-module-2', amount = e_count * 25 },
  { type = 'item', name = 'power-armor-mk2', amount = 1 },
}
if has_se then
  add_ingredients(rr_power_armor_ingredients, {
    { type = 'item', name = 'se-heavy-composite', amount = 10 },
    { type = 'item', name = 'se-aeroframe-bulkhead', amount = 5 },
  })
end
if has_k2 then
  add_ingredients(rr_power_armor_ingredients, {
    { type = 'item', name = 'kr-imersium-plate', amount = 20 },
    { type = 'item', name = 'kr-energy-control-unit', amount = 10 },
  })
  replace_ingredient(rr_power_armor_ingredients, 'power-armor-mk2', 'kr-power-armor-mk4')
end

data:extend({
  -- Battery
  {
    type = 'recipe',
    name = 'mhh-prototype-battery',
    enabled = false,
    ingredients = rr_battery_ingredients,
    results = {{ type = 'item', name = 'mhh-prototype-battery', amount = 1 }},
  },
  -- Energy Shield
  {
    type = 'recipe',
    name = 'mhh-prototype-energy-shield',
    enabled = false,
    ingredients = rr_energy_shield_ingredients,
    results = {{ type = 'item', name = 'mhh-prototype-energy-shield', amount = 1 }},
  },
  -- Fusion Reactor
  {
    type = 'recipe',
    name = 'mhh-prototype-fusion-reactor',
    enabled = false,
    ingredients = rr_fusion_reactor_ingredients,
    results = {{ type = 'item', name = 'mhh-prototype-fusion-reactor', amount = 1 }},
  },
  -- Personal Laser Defense
  {
    type = 'recipe',
    name = 'mhh-prototype-personal-laser-defense',
    enabled = false,
    ingredients = rr_laser_ingredients,
    results = {{ type = 'item', name = 'mhh-prototype-personal-laser-defense', amount = 1 }},
  },
  -- Exoskeleton
  {
    type = 'recipe',
    name = 'mhh-prototype-exoskeleton',
    enabled = false,
    ingredients = rr_exoskeleton_ingredients,
    results = {{ type = 'item', name = 'mhh-prototype-exoskeleton', amount = 1 }},
  },
  -- Personal Roboport
  {
    type = 'recipe',
    name = 'mhh-prototype-personal-roboport',
    enabled = false,
    ingredients = rr_roboport_ingredients,
    results = {{ type = 'item', name = 'mhh-prototype-personal-roboport', amount = 1 }},
  },
  -- Armor
  {
    type = 'recipe',
    name = 'mhh-prototype-power-armor',
    enabled = false,
    ingredients = rr_power_armor_ingredients,
    results = {{ type = 'item', name = 'mhh-prototype-power-armor', amount = 1 }},
  },
  -- Robots
  {
    type = 'recipe',
    name = 'mhh-prototype-construction-robot',
    enabled = false,
    ingredients = rr_construction_robot_ingredients,
    results = {{ type = 'item', name = 'mhh-prototype-construction-robot', amount = 1 }},
  },
  {
    type = 'recipe',
    name = 'mhh-prototype-logistic-robot',
    enabled = false,
    ingredients = rr_logistic_robot_ingredients,
    results = {{ type = 'item', name = 'mhh-prototype-logistic-robot', amount = 1 }},
  },
  -- Stationary Roboport
  {
    type = 'recipe',
    name = 'mhh-prototype-roboport',
    enabled = false,
    ingredients = rr_roboport_building_ingredients,
    results = {{ type = 'item', name = 'mhh-prototype-roboport', amount = 1 }},
  },
})

-- Build condition-dependent prerequisite lists
local function prereq_battery()
  if has_k2 then return { 'kr-battery-mk3-equipment' } end
  return { 'battery-mk2-equipment' }
end

local function prereq_reactor()
  if has_se and has_k2 then return { 'kr-antimatter-reactor-equipment' } end
  if has_se then return { 'se-antimatter-reactor-equipment' } end
  if has_k2 then return { 'kr-antimatter-reactor-equipment' } end
  return { 'fission-reactor-equipment' }
end

local function prereq_shield()
  if has_se then return { 'energy-shield-mk6-equipment' } end
  if has_k2 then return { 'kr-energy-shield-mk4-equipment' } end
  return { 'energy-shield-mk2-equipment' }
end

local function prereq_exoskeleton()
  if has_k2 then return { 'kr-superior-exoskeleton-equipment' } end
  return { 'exoskeleton-equipment' }
end

local function prereq_laser()
  if has_k2 then return { 'kr-personal-laser-defense-mk4-equipment' } end
  return { 'personal-laser-defense-equipment' }
end

local function prereq_roboport()
  if has_k2 then return { 'personal-roboport-mk2-equipment', 'kr-advanced-roboports' } end
  return { 'personal-roboport-mk2-equipment' }
end

local function prereq_roboport_building()
  local result = { 'construction-robotics', 'mhh-prototype-construction-robot' }
  if has_k2 then
    table.insert(result, 'kr-advanced-roboports')
  end
  return result
end

local function prereq_armor()
  local result = { 'mhh-prototype-battery-equipment', 'mhh-prototype-fusion-reactor-equipment', 'mhh-prototype-energy-shield-equipment',
    'mhh-prototype-exoskeleton-equipment', 'mhh-prototype-personal-laser-defense', 'mhh-prototype-personal-roboport',
    'mhh-prototype-construction-robot', 'mhh-prototype-logistic-robot' }
  if has_se and has_k2 then
    table.insert(result, 'se-thruster-suit-4')
    table.insert(result, 'kr-power-armor-mk4')
  elseif has_se then
    table.insert(result, 'se-thruster-suit-4')
  elseif has_k2 then
    table.insert(result, 'kr-power-armor-mk4')
  else
    table.insert(result, 'power-armor-mk2')
  end
  return result
end

-- Build condition-dependent science packs
local function make_packs(se_pack, k2_pack, extra)
  local packs = {
    { 'production-science-pack', 1 },
    { 'utility-science-pack', 1 },
  }
  if extra then
    for _, pack in ipairs(extra) do
      table.insert(packs, { pack, 1 })
    end
  end
  if has_se then
    table.insert(packs, { se_pack, 1 })
  end
  if has_k2 then
    table.insert(packs, { k2_pack, 1 })
  end
  return packs
end

local function make_armor_packs()
  local packs = {
    { 'automation-science-pack', 1 },
    { 'logistic-science-pack', 1 },
    { 'chemical-science-pack', 1 },
    { 'military-science-pack', 1 },
    { 'production-science-pack', 1 },
    { 'utility-science-pack', 1 },
  }
  if has_se then
    table.insert(packs, { 'se-deep-space-science-pack-3', 1 })
  end
  if has_k2 then
    table.insert(packs, { 'kr-singularity-tech-card', 1 })
  end
  return packs
end

data:extend({
  {
    type = 'technology',
    name = 'mhh-prototype-battery-equipment',
    icon = path_i .. 'mhh-prototype-battery.png',
    icon_size = 64,
    prerequisites = prereq_battery(),
    unit = { count = 500, ingredients = make_packs('se-energy-science-pack-4', 'kr-advanced-tech-card'), time = 60 },
    effects = { { type = 'unlock-recipe', recipe = 'mhh-prototype-battery' } },
  },
  {
    type = 'technology',
    name = 'mhh-prototype-fusion-reactor-equipment',
    icon = path_i .. 'mhh-prototype-fusion-reactor.png',
    icon_size = 64,
    prerequisites = prereq_reactor(),
    unit = { count = 1000, ingredients = make_packs('se-deep-space-science-pack-2', 'kr-singularity-tech-card'), time = 60 },
    effects = { { type = 'unlock-recipe', recipe = 'mhh-prototype-fusion-reactor' } },
  },
  {
    type = 'technology',
    name = 'mhh-prototype-energy-shield-equipment',
    icon = path_i .. 'mhh-prototype-energy-shield.png',
    icon_size = 64,
    prerequisites = prereq_shield(),
    unit = { count = 1000, ingredients = make_packs('se-deep-space-science-pack-3', 'kr-advanced-tech-card', { 'military-science-pack' }), time = 60 },
    effects = { { type = 'unlock-recipe', recipe = 'mhh-prototype-energy-shield' } },
  },
  {
    type = 'technology',
    name = 'mhh-prototype-exoskeleton-equipment',
    icon = path_i .. 'mhh-prototype-exoskeleton.png',
    icon_size = 64,
    prerequisites = prereq_exoskeleton(),
    unit = { count = 500, ingredients = make_packs('se-material-science-pack-3', 'kr-advanced-tech-card'), time = 60 },
    effects = { { type = 'unlock-recipe', recipe = 'mhh-prototype-exoskeleton' } },
  },
  {
    type = 'technology',
    name = 'mhh-prototype-personal-laser-defense',
    icon = path_i .. 'mhh-prototype-personal-laser-defense.png',
    icon_size = 64,
    prerequisites = prereq_laser(),
    unit = { count = 1000, ingredients = make_packs('se-material-science-pack-4', 'kr-advanced-tech-card', { 'military-science-pack' }), time = 60 },
    effects = { { type = 'unlock-recipe', recipe = 'mhh-prototype-personal-laser-defense' } },
  },
  {
    type = 'technology',
    name = 'mhh-prototype-personal-roboport',
    icon = path_i .. 'mhh-prototype-personal-roboport.png',
    icon_size = 64,
    prerequisites = prereq_roboport(),
    unit = { count = 1000, ingredients = make_packs('se-energy-science-pack-3', 'kr-advanced-tech-card'), time = 60 },
    effects = { { type = 'unlock-recipe', recipe = 'mhh-prototype-personal-roboport' } },
  },
  {
    type = 'technology',
    name = 'mhh-prototype-construction-robot',
    icon = path_i .. 'mhh-prototype-construction-robot.png',
    icon_size = 64,
    prerequisites = { 'construction-robotics' },
    unit = { count = 500, ingredients = make_packs('se-material-science-pack-2', 'kr-advanced-tech-card'), time = 60 },
    effects = { { type = 'unlock-recipe', recipe = 'mhh-prototype-construction-robot' } },
  },
  {
    type = 'technology',
    name = 'mhh-prototype-logistic-robot',
    icon = path_i .. 'mhh-prototype-logistic-robot.png',
    icon_size = 64,
    prerequisites = { 'logistic-robotics' },
    unit = { count = 500, ingredients = make_packs('se-material-science-pack-2', 'kr-advanced-tech-card'), time = 60 },
    effects = { { type = 'unlock-recipe', recipe = 'mhh-prototype-logistic-robot' } },
  },
  {
    type = 'technology',
    name = 'mhh-prototype-roboport',
    icon = '__base__/graphics/icons/roboport.png',
    icon_size = 64,
    prerequisites = prereq_roboport_building(),
    unit = { count = 1000, ingredients = make_packs('se-energy-science-pack-3', 'kr-advanced-tech-card'), time = 60 },
    effects = { { type = 'unlock-recipe', recipe = 'mhh-prototype-roboport' } },
  },
  {
    type = 'technology',
    name = 'mhh-prototype-power-armor',
    icon = path_g .. 'mhh-prototype-equipments.png',
    icon_size = 256,
    prerequisites = prereq_armor(),
    unit = { count = 5000, ingredients = make_armor_packs(), time = 120 },
    effects = { { type = 'unlock-recipe', recipe = 'mhh-prototype-power-armor' } },
  },
})
