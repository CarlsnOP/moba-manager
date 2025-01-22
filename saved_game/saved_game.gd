class_name SavedGame
extends Resource

@export var nickname: String
@export var collected_equipment: Array[int]
@export var collected_loot: Array[int]
@export var experience_gained: Array[int]
@export var equipped_equipment: Array[EquipmentResource]
@export var saved_data: Array[SavedData] = []

#Currency and rewards
@export var save_time: int = -1
@export var rubber_duckies: int
@export var owned_hero_rubber_ducky: int

#Team
@export var top: HeroResource
@export var bot: HeroResource
@export var unlocked_heroes: Array[HeroResource]

#Stage
@export var current_stage: int
@export var highest_stage: int

#Achievements
@export var ach_master_dict: Dictionary

#Tutorial
@export var current_tut_step: int
@export var ducks_opened: int
