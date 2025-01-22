class_name RubberDuckyPage
extends Control

const HERO_RUBBERDUCKY_COST := 10000

@onready var buy_button = %BuyButton
@onready var duck_position = %DuckPosition
@onready var out_of_loot_rubber_ducks = %OutOfLootRubberDucks
@onready var out_of_duckies_label = %OutOfDuckiesLabel
@onready var out_of_duckies_label_2 = %OutOfDuckiesLabel2


func update() -> void:
	out_of_loot_rubber_ducks.hide()
	#Wait for previous duck to queue free
	await get_tree().create_timer(0.1).timeout
	
	buy_button.disabled = InventoryManager.get_rubberduckies() < HERO_RUBBERDUCKY_COST
	
	var possible_hero_pool: Array
	for hero in TeamManager._all_heroes:
		if !hero.unlocked:
			possible_hero_pool.append(hero)
	
	if possible_hero_pool.size() <= 0:
		buy_button.hide()
		out_of_duckies_label.text = "You unlocked all heroes!"
		out_of_duckies_label_2.hide()
	

	
	if InventoryManager.owned_hero_rubber_ducky > 0 and duck_position.get_children().size() <= 0:
		ObjectMakerManager.instantiate_scene_with_parent(DataStorage.RUBBER_DUCKY_BUTTON, duck_position)
	elif duck_position.get_children().size() > 0:
		out_of_loot_rubber_ducks.hide()
	else:
		out_of_loot_rubber_ducks.show()
	

func _on_buy_button_pressed():
	InventoryManager.spend_rubberduckies(HERO_RUBBERDUCKY_COST)
	InventoryManager.get_loot_ducky(1)
	
	update()

func _on_quit_button_pressed():
	SignalManager.new_interface.emit(InterfaceManager.INTERFACE_STATE.BATTLESIM)
