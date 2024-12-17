extends Resource

class_name LootResource

enum RARITY { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}

@export_group("Settings")
@export var id: int = 0
@export var name: String
@export var icon: CompressedTexture2D
@export var description: String
@export var rarity: RARITY
@export var quantity: int = 0

@export var value := 1
@export var weight := 1.0
