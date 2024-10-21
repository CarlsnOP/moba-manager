class_name InventoryDialog
extends Control

@export var loot_slot_scene:PackedScene

@onready var grid_container:LootGrid = %GridContainer
@onready var item_grid = %ItemGrid


func open(inventory: Inventory):
	grid_container.display(inventory.get_loot())
	item_grid.display(inventory.get_item())
