class_name BuildingsDialog
extends Control


@export var slot_scene: PackedScene
@export var hero_list: HeroListResource = preload("res://resources/heroes/resources/hero_list.tres")

@onready var grid_container = %GridContainer
@onready var hero_page = %HeroPage


func _ready():
	SignalManager.on_hero_selected.connect(on_hero_selected)
	
func on_hero_selected(hero: HeroResource):
	hero_page.show()
	hero_page.setup(hero)

func add_heroes():
	for hero in hero_list.heroes:
		var slot = slot_scene.instantiate()
		grid_container.add_child(slot)
		slot.add_to_group("hero_buttons")
		slot.display(hero)

func _on_exit_button_pressed():
	hero_page.hide()
