extends Node

#Backlog include modifiers for skills + items

func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)

func on_battle_end() -> void:
	GeneratorManager.generate_rubberduckies()
