extends Resource

class_name ItemResource

enum RARITY { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}

@export_group("Settings")
@export var id: int
@export var name: String
@export var icon: CompressedTexture2D
@export var description: String
@export var rarity: RARITY
@export var effect: String
@export var quantity: int = 0
@export var ingredients:Array[LootResource] = []
@export var amounts: Array[int] = [0]

@export_group("stats")
@export var item_hp: float = 0.0
@export var item_hp_regen: float = 0.0
@export var item_ad: float = 0.0
@export var item_ap: float = 0.0
@export var item_dodge: float = 0.0
@export var item_block: float = 0.0
@export var item_crit: float = 0.0
