extends Resource

class_name HeroResource

@export_group("Settings")
@export var hero_name: String
@export var hero_icon: CompressedTexture2D
@export var hero_portrait: CompressedTexture2D
@export var in_team: bool
@export var skill: SkillResource
#-------------------------------------
@export_group("Hero Stats")
@export var lvl: int
@export var xp: int
@export var prestige: int = 0
@export var upgrade_points: int
@export var health: float
@export var attack_damage: float
@export var ability_power: float
#-------------------------------------
@export_group("Growth")
@export var extra_hp: float
@export var extra_ad: float
@export var extra_ap: float
#-------------------------------------
@export_group("Hero Specifics")
@export var type: String
@export var lore: String
