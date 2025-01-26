class_name SaverLoader
extends Node

#Save and load functionality is with help from: https://www.youtube.com/watch?v=43BZsLZheA4&t=3144s
#Saving and loading games with Godot
@onready var nav_menu = %NavMenu
@onready var interface = %Interface

#Save functionality
func save_game():
	var saved_game: SavedGame = SavedGame.new()
	
	save_vars(saved_game)
	save_tutorial_step(saved_game)

	var saved_data: Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	saved_game.saved_data = saved_data
	
	ResourceSaver.save(saved_game, "user://savegame.tres")

func save_vars(saved_game: SavedGame) -> void:
	var stage_ref = get_tree().get_first_node_in_group("stage_manager") as StageManager
	var profile_ref = get_tree().get_first_node_in_group("profile_page") as ProfilePage
	saved_game.nickname = profile_ref.nickname
	saved_game.rubber_duckies = InventoryManager.get_rubberduckies()
	saved_game.owned_hero_rubber_ducky = InventoryManager.owned_hero_rubber_ducky
	saved_game.collected_equipment = InventoryManager.get_equipment_quantity()
	saved_game.collected_loot = InventoryManager.get_loot_quantity()
	saved_game.experience_gained = TeamManager.get_hero_xp()
	saved_game.equipped_equipment = TeamManager.get_equipped_equipment()
	saved_game.unlocked_heroes = TeamManager.get_unlocked_heroes()
	saved_game.top = TeamManager.top
	saved_game.bot = TeamManager.bot
	saved_game.current_stage = stage_ref.current_stage
	saved_game.highest_stage = stage_ref.highest_stage
	saved_game.ach_master_dict = AchievementManager.the_almighty_storage_dictionary

func save_tutorial_step(saved_game: SavedGame) -> void:
	if get_tree().get_first_node_in_group("tutorial") as TutorialPage != null:
		var tutorial_ref = get_tree().get_first_node_in_group("tutorial") as TutorialPage
		saved_game.current_tut_step = tutorial_ref.tutorial_step
		saved_game.ducks_opened = tutorial_ref.rubberducks_opened
		
		if tutorial_ref.tutorial_step == 4 or tutorial_ref.tutorial_step == 6:
			saved_game.current_tut_step = tutorial_ref.tutorial_step -1
		
		if tutorial_ref.tutorial_step == 7:
			saved_game.current_tut_step = 8
	else:
		saved_game.current_tut_step = 8

#loading functionality
func load_game():
	var saved_game : SavedGame = SafeResourceLoader.load("user://savegame.tres")
	
	
	if saved_game == null:
		print("saved game was unsafe")
		return
	
	get_tree().call_group("game_events", "on_before_load_game")
	
	load_vars(saved_game)
	InventoryManager.set_equipment_quantity(saved_game.collected_equipment)
	InventoryManager.set_loot_quantity(saved_game.collected_loot)
	TeamManager.set_hero_xp(saved_game.experience_gained)
	TeamManager.set_equipped_equipment(saved_game.equipped_equipment)
	TeamManager.set_unlocked_heroes(saved_game.unlocked_heroes)
	if TeamManager.bot and TeamManager.top:
		TeamManager.load_team()
	
	for item in saved_game.saved_data:
			var scene := load(item.scene_path) as PackedScene
			var restored_node = scene.instantiate()
		
			interface.add_child(restored_node)
			
			if restored_node.has_method("on_load_game"):
				restored_node.on_load_game(item)

func load_vars(saved_game: SavedGame) -> void:
	var stage_ref = get_tree().get_first_node_in_group("stage_manager") as StageManager
	var tutorial_ref = get_tree().get_first_node_in_group("tutorial") as TutorialPage
	var profile_ref = get_tree().get_first_node_in_group("profile_page") as ProfilePage
	tutorial_ref.tutorial_step = saved_game.current_tut_step
	tutorial_ref.rubberducks_opened = saved_game.ducks_opened
	tutorial_ref.match_step()
	InventoryManager._rubberduckies = saved_game.rubber_duckies
	InventoryManager.owned_hero_rubber_ducky = saved_game.owned_hero_rubber_ducky
	TeamManager.top = saved_game.top
	TeamManager.bot = saved_game.bot
	stage_ref.current_stage = saved_game.current_stage
	stage_ref.highest_stage = saved_game.highest_stage
	profile_ref.set_nickname(saved_game.nickname)
	
	#Do it like this, so we can add more achievements in the furture
	for key in saved_game.ach_master_dict:
		if key in AchievementManager.the_almighty_storage_dictionary:
			AchievementManager.the_almighty_storage_dictionary[key] = saved_game.ach_master_dict[key]

func _on_save_timer_timeout():
	#print("game has been saved")
	save_game()
