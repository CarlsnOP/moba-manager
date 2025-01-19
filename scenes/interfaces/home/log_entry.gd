extends Control

@onready var dead_label: Label = %DeadLabel
@onready var killer_label: Label = %KillerLabel
@onready var info_label: Label = %InfoLabel
@onready var background: PanelContainer = %Background

var saved_amount: int

func new_log(dead: String, killer: String) -> void:
	dead_label.text = "%s" % dead
	killer_label.text = "%s" % killer

func set_colors_bully_dead() -> void:
	dead_label.modulate = Color.RED
	killer_label.modulate = Color.GREEN

func set_colors_buddy_dead() -> void:
	dead_label.modulate = Color.GREEN
	killer_label.modulate = Color.RED
