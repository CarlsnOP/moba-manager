extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)
	

func on_battle_end(win: bool) -> void:
	pass
