# MHH Prototype Equipment

Adds configurable endgame prototype equipment, power armor, combat and logistics robots, and stationary roboports to Factorio. All items are balanced through three strength presets and adapt to detected mods (Space Age, Space Exploration, Krastorio 2).

## Contents

### Armor
- **mhh-prototype-power-armor** — Dynamic equipment grid, 90% resistances, flight with Space Age / Space Exploration

### Equipment
- Battery, energy shield, fusion reactor, exoskeleton, personal laser defense, personal roboport — all six with prototype-tier stats

### Robots
- mhh-prototype-construction-robot
- mhh-prototype-logistic-robot
- mhh-prototype-roboport (stationary)

## Settings

| Setting | Type | Default | Description |
|---|---|---|---|
| Halve Equipment Size | bool | false | Makes all prototype equipment occupy half their normal grid size |
| Enable Recipes | bool | false | Enables crafting recipes and technologies for all items |
| Equipment Strength | string | balanced | `balanced` / `overpowered` / `cheaty` — controls stat values |

## Recipes & Technologies

When **Enable Recipes** is turned on, the mod adds:
- **10 technologies** — one per equipment/armor/robot category
- **Tiered recipes** — ingredients, science packs, and prerequisites adapt to installed mods


Recipes are disabled by default — intended as a jumpstart supplement (see [MHH Jumpstart](https://mods.factorio.com/mod/MHH_Jumpstart)).

## Mod Detection

The mod automatically detects and adapts to:
- **Space Age** — adds electric resistance to armor, adjusts ingredient lists
- **Space Exploration** — adds SE-specific ingredients
- **Krastorio 2** — adds K2-specific ingredients and stat adjustments

Missing mods are handled gracefully — recipes fall back to vanilla ingredients.

## Strength Presets

| Preset | Shield | Battery | Laser DPS | Exoskeleton Speed |
|---|---|---|---|---|
| Balanced | 150 kJ | 250 GJ | 150 | +75% |
| Overpowered | 300 kJ | 500 GJ | 300 | +150% |
| Cheaty | 600 kJ | 1 TJ | 600 | +300% |

All stats scale with Space Exploration and Krastorio 2 when detected.

## Requirements

- **Factorio 2.0**
- Optional: Space Age, Space Exploration, Krastorio 2
