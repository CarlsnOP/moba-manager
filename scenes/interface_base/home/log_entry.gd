extends Control

@onready var log_label = %LogLabel

func new_log(amount: int) -> void:
	log_label.text = "Rubberduckies earned: %s" % amount
