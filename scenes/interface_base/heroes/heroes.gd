class_name BuildingsDialog
extends Control

const ITEM_GRID = preload("res://scenes/interface_base/crafting/item_grid.tscn")

@export var slot_scene: PackedScene

@onready var grid_container = %GridContainer
@onready var hero_page = %HeroPage
@onready var item_popup = %ItemPopup

func _ready():
	SignalManager.on_hero_selected.connect(on_hero_selected)
	
func on_hero_selected(hero: HeroResource):
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
	#item_popup.clear()
	var item_grid = ITEM_GRID.instantiate()
	item_popup.add_child(item_grid)
	item_grid.display(InventoryManager._all_items)
	item_popup.popup()
