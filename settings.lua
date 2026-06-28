data:extend{
  {
    name = 'mhh-prototype-halve-equipment-size',
    type = 'bool-setting',
    setting_type = 'startup',
    default_value = false,
    order = 'a'
  },
  {
    name = 'mhh-prototype-enable-recipes',
    type = 'bool-setting',
    setting_type = 'startup',
    default_value = false,
    order = 'b'
  },
  {
    name = 'mhh-prototype-recipe-cost',
    type = 'int-setting',
    setting_type = 'startup',
    default_value = 10,
    minimum_value = 1,
    maximum_value = 100,
    order = 'c'
  },
  {
    name = 'mhh-prototype-strength',
    type = 'string-setting',
    setting_type = 'startup',
    default_value = 'balanced',
    allowed_values = { 'balanced', 'overpowered', 'cheaty' },
    order = 'd'
  },
}
