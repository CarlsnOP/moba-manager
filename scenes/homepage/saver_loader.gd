class_name SaverLoader
extends Node

@onready var nav_menu = %NavMenu

func save_game():
	var saved_game: SavedGame = SavedGame.new()
	
	saved_game.rubber_duckies = CurrencyManager.get_rubberduckies()
	
	var saved_data: Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	saved_game.saved_data = saved_data
	
	ResourceSaver.save(saved_game, "user://savegame.tres")

func load_game():
	var saved_game : SavedGame = SafeResourceLoader.load("user://savegame.tres")
	
	
	if saved_game == null:
		print("saved game was unsafe")
		return
	
	get_tree().call_group("game_events", "on_before_load_game")
	
	CurrencyManager._rubberduckies = saved_game.rubber_duckies
	
	for item in saved_game.saved_data:
		if item.has_method("on_load_game"):
			item.on_load_game()


func _on_save_timer_timeout():
	print("game has been saved")
	save_game()
