class_name RubberDuckyPage
extends Control

const HERO_RUBBERDUCKY_COST := 10000

@onready var duck_position = %DuckPosition



func update() -> void:
	#Wait for previous duck to queue free
	await get_tree().create_timer(0.1).timeout
	
	var possible_hero_pool: Array
	for hero in TeamManager._all_heroes:
		if !hero.unlocked:
			possible_hero_pool.append(hero)
	
	if InventoryManager.owned_hero_rubber_ducky > 0 and duck_position.get_children().size() <= 0:
		ObjectMakerManager.instantiate_scene_with_parent(DataStorage.RUBBER_DUCKY_BUTTON, duck_position)
	

func _on_quit_button_pressed():
	SignalManager.new_interface.emit(InterfaceManager.INTERFACE_STATE.BATTLESIM)
