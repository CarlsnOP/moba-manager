extends Resource

class_name EquipmentResource

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
@export var equipment_hp: float = 1.0
@export var equipment_hp_regen: float = 1.0
@export var equipment_ad: float = 1.0
@export var equipment_ap: float = 1.0
@export var equipment_dodge: float = 0.0
@export var equipment_block: float = 0.0
@export var equipment_crit: float = 0.0
