extends Node

const DEFAULT_HERO_DATA: Dictionary = {
	"hero_node": null,
	"hero_portrait": null,
	"hero_ability": null,
	"kills": 0,
	"deaths": 0
}

var array_of_hero_dics: Array = []
var elapsed_time := 0
var previous_game_length := 0

var team_hero1: Dictionary = DEFAULT_HERO_DATA.duplicate()
var team_hero2: Dictionary = DEFAULT_HERO_DATA.duplicate()
var enemy_hero1: Dictionary = DEFAULT_HERO_DATA.duplicate()
var enemy_hero2: Dictionary = DEFAULT_HERO_DATA.duplicate()

func _ready():
	array_of_hero_dics.append(team_hero1)
	array_of_hero_dics.append(team_hero2)
	array_of_hero_dics.append(enemy_hero1)
	array_of_hero_dics.append(enemy_hero2)
	SignalManager.event.connect(on_event)
	
	await get_tree().create_timer(0.1).timeout
	setup_hero_nodes()

func update() -> void:
	previous_game_length = MatchDataManager.elapsed_time
	elapsed_time = 0
	set_heroes_to_null()
	setup_hero_nodes()

func set_heroes_to_null() -> void:
	for hero in array_of_hero_dics:
		for key in hero.keys():
			if key in DEFAULT_HERO_DATA:
				hero[key] = DEFAULT_HERO_DATA[key]

func setup_hero_nodes() -> void:
	var heroes = get_tree().get_nodes_in_group("hero")
	
	for hero in heroes:
		if hero.is_in_group("team"):
			if team_hero1["hero_node"] == null:
				team_hero1["hero_node"] = hero
				team_hero1["hero_portrait"] = hero.get_hero_resource().hero_portrait
			else:
				team_hero2["hero_node"] = hero
				team_hero2["hero_portrait"] = hero.get_hero_resource().hero_portrait
		else:
			if enemy_hero1["hero_node"] == null:
				enemy_hero1["hero_node"] = hero
				enemy_hero1["hero_portrait"] = hero.get_hero_resource().hero_portrait
			else:
				enemy_hero2["hero_node"] = hero
				enemy_hero2["hero_portrait"] = hero.get_hero_resource().hero_portrait

func on_event(actor: PhysicsBody2D, killer: PhysicsBody2D) -> void:
	handle_death(actor)
	handle_killer(killer)

func handle_death(actor: PhysicsBody2D) -> void:
	for hero in array_of_hero_dics:
		if hero["hero_node"] == actor:
			hero["deaths"] += 1

func handle_killer(killer: PhysicsBody2D) -> void:
	for hero in array_of_hero_dics:
		if hero["hero_node"] == killer:
			hero["kills"] += 1
