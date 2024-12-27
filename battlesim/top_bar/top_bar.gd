class_name TopBar
extends Control

@onready var team_hero_1 = %TeamHero1
@onready var team_hero_2 = %TeamHero2
@onready var enemy_hero_1 = %EnemyHero1
@onready var enemy_hero_2 = %EnemyHero2

@onready var match_timer_label: Label = %MatchTimerLabel
@onready var match_timer: Timer = %MatchTimer

var elapsed_time := 0
var previous_game_length := 0
var new_game_manager: NewGameManager

func _ready() -> void:
	match_timer.start() 
	new_game_manager = get_tree().get_first_node_in_group("new_game_manager")
	
	#wait for match to have been setup
	await get_tree().create_timer(0.2).timeout
	setup_icons()

#called when new game starts
func update() -> void:
	previous_game_length = elapsed_time
	elapsed_time = 0
	setup_icons()

func setup_icons() -> void:
	team_hero_1.texture = TeamManager.top.hero_portrait
	team_hero_2.texture = TeamManager.bot.hero_portrait
	enemy_hero_1.texture = new_game_manager.enemy1.hero_portrait
	enemy_hero_2.texture = new_game_manager.enemy2.hero_portrait
	
func _on_match_timer_timeout() -> void:
	elapsed_time += 1
	SignalManager.match_elapsed_time.emit(elapsed_time)
	update_match_clock()

func update_match_clock() -> void:
	var minutes = floor(elapsed_time / 60)
	var seconds = int(elapsed_time) % 60
	match_timer_label.text = "%02d:%02d" % [minutes, seconds]

func get_game_length() -> int:
	return previous_game_length
