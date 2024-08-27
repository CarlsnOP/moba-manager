extends Resource

class_name HeroResource

@export_group("Settings")
@export var hero_name: String
@export var hero_icon: CompressedTexture2D
@export var hero_scene: PackedScene
#-------------------------------------
@export_group("Hero Stats")
@export var health: float
@export var mana: float
@export var damage: float
#-------------------------------------
