class_name SaverLoader
extends Node

@onready var nav_menu = %NavMenu
@onready var interface = $"../../CanvasLayer/MC/Interface"

var hero_list: HeroListResource = preload("res://resources/heroes/resources/hero_list.tres")

func save_game():
	var saved_game: SavedGame = SavedGame.new()
	
	save_vars(saved_game)

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
	
	load_vars(saved_game)
	TeamManager.load_team()
	
	for item in saved_game.saved_data:
			var scene := load(item.scene_path) as PackedScene
			var restored_node = scene.instantiate()
		
			interface.add_child(restored_node)
			
			if restored_node.has_method("on_load_game"):
				restored_node.on_load_game(item)

func save_vars(saved_game: SavedGame) -> void:
	saved_game.rubber_duckies = CurrencyManager.get_rubberduckies()
	saved_game.top = TeamManager.top
	saved_game.bot = TeamManager.bot
	saved_game.jungle = TeamManager.jungle

func load_vars(saved_game: SavedGame) -> void:
	CurrencyManager._rubberduckies = saved_game.rubber_duckies
	TeamManager.top = saved_game.top
	TeamManager.bot = saved_game.bot
	TeamManager.jungle = saved_game.jungle

func _on_save_timer_timeout():
	print("game has been saved")
	save_game()
