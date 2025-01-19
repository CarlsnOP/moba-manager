extends Resource

class_name HeroResource

@export_group("Settings")
@export var hero_icon: CompressedTexture2D
@export var hero_portrait: CompressedTexture2D
@export var hero_name: String
@export var health: float
@export var health_regen: float = 5.0
@export var attack_damage: float
@export var ability_power: float
@export var dodge: float = 0.01
@export var block: float = 0.05
@export var crit: float = 0.05
@export var in_team: bool
@export var unlocked: bool = false
@export var skill: SkillResource
@export var equipped_equipment: EquipmentResource
@export var hero_autoattack_sfx: SoundEffectSettings.SOUND_EFFECT_TYPE
#-------------------------------------
@export_group("Hero Stats")
@export var lvl: int
@export var xp: int
@export var prestige: int = 0
@export var upgrade_points: int
#-------------------------------------
@export_group("Growth")
@export var extra_hp: float
@export var extra_ad: float
@export var extra_ap: float
#-------------------------------------
@export_group("Hero Specifics")
@export var type: String
@export var lore: String
