class_name CraftingDialog
extends Control

@export var loot_slot_scene:PackedScene
@export var item_slot_scene:PackedScene

@onready var item_list = %ItemList
@onready var loot_grid = %LootGrid
@onready var item_grid = %ItemGrid
@onready var craft_button = %CraftButton

var _results:Array[ItemResource] = []
var _inventory: Inventory
var _selected_item:ItemResource

func open(items: Array, inventory: Inventory):
	_inventory = inventory
	item_list.clear()
	
	for item in items:
		var index = item_list.add_item(item.name)
		item_list.set_item_metadata(index, item)
	
	item_list.select(0)
	_on_recipe_list_item_selected(0)

func _on_recipe_list_item_selected(index):
	_results.clear()
	
	_selected_item = item_list.get_item_metadata(index)
	loot_grid.display(_selected_item.ingredients)
	_results.append(_selected_item)
	item_grid.display(_results)
	
	craft_button.disabled = not _inventory.has_all(_selected_item.ingredients)

func _on_craft_button_pressed():
	for loot in _selected_item.ingredients:
		_inventory.remove_loot(loot)
		
	for item in _results:
		_inventory.add_item(item)
	
	craft_button.disabled = not _inventory.has_all(_selected_item.ingredients)
