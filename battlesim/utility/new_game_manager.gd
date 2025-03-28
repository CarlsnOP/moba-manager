class_name NewGameManager
extends Node

const HERO = preload("res://battlesim/heroes/hero.tscn")
const TOWER = preload("res://battlesim/tower/tower.tscn")
const NEXUS = preload("res://battlesim/nexus/nexus.tscn")

@onready var spawn_enemy_nexus = %SpawnEnemyNexus
@onready var spawn_enemy_tower_top = %SpawnEnemyTowerTop
@onready var spawn_enemy_tower_bot = %SpawnEnemyTowerBot
@onready var spawn_team_nexus = %SpawnTeamNexus
@onready var spawn_team_tower_top = %SpawnTeamTowerTop
@onready var spawn_team_tower_bot = %SpawnTeamTowerBot
@onready var respawn_enemy_hero = %RespawnEnemyHero
@onready var respawn_team_hero = %RespawnTeamHero
@onready var respawn_enemy_minion_top = %RespawnEnemyMinionTop
@onready var respawn_enemy_minion_bot = %RespawnEnemyMinionBot
@onready var respawn_team_minion_top = %RespawnTeamMinionTop
@onready var respawn_team_minion_bot = %RespawnTeamMinionBot


var game_launced := false
var enemy: bool
var enemy1: HeroResource
var enemy2: HeroResource
var top_lane: bool

func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)
	SignalManager.restart_match.connect(start_battle_sim)
	
	await get_tree().physics_frame
	
	if TeamManager.bot != null and TeamManager.top != null:
		start_battle_sim()

func start_battle_sim() -> void:
	game_launced = false
	SignalManager.new_interface.emit(3)
	on_battle_end(false)
	game_launced = true
	
func on_battle_end(win: bool) -> void:
	var objects_to_be_cleared = get_tree().get_nodes_in_group("restart_map")
	var nodes_to_update = get_tree().get_nodes_in_group("update_post_match")
	MatchDataManager.update_last_match_elapsed_time()
	
	for object in objects_to_be_cleared:
		if object.has_method("new_game"):
			object.new_game()
	
	spawn_enemy_team()
	spawn_friendly_team()
	
	if game_launced:
		RewardManager.on_battle_end(win)
		
		if win:
			SoundManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.GAME_WIN)
		else:
			SoundManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.GAME_LOSE)
		
	for node in nodes_to_update:
		if node.has_method("update"):
			node.update()
	
func spawn_enemy_team() -> void:
	spawn_enemy_structures()
	spawn_enemy_heroes()

func spawn_enemy_structures() -> void:
	var spawn_enemy_towers := [spawn_enemy_tower_top, spawn_enemy_tower_bot]
	top_lane = true
	enemy = true
	
	for spawn_point in spawn_enemy_towers:
		var new_tower = TOWER.instantiate() as Tower
		new_tower.global_position = spawn_point.to_local(spawn_point.global_position)
		spawn_point.add_child(new_tower)
		new_tower.setup(enemy)
		new_tower.add_to_group("enemy")
		new_tower.add_to_group("tower")
		
		if top_lane:
			new_tower.add_to_group("top")
		else:
			new_tower.add_to_group("bot")
		top_lane = false
		
	var new_nexus = NEXUS.instantiate()
	new_nexus.position = spawn_enemy_nexus.to_local(spawn_enemy_nexus.global_position)
	spawn_enemy_nexus.add_child(new_nexus)
	new_nexus.setup(enemy)
	new_nexus.add_to_group("enemy")
	new_nexus.add_to_group("nexus")

func spawn_enemy_heroes() -> void:
	enemy = true
	top_lane = true
	#Choosing enemy heroes
	enemy1 = TeamManager.pick_random_enemy()
	enemy2 = TeamManager.pick_random_enemy()
	
	#making sure it isn't the same
	while enemy2 == enemy1:
		enemy2 = TeamManager.pick_random_enemy()
	
	var enemy_hero1 = HERO.instantiate()
	enemy_hero1.global_position = respawn_enemy_hero.to_local(respawn_enemy_hero.global_position)
	respawn_enemy_hero.add_child(enemy_hero1)
	enemy_hero1.setup(enemy1, enemy, top_lane, StatsManager.enemy_hero_specific_stats)
	enemy_hero1.add_to_group("enemy")
	enemy_hero1.add_to_group("hero")
	
	top_lane = false
	
	var enemy_hero2 = HERO.instantiate()
	enemy_hero2.global_position = respawn_enemy_hero.to_local(respawn_enemy_hero.global_position)
	respawn_enemy_hero.add_child(enemy_hero2)
	enemy_hero2.setup(enemy2, enemy, top_lane, StatsManager.enemy_hero_specific_stats)
	enemy_hero2.add_to_group("enemy")
	enemy_hero2.add_to_group("hero")
	
func spawn_friendly_team() -> void:
	spawn_friendly_nexus()
	spawn_friendly_towers()
	spawn_friendly_heroes()

func spawn_friendly_nexus() -> void:
	enemy = false
	var new_nexus = NEXUS.instantiate()
	new_nexus.global_position = spawn_team_nexus.to_local(spawn_team_nexus.global_position)
	spawn_team_nexus.add_child(new_nexus)
	new_nexus.setup(enemy)
	new_nexus.add_to_group("team")
	new_nexus.add_to_group("nexus")
	

func spawn_friendly_towers() -> void:
	var spawn_towers := [spawn_team_tower_top, spawn_team_tower_bot]
	top_lane = true
	enemy = false
	
	for spawn_point in spawn_towers:
		var new_tower = TOWER.instantiate() as Tower
		new_tower.global_position = spawn_point.to_local(spawn_point.global_position)
		spawn_point.add_child(new_tower)
		new_tower.setup(enemy)
		new_tower.add_to_group("team")
		new_tower.add_to_group("tower")
		
		if top_lane:
			new_tower.add_to_group("top")
		else:
			new_tower.add_to_group("bot")
			
		top_lane = false

func spawn_friendly_heroes() -> void:
	enemy = false
	top_lane = true
	
	var top_hero = HERO.instantiate()
	top_hero.global_position = respawn_team_hero.to_local(respawn_team_hero.global_position)
	respawn_team_hero.add_child(top_hero)
	top_hero.setup(TeamManager.top, enemy, top_lane, StatsManager.hero_specific_stats)
	top_hero.add_to_group("team")
	top_hero.add_to_group("hero")
	
	top_lane = false
	
	var bot_hero = HERO.instantiate()
	bot_hero.global_position = respawn_team_hero.to_local(respawn_team_hero.global_position)
	respawn_team_hero.add_child(bot_hero)
	bot_hero.setup(TeamManager.bot, enemy, top_lane, StatsManager.hero_specific_stats)
	bot_hero.add_to_group("team")
	bot_hero.add_to_group("hero")
