extends Resource

class_name HeroResource

@export_group("Settings")
@export var hero_icon: CompressedTexture2D
@export var hero_name: String
@export var health: float
@export var health_regen: float = 5.0
@export var attack_damage: float
@export var ability_power: float
@export var dodge: float = 0.01
@export var block: float = 0.05
@export var crit: float = 0.05
