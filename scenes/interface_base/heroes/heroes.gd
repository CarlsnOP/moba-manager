class_name BuildingsDialog
extends Control

const ITEM_GRID = preload("res://scenes/interface_base/crafting/item_grid.tscn")
const ADD_ITEM = preload("res://assets/art/ui/add_item.png")

@export var slot_scene: PackedScene

@onready var grid_container = %GridContainer
@onready var hero_page = %HeroPage
@onready var item_container = %ItemContainer
@onready var control = %Control
@onready var item_1_button = %Item1Button
@onready var unequip_button = %UnequipButton

var current_hero: HeroResource = null

func _ready():
	SignalManager.on_hero_selected.connect(on_hero_selected)
	
func on_hero_selected(hero: HeroResource):
	current_hero = hero
	if hero.equipped_item != null:
		unequip_button.show()
		item_1_button.icon = hero.equipped_item.icon
		
	hero_page.show()
	hero_page.setup(hero)

func add_heroes():
	for hero in TeamManager._all_heroes:
		var slot = slot_scene.instantiate()
		grid_container.add_child(slot)
		slot.add_to_group("hero_buttons")
		slot.display(hero)

func _on_exit_button_pressed():
	hero_page.hide()

func _on_item_1_button_pressed():
	for child in control.get_children():
		child.queue_free()
	
	item_container.show()
	var item_grid = ITEM_GRID.instantiate()
	control.add_child(item_grid)
	
	item_grid.display(InventoryManager._all_items)
	
	for child in item_grid.get_children():
		child.gui_input.connect(_on_pressed.bind(child))

func _on_pressed(event: InputEvent, item):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var new_item = item.get_item() as ItemResource
		
		if current_hero.equipped_item != null:
			for possible_item in InventoryManager._all_items:
				if possible_item == current_hero.equipped_item:
					possible_item.quantity += 1
			
		current_hero.equipped_item = new_item
		new_item.quantity -= 1
		item_1_button.icon = new_item.icon
		
		if !unequip_button.visible:
			unequip_button.show()
			
		item_container.hide()

func _on_close_items_button_pressed():
	item_container.hide()

func _on_unequip_button_pressed():
	for possible_item in InventoryManager._all_items:
		if possible_item == current_hero.equipped_item:
			current_hero.equipped_item = null
			possible_item.quantity += 1
	
	item_1_button.icon = ADD_ITEM
	unequip_button.hide()
	item_container.hide()
