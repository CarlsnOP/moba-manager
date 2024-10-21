extends Resource

class_name ItemResource

enum RARITY { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}

@export_group("Settings")
@export var name: String
@export var icon: CompressedTexture2D
@export var description: String
@export var rarity: RARITY
@export var effect: String

@export var ingredients:Array[LootResource] = []
