extends Node

#luck get multiplied with total loot. 1.05 = 5 %
@export var luck := 1.05


func _ready() -> void:
	RewardManager._mod_luck += luck
