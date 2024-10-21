class_name InventoryDialog
extends Control

@export var loot_slot_scene:PackedScene

@onready var grid_container:LootGrid = %GridContainer
@onready var item_grid = %ItemGrid


func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)

func open(inventory: Inventory):
	grid_container.display(inventory.get_loot())
	item_grid.display(inventory.get_item())

func on_battle_end(_win: bool) -> void:
	open(CurrencyManager.inventory)
