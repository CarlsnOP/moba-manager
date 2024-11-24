extends Node

const BULLY_HEROES_SHEILA = preload("res://scenes/interface_base/battlesim/heroes/bully_heroes_basic/sheila/bully_heroes_sheila.tscn")
const BULLY_HEROES_VINNY = preload("res://scenes/interface_base/battlesim/heroes/bully_heroes_basic/vinny/bully_heroes_vinny.tscn")
const TEAM_HEROES_BOT = preload("res://scenes/interface_base/battlesim/heroes/team_heroes_basic/team_heroes_bot/team_heroes_bot.tscn")
const TEAM_HEROES_TOP = preload("res://scenes/interface_base/battlesim/heroes/team_heroes_basic/team_heroes_top/team_heroes_top.tscn")
const BUDDY_NEXUS = preload("res://scenes/interface_base/battlesim/nexus_basic/buddy_nexus.tscn")
const BULLY_NEXUS = preload("res://scenes/interface_base/battlesim/nexus_basic/bully_nexus.tscn")
const BUDDY_TOWER = preload("res://scenes/interface_base/battlesim/tower_basic/buddy_tower.tscn")
const BULLY_TOWER = preload("res://scenes/interface_base/battlesim/tower_basic/bully_tower.tscn")

@onready var team_nexus_position = %TeamNexusPosition
@onready var enemy_nexus_position = %EnemyNexusPosition
@onready var enemy_tower_top = %EnemyTowerTop
@onready var enemy_tower_bot = %EnemyTowerBot
@onready var friendly_tower_top = %FriendlyTowerTop
@onready var friendly_tower_bot = %FriendlyTowerBot
@onready var respawn_enemy = %RespawnEnemy
@onready var respawn_team = %RespawnTeam
@onready var towers = %Towers
@onready var nexus = %Nexus
@onready var bully_heroes = %BullyHeroes
@onready var team_heroes = %TeamHeroes

var game_launced := false
var old_enemy_modifier := 1.0
var new_enemy_modifier := 1.0

func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)
	await get_tree().physics_frame
	on_battle_end(false)
	game_launced = true

func on_battle_end(win: bool) -> void:
	var objects_to_be_cleared = get_tree().get_nodes_in_group("restart_map")
	var nodes_to_update = get_tree().get_nodes_in_group("update_post_match")
	
	for object in objects_to_be_cleared:
		if object.has_method("new_game"):
			object.new_game()
	
	new_enemy_modifier = randf_range(0.8, 1.2)
	spawn_enemy_team()
	spawn_friendly_team()
	
	if game_launced:
		RewardManager.on_battle_end(win, old_enemy_modifier)
		for node in nodes_to_update:
			if node.has_method("update"):
				node.update()
	
	old_enemy_modifier = new_enemy_modifier
	
func spawn_enemy_team() -> void:
	spawn_enemy_nexus()
	spawn_enemy_towers()
	spawn_enemy_heroes()

func spawn_enemy_nexus() -> void:
	var enemy_nexus = BULLY_NEXUS.instantiate()
	enemy_nexus.global_position = enemy_nexus_position.global_position
	nexus.add_child(enemy_nexus)

func spawn_enemy_towers() -> void:
	var top_tower = BULLY_TOWER.instantiate()
	top_tower.global_position = enemy_tower_top.global_position
	towers.add_child(top_tower)
	
	var bot_tower = BULLY_TOWER.instantiate()
	bot_tower.global_position = enemy_tower_bot.global_position
	towers.add_child(bot_tower)

func spawn_enemy_heroes() -> void:
	var bully1 = BULLY_HEROES_SHEILA.instantiate()
	bully1.apply_match_modifier(new_enemy_modifier)
	bully1.global_position = enemy_nexus_position.global_position
	bully_heroes.add_child(bully1)
	
	var bully2 = BULLY_HEROES_VINNY.instantiate()
	bully2.apply_match_modifier(new_enemy_modifier)
	bully2.global_position = enemy_nexus_position.global_position
	bully_heroes.add_child(bully2)
	
func spawn_friendly_team() -> void:
	spawn_friendly_nexus()
	spawn_friendly_towers()
	spawn_friendly_heroes()

func spawn_friendly_nexus() -> void:
	var friendly_nexus = BUDDY_NEXUS.instantiate()
	friendly_nexus.global_position = team_nexus_position.global_position
	nexus.add_child(friendly_nexus)

func spawn_friendly_towers() -> void:
	var top_tower = BUDDY_TOWER.instantiate()
	top_tower.global_position = friendly_tower_top.global_position
	towers.add_child(top_tower)
	
	var bot_tower = BUDDY_TOWER.instantiate()
	bot_tower.global_position = friendly_tower_bot.global_position
	towers.add_child(bot_tower)

func spawn_friendly_heroes() -> void:
	var hero1 = TEAM_HEROES_TOP.instantiate()
	#TEAM_HEROES_TOP.setup()
	hero1.global_position = team_nexus_position.global_position
	team_heroes.add_child(hero1)
	
	var hero2 = TEAM_HEROES_BOT.instantiate()
	hero2.global_position = team_nexus_position.global_position
	team_heroes.add_child(hero2)

func get_match_modifier() -> float:
	return new_enemy_modifier
