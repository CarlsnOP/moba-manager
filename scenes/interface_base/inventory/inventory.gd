class_name InventoryDialog
extends Control

@export var loot_slot_scene:PackedScene

@onready var loot = %Loot
@onready var items = %Items



func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)

func open():
	loot.display(InventoryManager._all_loot)
	items.display(InventoryManager._all_items)

func on_battle_end(_win: bool) -> void:
	open()
