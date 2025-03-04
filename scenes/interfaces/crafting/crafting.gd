class_name CraftingDialog
extends Control

@export var loot_slot_scene:PackedScene
@export var item_slot_scene:PackedScene

@onready var equipment_grid = %EquipmentGrid
@onready var loot_grid = %LootGrid
@onready var equipment_list = %EquipmentList
@onready var craft_button = %CraftButton
@onready var equipment_desc_label = %EquipmentDescLabel
@onready var equipment_title_label = %EquipmentTitleLabel
@onready var equipment_effect_label = %EquipmentEffectLabel


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
		
	
	sort_equipment_list()
	set_item_colors_by_rarity()
	
	equipment_list.select(0)
	_on_recipe_list_item_selected(0)

func _on_recipe_list_item_selected(index):
	_results.clear()
	
	_selected_equipment = equipment_list.get_item_metadata(index)
	_results.append(_selected_equipment)
	equipment_title_label.text = str(_selected_equipment.name)
	equipment_title_label.modulate = FunctionWizard.apply_rarity_changes(_selected_equipment)
	equipment_effect_label.text = "Effect:\n" + str(_selected_equipment.effect)
	equipment_desc_label.text = str(_selected_equipment.description)
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
	loot_grid.display_recipe(_selected_equipment.ingredients, _selected_equipment.amounts)
	equipment_grid.display_result(_results)
	
	for i in range(equipment_list.get_item_count()):
		var equipment = equipment_list.get_item_metadata(i)
		if check_can_craft_for_equipment(equipment):
			equipment_list.set_item_custom_bg_color(i, Color("#a5bcbd"))
		else:
			equipment_list.set_item_custom_bg_color(i, Color("#a45259"))
	
	check_can_craft()

func check_can_craft_for_equipment(equipment: EquipmentResource) -> bool:
	for i in equipment.ingredients.size():
		var ingredient = equipment.ingredients[i]
		var required_amount = equipment.amounts[i]

		if ingredient.quantity < required_amount:
			return false
	
	return true

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

#Sort and color functionality
func sort_equipment_list() -> void:
	var item_data = []

	for i in range(equipment_list.get_item_count()):
		item_data.append({
			"index": i,
			"rarity": equipment_list.get_item_metadata(i)["rarity"],
			"name": equipment_list.get_item_text(i),
			"icon": equipment_list.get_item_icon(i),
			"metadata": equipment_list.get_item_metadata(i),
		})
	
	item_data.sort_custom(sort_by_rarity_and_name_for_equipment_list)

	equipment_list.clear()
	
	for item in item_data:
		var new_index = equipment_list.add_item(item["name"], item["icon"])
		equipment_list.set_item_metadata(new_index, item["metadata"])

func sort_by_rarity_and_name_for_equipment_list(a: Dictionary, b: Dictionary) -> bool:
	if a["rarity"] == b["rarity"]:
		return a["name"] < b["name"]
	return a["rarity"] < b["rarity"]

func set_item_colors_by_rarity() -> void:
	for i in range(equipment_list.get_item_count()):
		var equipment_metadata = equipment_list.get_item_metadata(i)
		var equipment_rarity = equipment_metadata["rarity"]
		
		match equipment_rarity:
			
			EquipmentResource.RARITY.COMMON:
				equipment_list.set_item_custom_fg_color(i, DataStorage.COLOR_COMMON)
			
			EquipmentResource.RARITY.UNCOMMON:
				equipment_list.set_item_custom_fg_color(i, DataStorage.COLOR_UNCOMMON)
				
			EquipmentResource.RARITY.RARE:
				equipment_list.set_item_custom_fg_color(i, DataStorage.COLOR_RARE)
				
			EquipmentResource.RARITY.EPIC:
				equipment_list.set_item_custom_fg_color(i, DataStorage.COLOR_EPIC)
				
			EquipmentResource.RARITY.LEGENDARY:
				equipment_list.set_item_custom_fg_color(i, DataStorage.COLOR_LEGENDARY)

func _on_quit_button_pressed():
	SignalManager.new_interface.emit(InterfaceManager.INTERFACE_STATE.BATTLESIM)
