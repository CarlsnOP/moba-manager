class_name TopBar
extends Control

@export var top_bar_slot: PackedScene

@onready var top_bar_hb = %TopBarHB
@onready var match_timer_label: Label = %MatchTimerLabel
@onready var match_timer: Timer = %MatchTimer


func _ready() -> void:
	match_timer.start() 

	#wait for match to have been setup
	await get_tree().create_timer(0.2).timeout
	setup_top_bar_slots()

#called when new game starts
func update() -> void:
	MatchDataManager.update()


func setup_top_bar_slots() -> void:
	for hero in MatchDataManager.array_of_hero_dics:
		var slot = top_bar_slot.instantiate()
		top_bar_hb.add_child(slot)
		slot.display(hero)
		slot.add_to_group("restart_map")
		

func _on_match_timer_timeout() -> void:
	MatchDataManager.elapsed_time += 1
	update_match_clock()

func update_match_clock() -> void:
	var minutes = floor(MatchDataManager.elapsed_time / 60)
	var seconds = int(MatchDataManager.elapsed_time) % 60
	match_timer_label.text = "%02d:%02d" % [minutes, seconds]
