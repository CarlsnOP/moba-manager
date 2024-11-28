class_name SaverLoader
extends Node

@onready var nav_menu = %NavMenu
@onready var interface = $"../../CanvasLayer/MC/Interface"

#Save functionality
func save_game():
	var saved_game: SavedGame = SavedGame.new()
	
	save_vars(saved_game)

	var saved_data: Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	saved_game.saved_data = saved_data
	
	ResourceSaver.save(saved_game, "user://savegame.tres")

func save_vars(saved_game: SavedGame) -> void:
	saved_game.rubber_duckies = InventoryManager.get_rubberduckies()
	saved_game.collected_items = InventoryManager.get_items_quantity()
	saved_game.collected_loot = InventoryManager.get_loot_quantity()
	saved_game.experience_gained = TeamManager.get_hero_xp()
	saved_game.equipped_items = TeamManager.get_equipped_items()
	saved_game.top = TeamManager.top
	saved_game.bot = TeamManager.bot
#	saved_game.jungle = TeamManager.jungle


#loading functionality
func load_game():
	var saved_game : SavedGame = SafeResourceLoader.load("user://savegame.tres")
	
	
	if saved_game == null:
		print("saved game was unsafe")
		return
	
	get_tree().call_group("game_events", "on_before_load_game")
	
	load_vars(saved_game)
	InventoryManager.set_items_quantity(saved_game.collected_items)
	InventoryManager.set_loot_quantity(saved_game.collected_loot)
	TeamManager.set_hero_xp(saved_game.experience_gained)
	TeamManager.set_equipped_items(saved_game.equipped_items)
	TeamManager.load_team()
	
	for item in saved_game.saved_data:
			var scene := load(item.scene_path) as PackedScene
			var restored_node = scene.instantiate()
		
			interface.add_child(restored_node)
			
			if restored_node.has_method("on_load_game"):
				restored_node.on_load_game(item)

func load_vars(saved_game: SavedGame) -> void:
	InventoryManager._rubberduckies = saved_game.rubber_duckies
	TeamManager.top = saved_game.top
	TeamManager.bot = saved_game.bot
	#TeamManager.jungle = saved_game.jungle

func _on_save_timer_timeout():
	#print("game has been saved")
	save_game()
