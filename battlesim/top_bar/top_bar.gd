class_name TopBar
extends Control

@export var top_bar_slot: PackedScene

@onready var team_hb = %TeamHB
@onready var enemy_hb = %EnemyHB
@onready var match_timer_label: Label = %MatchTimerLabel
@onready var match_timer: Timer = %MatchTimer

#called when new game starts
func update() -> void:
	if match_timer.is_stopped():
		match_timer.start() 
	#wait for old game to end
	await get_tree().create_timer(0.2).timeout
	MatchDataManager.update()
	
	#wait for match to have been setup
	await get_tree().create_timer(0.2).timeout
	setup_top_bar_slots()

func setup_top_bar_slots() -> void:
	var i = 0
	for hero in MatchDataManager.array_of_hero_dics:
		var slot = top_bar_slot.instantiate()
		if i < 2:
			team_hb.add_child(slot)
		else:
			enemy_hb.add_child(slot)
		slot.display(hero)
		slot.add_to_group("restart_map")
		i += 1
		

func _on_match_timer_timeout() -> void:
	MatchDataManager.time_left -= 1
	MatchDataManager.elapsed_time += 1
	update_match_clock()
	if MatchDataManager.time_left < 1:
		SignalManager.on_battle_end.emit(false)

func update_match_clock() -> void:
	var minutes = floor(MatchDataManager.time_left / 60)
	var seconds = int(MatchDataManager.time_left) % 60
	match_timer_label.text = "%02d:%02d" % [minutes, seconds]
