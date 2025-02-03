extends Node


const MINION = preload("res://battlesim/minions/minion.tscn")

@onready var respawn_enemy_minion_top = %RespawnEnemyMinionTop
@onready var respawn_enemy_minion_bot = %RespawnEnemyMinionBot
@onready var respawn_team_minion_top = %RespawnTeamMinionTop
@onready var respawn_team_minion_bot = %RespawnTeamMinionBot
@onready var spawn_timer = %SpawnTimer
@onready var new_game_manager: Node = %NewGameManager


var lanes := []
var enemy: bool
var stage_manager_ref: StageManager

func _ready():
	stage_manager_ref = get_tree().get_first_node_in_group("stage_manager")

func new_game() -> void:
	spawn_minions()
	spawn_timer.stop()
	spawn_timer.start()

func spawn_minions() -> void:
	spawn_enemies()
	spawn_friendlies()

func spawn_enemies() -> void:
	var spawn_enemy_minions := [respawn_enemy_minion_top, respawn_enemy_minion_bot]
	var top_lane := true
	
	for spawn_point in spawn_enemy_minions:
		var new_minion = MINION.instantiate() as Minion
		enemy = true
		new_minion.global_position = spawn_point.to_local(spawn_point.global_position)
		spawn_point.add_child(new_minion)
		new_minion.setup(enemy, top_lane)
		new_minion.apply_match_modifier(stage_manager_ref.get_stage_modifer())
		new_minion.add_to_group("enemy")
		new_minion.add_to_group("minion")
		
		if top_lane:
			new_minion.add_to_group("top")
		else:
			new_minion.add_to_group("bot")
			
		top_lane = false

func spawn_friendlies() -> void:
	var spawn_team_minions := [respawn_team_minion_top, respawn_team_minion_bot]
	var top_lane = true
	
	for spawn_point in spawn_team_minions:
		var new_minion = MINION.instantiate() as Minion
		enemy = false
		new_minion.global_position = spawn_point.to_local(spawn_point.global_position)
		spawn_point.add_child(new_minion)
		new_minion.setup(enemy, top_lane)
		new_minion.add_to_group("team")
		new_minion.add_to_group("minion")
		
		if top_lane:
			new_minion.add_to_group("top")
		else:
			new_minion.add_to_group("bot")
			
		top_lane = false

func _on_spawn_timer_timeout():
	spawn_minions()
	SignalManager.on_minions_spawn.emit()
