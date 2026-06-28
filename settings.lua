data:extend{
  {
    name = 'mhh-prototype-extra-cheese',
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
}
