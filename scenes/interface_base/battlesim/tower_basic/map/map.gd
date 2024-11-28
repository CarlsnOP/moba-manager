extends Control


@onready var match_timer_label: Label = %MatchTimerLabel
@onready var match_timer: Timer = %MatchTimer

var elapsed_time := 0
var previous_game_length := 0


func _ready() -> void:
	match_timer.start() 

#called when new game starts
func update() -> void:
	previous_game_length = elapsed_time
	elapsed_time = 0


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
