class_name CraftingDialog
extends Control

@export var loot_slot_scene:PackedScene
@export var item_slot_scene:PackedScene

@onready var equipment_grid = %EquipmentGrid
@onready var loot_grid = %LootGrid
@onready var equipment_list = %EquipmentList
@onready var craft_button = %CraftButton

var _results: Array[EquipmentResource] = []
var _inventory: Inventory
var _selected_equipment: EquipmentResource

func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)

func open():
	_inventory = InventoryManager.inventory
	equipment_list.clear()
	
	for equipment in InventoryManager._all_equipment:
		var index = equipment_list.add_item(equipment.name)
		equipment_list.set_item_metadata(index, equipment)
		
	
	equipment_list.select(0)
	_on_recipe_list_item_selected(0)

func _on_recipe_list_item_selected(index):
	_results.clear()
	
	_selected_equipment = equipment_list.get_item_metadata(index)
	_results.append(_selected_equipment)
	update_displays()

func _on_craft_button_pressed():
	for i in _selected_equipment.ingredients.size():
		var loot = _selected_equipment.ingredients[i]
		var required_amount = _selected_equipment.amounts[i]
		_inventory.remove_loot(loot, required_amount)
		
	for equipment in _results:
		_inventory.add_equipment(equipment, 1)
		SignalManager.on_equipment_crafted.emit(equipment)
		
	update_displays()

func on_battle_end(_win: bool) -> void:
	update_displays()

func update_displays() -> void:
	loot_grid.display_recipe(_selected_equipment.ingredients, _selected_equipment.amounts[0])
	equipment_grid.display_result(_results)
	check_can_craft()

func check_can_craft() -> bool:
	craft_button.disabled = true
	
	for i in _selected_equipment.ingredients.size():
		var ingredient = _selected_equipment.ingredients[i]
		var required_amount = _selected_equipment.amounts[i]
		

		if ingredient.quantity < required_amount:
			craft_button.disabled = true
			return false
			
	craft_button.disabled = false
	return false
