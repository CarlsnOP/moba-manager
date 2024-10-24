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

func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)

func open():
	_inventory = CurrencyManager.inventory
	item_list.clear()
	
	for item in CurrencyManager._all_items:
		var index = item_list.add_item(item.name)
		item_list.set_item_metadata(index, item)
	
	item_list.select(0)
	_on_recipe_list_item_selected(0)

func _on_recipe_list_item_selected(index):
	_results.clear()
	
	_selected_item = item_list.get_item_metadata(index)
	_results.append(_selected_item)
	update_displays()

func _on_craft_button_pressed():
	for loot in _selected_item.ingredients:
		_inventory.remove_loot(loot, _selected_item.amounts[0])
		
	for item in _results:
		_inventory.add_item(item, 1)
		
	update_displays()

func on_battle_end(_win: bool) -> void:
	update_displays()

func update_displays() -> void:
	loot_grid.display_recipe(_selected_item.ingredients, _selected_item.amounts[0])
	item_grid.display_result(_results)
	check_can_craft()

func check_can_craft() -> bool:
	for loot in _selected_item.ingredients:
		if loot.quantity > _selected_item.amounts[0]:
			craft_button.disabled = false
		else:
			craft_button.disabled = true
	return false
