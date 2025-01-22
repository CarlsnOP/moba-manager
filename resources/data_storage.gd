class_name DataStorage
extends Resource

#Colors
#Credits for palette to https://lospec.com/palette-list/sweet-and-sour-20
#Misc
const COLOR_INVISABLE := Color(0,0,0,0)
const COLOR_WHITE := Color("f1efdf")

#Rarities
const COLOR_COMMON := Color("#e7e3c7")
const COLOR_UNCOMMON := Color("#469852")
const COLOR_RARE := Color("#0a4684")
const COLOR_EPIC := Color("#b967ad")
const COLOR_LEGENDARY := Color("#f5b97b")

#PNG FILES
#Status effects
const IRONCLAD_AURA = preload("res://assets/art/map/status_effects/ironclad_aura.png")
const SLOWED = preload("res://assets/art/map/status_effects/slowed.png")
const STUNNED = preload("res://assets/art/map/status_effects/stunned.png")

#Skills
const IRONCLAD_AURA_RANGE = preload("res://assets/art/skills/extra/ironclad_aura_range.png")
const CRUSHING_BLOW_PARTICLES = preload("res://battlesim/effects/crushing_blow_particles/crushing_blow_particles.tscn")
const MYSTIC_OVERFLOW_PROJECTILE = preload("res://assets/art/skills/extra/mystic_overflow_projectile.png")
const SECOND_CHANCE_PARTICLES = preload("res://battlesim/effects/second_chance_particles/second_chance_particles.tscn")

#Particles
const BASE_EXPLOSION = preload("res://battlesim/effects/explosion/base_explosion.tscn")
const HEALING_PARTICLES = preload("res://battlesim/effects/healing/healing_particles.tscn")
const DEATH_PARTICLES = preload("res://battlesim/effects/death_particles/death_particles.tscn")

#MISC
const BASE_PROJECTILE = preload("res://battlesim/projectiles/base_projectile/base_projectile.tscn")
const RUBBER_DUCKY_BUTTON = preload("res://scenes/rubber_ducky_page/rubber_ducky_button.tscn")

#UI
const ACHIEVED_DUCK = preload("res://assets/art/achievements/achieved_duck.png")
const UNACHIEVED_DUCK = preload("res://assets/art/achievements/unachieved_duck.png")
const ADD_EQUIPMENT = preload("res://assets/art/ui/add_equipment.png")
const RUBBERDUCK = preload("res://assets/art/ui/Rubberduck.png")

#Tutorial
const TUTORIAL_PAGE = preload("res://scenes/tutorial_page/tutorial_page.tscn")
