class_name SavedGame
extends Resource

@export var rubber_duckies: int
@export var collected_items: Array[int]
@export var collected_loot: Array[int]
@export var experience_gained: Array[int]
@export var equipped_items: Array[ItemResource]
@export var saved_data: Array[SavedData] = []

#Team
@export var top: HeroResource
@export var bot: HeroResource
@export var jungle: HeroResource

#Settings
@export var master_volume: float
@export var music_volume: float
@export var sfx_volume: float
