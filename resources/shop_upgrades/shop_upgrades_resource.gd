class_name ShopUpgradeResource
extends Resource

enum TYPE { OFFENSIVE, DEFENSIVE, UTILITY, ECONOMY }
enum REWARD_TYPE { XP, RUBBERDUCKS, LOOT, HP, HPREG, AD, AP, BLOCK, DODGE, CRIT, HERORUBBERDUCK, MOVESPEED, ATTSPEED}

@export_group("Settings")
@export var name: String
@export var type: TYPE
@export var reward_type: REWARD_TYPE
@export var icon: CompressedTexture2D
@export var description: String
@export var base_cost: int = 100
@export var level: int = 0
@export var multiplier: float = 1.0
