extends Resource

class_name LootResource

enum RARITY { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}

@export_group("Settings")
@export var id: int = 0
@export var loot_name: String
@export var icon: CompressedTexture2D
@export var loot_description: String
@export var rarity: RARITY
