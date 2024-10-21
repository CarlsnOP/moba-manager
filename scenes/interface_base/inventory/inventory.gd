class_name InventoryDialog
extends Control

@export var loot_slot_scene:PackedScene

@onready var grid_container:LootGrid = %GridContainer
@onready var item_grid = %ItemGrid


func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)

func open():
	grid_container.display(CurrencyManager._all_loot)
	item_grid.display(CurrencyManager._all_items)

func on_battle_end(_win: bool) -> void:
	open()
