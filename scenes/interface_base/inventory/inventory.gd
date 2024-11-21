class_name InventoryDialog
extends Control

@export var loot_slot_scene:PackedScene

@onready var loot = %Loot
@onready var items = %Items
@onready var equipped_items = %EquippedItems


func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)

func open():
	loot.display(InventoryManager._all_loot)
	items.display(InventoryManager._all_items)
	equipped_items.display(TeamManager.get_equipped_items())

func on_battle_end(_win: bool) -> void:
	if visible:
		loot.update_quanities()
