extends Control

@onready var dead_label: Label = %DeadLabel
@onready var killer_label: Label = %KillerLabel
@onready var info_label: Label = %InfoLabel
@onready var match_time_label: Label = %MatchTimeLabel
@onready var background: PanelContainer = %Background

var saved_amount: int
var elapsed_time := 0

func _ready() -> void:
	var map = get_tree().get_first_node_in_group("map")
	elapsed_time = map.elapsed_time

func update_match_clock() -> void:
	var minutes = elapsed_time / 60
	var seconds = elapsed_time % 60
	match_time_label.text = "%02d:%02d" % [minutes, seconds]

func new_log(dead: String, killer: String) -> void:
	dead_label.text = "%s" % dead
	killer_label.text = "%s" % killer
	update_match_clock()

func set_colors_bully_dead() -> void:
	dead_label.modulate = Color.RED
	killer_label.modulate = Color.GREEN
	background.modulate = Color.LIME_GREEN

func set_colors_buddy_dead() -> void:
	dead_label.modulate = Color.GREEN
	killer_label.modulate = Color.RED
	background.modulate = Color.INDIAN_RED
