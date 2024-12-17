extends HeroResource

class_name FriendlyHeroResource

@export_group("Settings")
@export var hero_portrait: CompressedTexture2D
@export var in_team: bool
@export var skill: SkillResource
@export var equipped_item: ItemResource
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
