class_name BuildingsDialog
extends Control

const EQUIPMENT_GRID = preload("res://scenes/interfaces/crafting/equipment_grid.tscn")
const ADD_EQUIPMENT = preload("res://assets/art/ui/add_equipment.png")

@export var slot_scene: PackedScene

@onready var grid_container = %GridContainer
@onready var hero_page = %HeroPage
@onready var equipment_container = %EquipmentContainer
@onready var control = %Control
@onready var equipment_1_button = %Equipment1Button
@onready var unequip_button = %UnequipButton

var current_hero: HeroResource = null

func _ready():
	SignalManager.on_hero_selected.connect(on_hero_selected)
	
func on_hero_selected(hero: HeroResource):
	current_hero = hero
	if hero.equipped_equipment != null:
		unequip_button.show()
		equipment_1_button.icon = hero.equipped_equipment.icon
	else:
		equipment_1_button.icon = ADD_EQUIPMENT
		
	hero_page.show()
	hero_page.setup(hero)

func add_heroes():
	for hero in TeamManager._all_heroes:
		var slot = slot_scene.instantiate()
		grid_container.add_child(slot)
		slot.add_to_group("hero_buttons")
		slot.display(hero)

func update_heroes() -> void:
	for child in grid_container.get_children():
		if child.has_method("update"):
			child.display()

func _on_exit_button_pressed():
	hero_page.hide()

func _on_equipment_1_button_pressed():
	for child in control.get_children():
		child.queue_free()
	
	if equipment_container.visible:
		equipment_container.hide()
		return
		
	equipment_container.show()
	var equipment_grid = EQUIPMENT_GRID.instantiate()
	control.add_child(equipment_grid)
	
	equipment_grid.display(InventoryManager._all_equipment)
	
	for child in equipment_grid.get_children():
		child.gui_input.connect(_on_pressed.bind(child))

func _on_pressed(event: InputEvent, equipment):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var new_equipment = equipment.get_item() as EquipmentResource
		
		if current_hero.equipped_equipment != null:
			for possible_equipment in InventoryManager._all_equipment:
				if possible_equipment == current_hero.equipped_equipment:
					possible_equipment.quantity += 1
			
		current_hero.equipped_equipment = new_equipment
		new_equipment.quantity -= 1
		equipment_1_button.icon = new_equipment.icon
		
		if !unequip_button.visible:
			unequip_button.show()
			
		equipment_container.hide()
		StatsManager.update_multipliers()

func _on_close_items_button_pressed():
	equipment_container.hide()

func _on_unequip_button_pressed():
	for possible_item in InventoryManager._all_equipment:
		if possible_item == current_hero.equipped_equipment:
			current_hero.equipped_equipment = null
			possible_item.quantity += 1
	
	equipment_1_button.icon = ADD_EQUIPMENT
	unequip_button.hide()
	equipment_container.hide()
	StatsManager.update_multipliers()


func _on_quit_button_pressed():
	SignalManager.new_interface.emit(InterfaceManager.INTERFACE_STATE.BATTLESIM)
